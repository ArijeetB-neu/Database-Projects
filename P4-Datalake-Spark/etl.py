import configparser
from datetime import datetime
import os
from pyspark.sql import SparkSession
from pyspark.sql.functions import udf, col
from pyspark.sql.functions import year, month, dayofmonth, hour, weekofyear, date_format
from pyspark.sql.types import StructType as R, StructField as Fld, DoubleType as Dbl, StringType as Str, IntegerType as Int, DateType as Dat, TimestampType

config = configparser.ConfigParser()
config.read('dl.cfg')

os.environ['AWS_ACCESS_KEY_ID']=config.get('AWS','AWS_ACCESS_KEY_ID')
os.environ['AWS_SECRET_ACCESS_KEY']=config.get('AWS','AWS_SECRET_ACCESS_KEY')


def create_spark_session():
    spark = SparkSession \
        .builder \
        .config("spark.jars.packages", "org.apache.hadoop:hadoop-aws:2.7.0") \
        .getOrCreate()
    return spark


def process_song_data(spark, input_data, output_data):
    """
        Description: This function loads song_data from S3 and processes it by extracting the songs and artist tables
        and then again load it back to S3
        
        Parameters:
            spark       : this is the Spark Session
            input_data  : the location of song_data from where the file is loaded to process
            output_data : the location where after processing the results will be stored
            
    """
    
    # get filepath to song data file
    song_data = input_data + 'song_data/*/*/*/*.json'
    
    #define schema of song data
    songSchema = R ([
        Fld("song_id",Int()),
        Fld("artist_id",Str()),
        Fld("artist_latitude",Dbl()),
        Fld("artist_location",Str()),
        Fld("artist_longitude",Dbl()),
        Fld("artist_name",Str()),
        Fld("duration",Dbl()),
        Fld("num_songs",Int()),
        Fld("title",Str()),
        Fld("year",Int()),    
    ])
    
    # read song data file
    df = spark.read.json(song_data, songSchema).dropDuplicates()
    
    # created song view to write SQL Queries
    df.createOrReplaceTempView("song_data_table")
    
    # extract columns to create songs table
    songs_table = spark.sql("""
                            SELECT song_id, 
                            title,
                            artist_id,
                            year,
                            duration
                            FROM song_data_table 
                            WHERE song_id IS NOT NULL
                        """)
    
    # write songs table to parquet files partitioned by year and artist
    songs_table.write.mode('overwrite').partitionBy("year", "artist_id").parquet(output_data+'songs_table/')

    # extract columns to create artists table
    artists_table =spark.sql("""
                                SELECT DISTINCT artist_id, 
                                artist_name,
                                artist_location,
                                artist_latitude,
                                artist_longitude
                                FROM song_data_table
                                WHERE artist_id IS NOT NULL
                            """) 
    
    # write artists table to parquet files
    artists_table.write.mode('overwrite').parquet(output_data+'artists_table/')


def process_log_data(spark, input_data, output_data):
    """
        Description: This function loads log_data from S3 and processes it by extracting the songs and artist tables
        and then again loaded back to S3. Also output from previous function is used in by spark.read.json command
        
        Parameters:
            spark       : Spark Session
            input_data  : location of log_data json files with the events data
            output_data : S3 bucket were dimensional tables in parquet format will be stored
            
    """
    # get filepath to log data file
    log_data = input_data + 'log-data/*.json'
    LogDataSchema = R([
        Fld("artist",Str()),
        Fld("auth",Str()),
        Fld("firstName",Str()),
        Fld("gender",Str()),
        Fld("itemInSession",Int()),
        Fld("lastName",Str()),
        Fld("length",Dbl()),
        Fld("level",Str()),
        Fld("location",Str()),
        Fld("method",Str()),
        Fld("page",Str()),
        Fld("registration",Dbl()),
        Fld("sessionId",Int()),
        Fld("song",Str()),
        Fld("status",Int()),
        Fld("ts",Int()),
        Fld("userAgent",Str()),
        Fld("userId",Str()),
    ])
    # read log data file
    df = spark.read.json(log_data, schema=LogDataSchema).dropDuplicates()
    
    # filter by actions for song plays
    df = df.filter(df.page == 'NextSong')

    
    # created log view to write SQL Queries
    df.createOrReplaceTempView("log_data_table")
    
    # extract columns for users table    
    users_table = spark.sql("""
                            SELECT DISTINCT userId as user_id, 
                            firstName as first_name,
                            lastName as last_name,
                            gender,
                            level
                            FROM log_data_table
                            WHERE userId IS NOT NULL
                        """)
    
    # write users table to parquet files
    users_table.write.mode('overwrite').parquet(output_data+'users_table/')

    # create timestamp column from original timestamp column
    #get_timestamp = udf()
    #df = 
    
    # create datetime column from original timestamp column
    #get_datetime = udf()
    #df = 
    
    # extract columns to create time table
    time_table = spark.sql("""
                            SELECT 
                            A.start_time as Start_Time,
                            hour(A.start_time) as Hour,
                            dayofmonth(A.start_time) as Day,
                            weekofyear(A.start_time) as Week,
                            month(A.start_time) as Month,
                            year(A.start_time) as Year,
                            dayofweek(A.start_time) as Weekday
                            FROM
                            (SELECT to_timestamp(timest.ts/1000) as start_time
                            FROM log_data_table timest
                            WHERE timest.ts IS NOT NULL
                            ) A
                        """)
    
    # write time table to parquet files partitioned by year and month
    time_table.write.mode('overwrite').partitionBy("year", "month").parquet(output_data+'time_table/')

    # extract columns from joined song and log datasets to create songplays table 
    songplays_table = spark.sql("""
                                SELECT monotonically_increasing_id() as songplay_id,
                                to_timestamp(logtab.ts/1000) as start_time,
                                month(to_timestamp(logtab.ts/1000)) as month,
                                year(to_timestamp(logtab.ts/1000)) as year,
                                logtab.userId as user_id,
                                logtab.level as level,
                                songtab.song_id as song_id,
                                songtab.artist_id as artist_id,
                                logtab.sessionId as session_id,
                                logtab.location as location,
                                logtab.userAgent as user_agent
                                FROM log_data_table logtab
                                JOIN song_data_table songtab on logtab.artist=songtab.artist_name and logtab.song=songtab.title
                            """)

    # write songplays table to parquet files partitioned by year and month
    songplays_table.write.mode('overwrite').partitionBy("year", "month").parquet(output_data+'songplays_table/')


def main():
    spark = create_spark_session()
    input_data = "s3a://udacity-dend/"
    output_data = ""
    
    process_song_data(spark, input_data, output_data)    
    process_log_data(spark, input_data, output_data)


if __name__ == "__main__":
    main()
