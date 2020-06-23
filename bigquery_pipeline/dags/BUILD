package(default_visibility = ["//visibility:public"])
load("@subpar//:subpar.bzl", "par_binary")

par_binary(
    name = 'bigquery_github_trends',
    srcs = ["dags/bigquery_github_trends.py"],
    main = "dags/bigquery_github_trends.py"

)

#py_binary(
#    name = "bigquery",
#    srcs = glob(["bigquery_pipeline/dags/bigquery_github_trends.py"]),
#    deps = [],
#)

#To clean cache run
# bazel clean --expunge
