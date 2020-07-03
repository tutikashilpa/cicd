package(default_visibility = ["//visibility:public"])
#load("@subpar//:subpar.bzl", "par_binary")
#
#par_binary(
#    name = 'bigquery_github_trends',
#    srcs = ["bigquery_github_trends.py"],
#    main = "bigquery_github_trends.py"
#)


load("@bazel_tools//tools/build_defs/pkg:pkg.bzl", "pkg_tar", "pkg_deb")

#pkg_tar(
#    name = "bazel-bin",
#    strip_prefix = "/src",
#    package_dir = "/usr/bin",
#    srcs = ["//src:bazel"],
#    mode = "0755",
#)

pkg_tar(
    name = "bazel-tools",
    strip_prefix = "/",
    package_dir = "/usr/share/lib/bazel/tools",
    srcs = ["//bigquery_pipeline:config"],
    mode = "0644",
    modes = {"tools/build_defs/docker/build_test.sh": "0755"},
)

pkg_tar(
    name = "debian-data",
    extension = "tar.gz",
    deps = [
#        ":bazel-bin",
        ":bazel-tools",
    ],
)

pkg_deb(
    name = "bazel-debian",
    architecture = "amd64",
    built_using = "bazel (0.1.1)",
    data = ":debian-data",
    depends = [
        "zlib1g-dev",
        "unzip",
    ],
    description = "debian package for python files",
    homepage = "http://bazel.build",
    maintainer = "The Bazel Authors <bazel-dev@googlegroups.com>",
    package = "bazel",
    version = "0.1.1",
)