# docker-bake.hcl
group "default" {
    targets = ["app"]
}

target "app" {
    context = "."
    dockerfile = "Dockerfile"
    tags = ["technoboggle/mysql-alpine:${MYSQL_VERSION}-${ALPINE_VERSION}", "technoboggle/mysql-alpine:${MYSQL_VERSION}", "technoboggle/mysql-alpine:latest"]
    args = {
        ALPINE_VERSION = "${ALPINE_VERSION}"
        MYSQL_VERSION = "${MYSQL_VERSION}"

        MAINTAINER_NAME = "${MAINTAINER_NAME}"
        AUTHORNAME = "${AUTHORNAME}"
        AUTHORS = "${AUTHORS}"
        VERSION = "${VERSION}"

        SCHEMAVERSION = "${SCHEMAVERSION}"
        NAME = "${NAME}"
        DESCRIPTION = "${DESCRIPTION}"
        URL = "${URL}"
        VCS_URL = "${VCS_URL}"
        VENDOR = "${VENDOR}"
        BUILDVERSION = "${BUILD_VERSION}"
        BUILD_DATE="${BUILD_DATE}"
        DOCKERCMD:"${DOCKERCMD}"
        USAGE:"${USAGE}"
    }
    platforms = ["linux/arm/v6", "linux/arm/v7", "linux/arm64/v8", "linux/arm64", "linux/armhf", "linux/amd64", "linux/386", "linux/s390x", "linux/ppc64le"]
    push = true
    cache = false
    progress = "plain"
}
