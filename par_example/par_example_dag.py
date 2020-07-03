from airflow import DAG
from airflow.operators import BashOperator,PythonOperator
from datetime import datetime, timedelta

seven_days_ago = datetime.combine(datetime.today() - timedelta(7),
                                  datetime.min.time())

default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': seven_days_ago,
    'email': ['airflow@airflow.com'],
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

dag = DAG('simple', default_args=default_args)
par_file="gs://us-central1-data-pipeline-c-e9016171-bucket/dags/app"
print("par_file: "+par_file)
t1 = BashOperator(
    task_id='testairflow',
    bash_command='/home/airflow/gcs/dags/app',
    dag=dag)