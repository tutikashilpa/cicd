package(default_visibility = ["//visibility:public"])
java_library (
    name = "greeter",
    srcs = glob(["src/main/java/com/example/*.java"]),
    visibility = ["//pipeline5:__pkg__"]
)

java_binary (
    name = "Greeting",
    srcs = glob(["src/main/java/com/example/*.java"]),
    main_class = "com.example.Greetings",
    deps = ["//pipeline5:App1", "@maven//:org_apache_commons_commons_lang3"]
)
