#!/usr/bin/env bash

files=()
targets=()
for file in $(git show --pretty='format:' --name-only $commit_sha);do
#for file in */;do
  dir=$(dirname "${file}")

  while true
  do
    echo "dir is $dir"
    lines=$(find ${dir} -name "BUILD.bazel"  | wc -l)
    if [ $lines -eq 0 ]; then
      echo " Empty ... $dir"
      dir=$(dirname "${dir}")
    else
      echo "not empty ..."
      target=$dir
      echo "target is $target"
      break
    fi
  done

  files+=$(bazel query 'attr(visibility, "public",//'"${target}"':*)')
  echo "files ... ${files}"
  targets+=${target}
  echo "targets ... ${targets}"

done

# Query for the associated buildables
buildables=$(bazel query \
    --keep_going \
    --noshow_progress \
    "kind(.*, rdeps(//..., set(${files[*]})))")
echo "Buildables .... $buildables"

if [[ ! -z $buildables ]]; then
    echo "Load variables"
    ./load_var.sh ${targets}

    bazel build $buildables

#    echo "check source code type"
#    code_type=$(./check_source_file.sh "$buildables")
#    echo $code_type
#
#    if [ "$code_type" == "python" ]; then
#        echo "Building par file: $buildables".par
#        buildable="$buildables"
#        echo "buildables is $buildables"
#        bazel build $buildable
#    fi
#
#    if [ "$code_type" == "java" ]; then
#        echo "Building jar file: $buildables".jar
#        buildable="$buildables"_deploy.jar
#        bazel build $buildable
#        echo ${pwd}
#    fi

fi

#build_path=$(bazel query 'attr(visibility, "BUILD_VISIBILITY",//etls/evaluation/game-1:*)')
#echo $build_path
#for i in $(find etls -type d)
#do
##    echo "$i"
#    find $i -name "BUILD.bazel"
#done

#etls/evaluation/game-1/game_event/workflow-dag/subdag.py

