#package(default_visibility = ["//visibility:public"])
load("@my_deps//:requirements.bzl", "requirement")
load("@subpar//:subpar.bzl", "par_binary")

#load("@bazel_tools//tools/python:toolchain.bzl", "py_runtime_pair")
#
#py_runtime(
#    name = "py3_runtime",
#    interpreter_path = "C://Users/pravi/AppData/Local/Programs/Python/Python38/python",
#    python_version = "PY3",
#)
#py_runtime_pair(
#    name = "py_runtime_pair",
#    py3_runtime = ":py3_runtime",
#)
#toolchain(
#    name = "toolchain",
#    toolchain = ":py_runtime_pair",
#    toolchain_type = "@bazel_tools//tools/python:toolchain_type",
#)

par_binary(
  name = "app",
  srcs = [
    "app.py",
  ],
  main = "app.py",
  imports = ["."],
  deps = [
    requirement("psutil")
  ],
  visibility = ["//visibility:public"],
)