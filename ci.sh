#!/usr/bin/env bash

# Copyright 2015 The Bazel Authors. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


# This script looks at the files changed in git in a commit hash
# queries for all build and test targets associated with those files.
#
# Running this script on a CI server should allow you to only test the targets
# that have changed with the commit hash.
#

echo $(pwd)

COMMIT_RANGE=${COMMIT_RANGE:-$(git merge-base origin/master HEAD)".."}
commit_sha=$(git rev-parse HEAD)
echo "$commit_sha"

echo "$COMMIT_RANGE"
# Go to the root of the repo
cd "$(git rev-parse --show-toplevel)"
echo "$(pwd)"
# Get a list of the current files in package form by querying Bazel.
files=()

#for file in $(git diff --name-only ${COMMIT_RANGE} ); do
for file in $(git show --pretty='format:' --name-only $commit_sha);do
    files+=($(bazel query $file))
    echo $(bazel query $file)
done

echo $files
# Query for the associated buildables
buildables=$(bazel query \
    --keep_going \
    --noshow_progress \
    "kind(.*_binary, rdeps(//..., set(${files[*]})))")
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
