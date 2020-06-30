#!/usr/bin/env bash
# Validate all DAGs in the running_dags.txt file using the Airflow environment.
# $1 variables-ENV.json file (string)
function validate_dags_and_variables() {

    FERNET_KEY=$(python3.6 -c "from cryptography.fernet import Fernet; \
        print(Fernet.generate_key().decode('utf-8'))")

    export FERNET_KEY

    airflow initdb

    # Import Airflow Variables to local Airflow.
    airflow variables --import variables/"$1"

    # Get current Cloud Composer custom connections.
    AIRFLOW_CONN_LIST=$($GCLOUD composer environments run "$ENVIRONMENT" \
        connections -- --list 2>&1 | grep "?\s" | awk '{ FS = "?"}; {print $2}' | \
        tr -d ' ' | sed -e "s/'//g" | grep -v '_default$' | \
        grep -v 'local_mysql' | tail -n +3 | grep -v "\.\.\.")

    # Upload custom connections to local Airflow with dummy values.
    for conn_id in $AIRFLOW_CONN_LIST; do
        airflow connections --add --conn_id "$conn_id" --conn_type http
    done

    RUNNING_DAGS=$(grep -iE "$DAGNAME_REGEX" < "$DAG_LIST_FILE")

    # Copy all RUNNING_DAGS to local Airflow dags folder for DAG validation.
    for dag_id in $RUNNING_DAGS; do
        cp "$dag_id".py /usr/local/airflow/dags
    done

    # List all DAGs running on local Airflow.
    LOCAL_AIRFLOW_LIST_DAGS=$(airflow list_dags | sed -e '1,/DAGS/d' | \
        tail -n +2 | sed '/^[[:space:]]*$/d'| \
        grep -iE ".+_dag_v[0-9]_[0-9]_[0-9]$")

    # Run DAG validation tests.
    python3.6 dag_validation_test.py "$LOCAL_AIRFLOW_LIST_DAGS"
}