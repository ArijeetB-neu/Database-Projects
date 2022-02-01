from airflow.hooks.postgres_hook import PostgresHook
from airflow.models import BaseOperator
from airflow.utils.decorators import apply_defaults

class LoadDimensionOperator(BaseOperator):

    ui_color = '#80BD9E'

    @apply_defaults
    def __init__(self,
                 redshift_conn_id="",
                 table_name="",
                 sql_query="",
                 truncate= True,
                 *args, **kwargs):

        super(LoadDimensionOperator, self).__init__(*args, **kwargs)
        self.redshift_conn_id = redshift_conn_id
        self.sql_query = sql_query
        self.table_name = table_name
        self.truncate = truncate

    def execute(self, context):
        """
          Insert data into dimensional tables from staging events and song data.
          Using a truncate-insert method to empty target tables prior to load.
        """
        redshift_hook=PostgresHook(postgres_conn_id=self.redshift_conn_id)
        if self.truncate:
            redshift_hook.run(f"TRUNCATE TABLE {self.table_name}")
        redshift_hook.run(self.sql_query)
        self.log.info(f"Dimension Table {self.table_name} loaded.")    