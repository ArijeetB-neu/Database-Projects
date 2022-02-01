# Project: Data Lake

## Introduction

Sparkify, a music streaming company has grown their user base and song database even more and want to move their data warehouse to a data lake. Their data resides in S3, in a directory of JSON logs on user activity on the app, as well as a directory with JSON metadata on the songs in their app.

In this project, we will build an ETL pipeline that extracts their data from the data lake hosted on S3, processes them using Spark which will be deployed on an EMR cluster using AWS, and load the data back into S3 as a set of dimensional tables in parquet format.

From this tables we will be able to find insights in what songs their users are listening to.

## How to run

*To run this project in local mode*, create a file `dl.cfg` in the root of this project with the following data:

```
KEY=YOUR_AWS_ACCESS_KEY
SECRET=YOUR_AWS_SECRET_KEY
```


Finally, run the following command:

`python etl.py`


## Project structure

The files found at this project are the following:

- dl.cfg: File with AWS credentials.
- etl.py: Program that extracts songs and log data from S3, transforms it using Spark, and loads the dimensional tables created in parquet format back to S3.
- README.md: Current file, contains detailed information about the project.

## ETL pipeline

1. Load credentials
2. Read data from S3
    - Song data
    - Log data

    The script reads song_data and load_data from S3.

3. Process data using spark

    Transforms them to create five different tables listed under `Dimension Tables and Fact Table`.
    Each table includes the right columns and data types. Duplicates are addressed where appropriate.

4. Load it back to S3

    Writes them to partitioned parquet files in table directories on S3.

    Each of the five tables are written to parquet files in a separate analytics directory on S3. Each table has its own folder within the directory. Songs table files are partitioned by year and then artist. Time table files are partitioned by year and month. Songplays table files are partitioned by year and month.

### Source Data
- **Song datasets**: all json files are nested in subdirectories. A sample of this files is:

```
{"num_songs": 1, "artist_id": "ARJIE2Y1187B994AB7", "artist_latitude": null, "artist_longitude": null, "artist_location": "", "artist_name": "Line Renaud", "song_id": "SOUPIRU12A6D4FA1E1", "title": "Der Kleine Dompfaff", "duration": 152.92036, "year": 0}
```

- **Log datasets**: all json files are nested in subdirectories. A sample of a single row of each files is:

```
{"artist":"Slipknot","auth":"Logged In","firstName":"Aiden","gender":"M","itemInSession":0,"lastName":"Ramirez","length":192.57424,"level":"paid","location":"New York-Newark-Jersey City, NY-NJ-PA","method":"PUT","page":"NextSong","registration":1540283578796.0,"sessionId":19,"song":"Opium Of The People (Album Version)","status":200,"ts":1541639510796,"userAgent":"\"Mozilla\/5.0 (Windows NT 6.1) AppleWebKit\/537.36 (KHTML, like Gecko) Chrome\/36.0.1985.143 Safari\/537.36\"","userId":"20"}
```

### Fact Tables

**songplays** - records in event data associated with song plays i.e. records with page NextSong songplay_id, start_time, user_id, level, song_id, artist_id, session_id, location, user_agent

### Dimension Tables

**users** - users in the app user_id, first_name, last_name, gender, level

**songs** - songs in music database song_id, title, artist_id, year, duration

**artists** - artists in music database artist_id, name, location, lattitude, longitude

**time** - timestamps of records in songplays broken down into specific units start_time, hour, day, week, month, year, weekday
