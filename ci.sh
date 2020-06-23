#!/usr/bin/env bash

echo $(pwd)

#COMMIT_RANGE=${COMMIT_RANGE:-$(git merge-base origin/master HEAD)".."}
#commit_sha=$(git rev-parse HEAD)
#echo "$commit_sha"

#echo "$COMMIT_RANGE"
## Go to the root of the repo
#cd "$(git rev-parse --show-toplevel)"
echo "$(pwd)"
# Get a list of the current files in package form by querying Bazel.
files=()

#for file in $(git diff --name-only ${COMMIT_RANGE} ); do
for file in $(git show --pretty='format:' --name-only $commit_sha);do
#for file in */;do
    echo "hello inside"
    echo "bazel query ${file}"
    files+=($(bazel query $file))
    echo "files:  ${files}"

done

echo "out of loop"
# Query for the associated buildables
buildables=$(bazel query \
    --keep_going \
    --noshow_progress \
    "kind(.*_binary, rdeps(//..., set(${files[*]})))")
echo "out of builables"
# Run the tests if there were results
if [[ ! -z $buildables ]]; then
  echo "Building binaries"
  echo "$buildables"
#  bazel build $buildables
fi

#tests=$(bazel query \
#    --keep_going \
#    --noshow_progress \
#    "kind(test, rdeps(//..., set(${files[*]}))) except attr('tags', 'manual', //...)")
# Run the tests if there were results
#if [[ ! -z $tests ]]; then
#  echo "Running tests"
#  bazel test $tests
#fi
