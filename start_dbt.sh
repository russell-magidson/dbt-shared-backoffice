#!/bin/bash
source ../.venv/bin/activate
gcloud config set project us-atlantadbt-dev-94e0
export DBT_PROFILES_DIR=.
if [ $DBT_PROFILES_DIR == . ]
then
    echo "DBT export set up is ok: $DBT_PROFILES_DIR - You can start working with DBT."
else
    echo "Execute the instruction in the shell: export DBT_PROFILES_DIR=."
fi
