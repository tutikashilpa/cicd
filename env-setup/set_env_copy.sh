#!/usr/bin/env bash
export TEST='test'
export GCP_PROJECT_ID=$(gcloud config list --format 'value(core.project)')
export PROJECT_NUMBER=$(gcloud projects describe "${GCP_PROJECT_ID}" --format='get(projectNumber)')
export DATAFLOW_JAR_BUCKET_TEST="${GCP_PROJECT_ID}-composer-dataflow-source-${TEST}"
export INPUT_BUCKET_TEST="${GCP_PROJECT_ID}-composer-input-${TEST}"
export RESULT_BUCKET_TEST="${GCP_PROJECT_ID}-composer-result-${TEST}"
export REF_BUCKET_TEST="${GCP_PROJECT_ID}-composer-ref-${TEST}"
export DATAFLOW_STAGING_BUCKET_TEST="${GCP_PROJECT_ID}-dataflow-staging-${TEST}"
export COMPOSER_REGION='us-central1'
export RESULT_BUCKET_REGION="${COMPOSER_REGION}"
export COMPOSER_ZONE_ID='us-central1-a'
export COMPOSER_ENV_NAME='data-pipeline-composer'
export SOURCE_CODE_REPO='data-pipeline-source'
export COMPOSER_DAG_NAME_TEST='test_word_count'
export COMPOSER_DAG_NAME_PROD='prod_word_count'
