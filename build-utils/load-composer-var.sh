#!/usr/bin/env bash
#
# Copyright 2020 Google LLC.
#
# This software is provided as-is, without warranty or representation
# for any use or purpose. Your use of it is subject to your agreement with Google.

echo $(pwd)
cd cicd
# upload var files for dependecies
COMPOSER_DATA_FOLDER={2}
COMPOSER_NAME={3}
COMPOSER_LOCATION={4}
ENV_VARIABLES_JSON_FILE="etls/evaluation/game-1/game_event/workflow-dag/config/variables.json"
echo $COMPOSER_DATA_FOLDER
echo $COMPOSER_NAME
COMPOSER_GCS_BUCKET={5}
echo $COMPOSER_GCS_BUCKET

$(gsutil cp ${ENV_VARIABLES_JSON_FILE} ${COMPOSER_GCS_BUCKET}data)

$(gcloud composer environments run ${COMPOSER_NAME} \
    --location ${COMPOSER_LOCATION} variables -- \
    -i ${COMPOSER_DATA_FOLDER}/variables.json)

echo "Loaded variables into airflow"

#gcloud composer environments describe staging-data-pipeline-composer --location us-central1 | grep 'dagGcsPrefix' | grep -Eo "\S+/"
