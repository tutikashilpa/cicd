EXECPATH=$(pwd)
BAZEL_WORKSPACE=${1}
ARTIFACTDIR=${2}
COMPOSER_DAG_BUCKET=${3}

cd ${BAZEL_WORKSPACE}
BRANCH_NAME="$(git rev-parse --abbrev-ref HEAD)"
COMMIT_SHA=$(git rev-parse HEAD)
ARTIFACT=${ARTIFACTDIR}/${BRANCH_NAME}_${COMMIT_SHA}.deb
echo "artifact ${ARTIFACT}"

deploy_artifact_to_dags_dir() {
  gsutil cp gs://BUCKET_NAME/OBJECT_NAME SAVE_TO_LOCATION
  tar -xvf ${ARTIFACT} data.tar.bz2 &&
  mkdir ./extract &&
  tar -xf data.tar.bz2 -C ./extract/ &&
  gsutil cp -r ./extract/* ${COMPOSER_DAG_BUCKET}
  echo "Extract complete... "
}

deploy_artifact_to_dags_dir