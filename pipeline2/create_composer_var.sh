#!/usr/bin/env bash
COMPOSER_DATA_FOLDER=/home/airflow/gcs/data
COMPOSER_NAME=data-pipeline-composer
COMPOSER_LOCATION=us-central1
ENV_VARIABLES_JSON_FILE=my_var.json
#COMPOSER_GCS_BUCKET=$(gcloud composer environments describe ${COMPOSER_NAME} --location ${COMPOSER_LOCATION} | grep 'dagGcsPrefix' | grep -Eo "\S+/")
COMPOSER_GCS_BUCKET=$(gcloud composer environments describe data-pipeline-composer --location us-central1 | grep 'dagGcsPrefix' | grep -Eo "\S+/")
echo $COMPOSER_GCS_BUCKET
gsutil cp my_var.json gs://us-central1-data-pipeline-c-e9016171-bucket/data
#echo $COMPOSER_DATA_FOLDER
gcloud composer environments run data-pipeline-composer --location us-central1 variables -- -i /home/airflow/gcs/data/my_var.json
#
#gcloud composer environments storage data import --source=pipeline2/var.json --environment="data-pipeline-composer" --location="us-central1"
#gcloud composer environments run data-pipeline-composer --location="us-central1" variables -- --i /home/airflow/gcs/data/var.json
