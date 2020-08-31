load("@rules_proto//proto:defs.bzl", "proto_library")
load("@rules_java//java:defs.bzl", "java_proto_library")
load("@build_stack_rules_proto//python:python_proto_library.bzl", "python_proto_library")

package(default_visibility = ["//visibility:public"])

proto_library(
    name = "game_event",
    srcs = [
        "game_event.proto",
    ],
)

java_proto_library(
    name = "game_event_java",
    deps = [":game_event"],
)

python_proto_library(
    name = "game_event_py",
    deps = [":game_event"],
)
