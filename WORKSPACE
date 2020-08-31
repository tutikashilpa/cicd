workspace(name = "data")

# Load lib http_archive
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

# Import skylib
http_archive(
    name = "bazel_skylib",
    sha256 = "97e70364e9249702246c0e9444bccdc4b847bed1eb03c5a3ece4f83dfe6abc44",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.0.2/bazel-skylib-1.0.2.tar.gz",
        "https://github.com/bazelbuild/bazel-skylib/releases/download/1.0.2/bazel-skylib-1.0.2.tar.gz",
    ],
)

load("@bazel_skylib//:workspace.bzl", "bazel_skylib_workspace")

bazel_skylib_workspace()

http_archive(
    name = "rules_python",
    url = "https://github.com/bazelbuild/rules_python/releases/download/0.0.2/rules_python-0.0.2.tar.gz",
    strip_prefix = "rules_python-0.0.2",
    sha256 = "b5668cde8bb6e3515057ef465a35ad712214962f0b3a314e551204266c7be90c",
)

load("@rules_python//python:repositories.bzl", "py_repositories")

# Import rules_proto for python
http_archive(
    name = "build_stack_rules_proto",
    sha256 = "78e378237c6e7bd7cfdda155d4f7010b27723f26ebfa6345e79675bddbbebc11",
    strip_prefix = "rules_proto-56665373fe541d6f134d394624c8c64cd5652e8c",
    urls = ["https://github.com/stackb/rules_proto/archive/56665373fe541d6f134d394624c8c64cd5652e8c.tar.gz"],
)

load("@build_stack_rules_proto//python:deps.bzl", "python_proto_library")
python_proto_library()


# Import pip
# Importing pip dependencies https://github.com/bazelbuild/rules_python#using-the-packaging-rules
load("@rules_python//python:pip.bzl", "pip3_import", "pip_repositories")

pip_repositories()

# Define protobuf_py_deps for pip to install
pip3_import(
    name = "protobuf_py_deps",
    requirements = "@build_stack_rules_proto//python/requirements:protobuf.txt",
)

# Get dependencies for protobuf_py_deps and wrap it so pip can install it all
load("@protobuf_py_deps//:requirements.bzl", protobuf_pip_install = "pip_install")

protobuf_pip_install()

# Load git module
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository", "new_git_repository")

py_repositories()
pip_repositories()

#pip3_import(
#    name = "my_deps",
#    requirements = "//third_party/python:requirements.txt",
#)
#
#load("@my_deps//:requirements.bzl", my_deps_pip_install = "pip_install")
#
#my_deps_pip_install()

# Install custom lib for making one-file-py-executable
git_repository(
    name = "subpar",
    remote = "https://github.com/google/subpar",
    tag = "2.0.0",
)

# GOLANG section
http_archive(
    name = "io_bazel_rules_go",
    sha256 = "2d536797707dd1697441876b2e862c58839f975c8fc2f0f96636cbd428f45866",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/v0.23.5/rules_go-v0.23.5.tar.gz",
        "https://github.com/bazelbuild/rules_go/releases/download/v0.23.5/rules_go-v0.23.5.tar.gz",
    ],
)

load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")

go_rules_dependencies()

go_register_toolchains()

git_repository(
    name = "io_bazel_rules_wheel",
    remote = "https://github.com/georgeliaw/rules_wheel",
    tag = "v0.2.0",
)

# Link ap.schemas repository
new_git_repository(
    name = "ap_schemas_repo",
    remote = "git@gh.riotgames.com:InsightsTech/ap.schemas.git",
    branch = "master",
    build_file = "BUILD.ap.schemas"
)

http_archive(
    name = "bazel_gazelle",
    sha256 = "cdb02a887a7187ea4d5a27452311a75ed8637379a1287d8eeb952138ea485f7d",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/bazel-gazelle/releases/download/v0.21.1/bazel-gazelle-v0.21.1.tar.gz",
        "https://github.com/bazelbuild/bazel-gazelle/releases/download/v0.21.1/bazel-gazelle-v0.21.1.tar.gz",
    ],
)

load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies")

gazelle_dependencies()

# JAVA section
RULES_JVM_EXTERNAL_TAG = "3.3"
RULES_JVM_EXTERNAL_SHA = "d85951a92c0908c80bd8551002d66cb23c3434409c814179c0ff026b53544dab"

http_archive(
    name = "bazel_gazelle",
    sha256 = "cdb02a887a7187ea4d5a27452311a75ed8637379a1287d8eeb952138ea485f7d",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/bazel-gazelle/releases/download/v0.21.1/bazel-gazelle-v0.21.1.tar.gz",
        "https://github.com/bazelbuild/bazel-gazelle/releases/download/v0.21.1/bazel-gazelle-v0.21.1.tar.gz",
    ],
)

load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies")

gazelle_dependencies()

http_archive(
    name = "rules_jvm_external",
    sha256 = RULES_JVM_EXTERNAL_SHA,
    strip_prefix = "rules_jvm_external-%s" % RULES_JVM_EXTERNAL_TAG,
    url = "https://github.com/bazelbuild/rules_jvm_external/archive/%s.zip" % RULES_JVM_EXTERNAL_TAG,
)

#load("@rules_jvm_external//:defs.bzl", "maven_install")
#load("//third_party/java:library_deps.bzl", "DATA_MAVEN_ARTIFACTS")
#load("//third_party/java:artifactory.bzl", "USERNAME", "PASSWORD")

#maven_install(
#    artifacts = DATA_MAVEN_ARTIFACTS,
#    maven_install_json = "@data//third_party/java:maven_install.json",
#    repositories = [
#        "https://%s:%s@build-artifacts.riotgames.com:8443/nexus/content/groups/riot" % (USERNAME, PASSWORD),
#    ],
#    strict_visibility = True,
#    generate_compat_repositories = True
#)

#load("@maven//:defs.bzl", "pinned_maven_install")

#pinned_maven_install()

# Docker section
http_archive(
    name = "io_bazel_rules_docker",
    sha256 = "4521794f0fba2e20f3bf15846ab5e01d5332e587e9ce81629c7f96c793bb7036",
    strip_prefix = "rules_docker-0.14.4",
    urls = ["https://github.com/bazelbuild/rules_docker/releases/download/v0.14.4/rules_docker-v0.14.4.tar.gz"],
)

load("@io_bazel_rules_docker//repositories:repositories.bzl", container_repositories = "repositories",)
container_repositories()

load("@io_bazel_rules_docker//repositories:deps.bzl", container_deps = "deps")
container_deps()

load("@io_bazel_rules_docker//repositories:pip_repositories.bzl", "pip_deps")
pip_deps()

load("@io_bazel_rules_docker//container:pull.bzl", "container_pull")

container_pull(
    name = "openjdk8-jre-slim-stretch",
    registry = "index.docker.io",
    repository = "library/openjdk",
    tag = "8u212-jre-slim-stretch",
)

load("@io_bazel_rules_docker//toolchains/docker:toolchain.bzl",
    docker_toolchain_configure="toolchain_configure"
)

# Configure the docker toolchain.
docker_toolchain_configure(
  name = "docker_config",
  # Path to the directory which has a custom docker client config.json with
  # authentication credentials for registry.gitlab.com (used in this example).
  client_config="~/.docker/config.json",
)
