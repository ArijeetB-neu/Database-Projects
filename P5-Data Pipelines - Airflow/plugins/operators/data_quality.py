from airflow.hooks.postgres_hook import PostgresHook
from airflow.models import BaseOperator
from airflow.utils.decorators import apply_defaults

class DataQualityOperator(BaseOperator):

    ui_color = '#89DA59'

    @apply_defaults
    def __init__(self,
                 redshift_conn_id="",
                 tables=[],
                 *args, **kwargs):

        super(DataQualityOperator, self).__init__(*args, **kwargs)
        self.redshift_conn_id=redshift_conn_id
        self.tables=tables

    def execute(self, context):
        redshift=PostgresHook(self.redshift_conn_id)
        
        for table in self.tables:
            records=redshift.get_records(f"SELECT COUNT(*) FROM {table}")
            self.log.info('DataQualityOperator checking for row count')
            if len(records)<1 or len(records[0])<1:
                raise ValueError(f"Data quality check failed. {table} returned no results")
        
        dq_checks=[
            {'table': 'users',
             'check_sql': "SELECT COUNT(*) FROM users WHERE userid is null",
             'expected_result': 0},
            {'table': 'songs',
             'check_sql': "SELECT COUNT(*) FROM songs WHERE songid is null",
             'expected_result': 0}
        ]
        for check in dq_checks:
             records = redshift.get_records(check['check_sql'])[0]
             self.log.info('DataQualityOperator checking for Null ids')
             if records[0] != check['expected_result']:
                raise ValueError(f"Data quality check failed. {check['table']} contains null in id column, got {records[0]} instead")