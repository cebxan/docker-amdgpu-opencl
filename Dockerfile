FROM ubuntu:20.04 AS base

ARG DEBIAN_FRONTEND=noninteractive

ENV TZ America/Caracas

LABEL Name=amdgpu-opencl
LABEL Version=1
LABEL maintainer="Carlos Berroteran (cebxan)"

RUN apt-get -y update && apt-get install -y --no-install-recommends \
    ca-certificates \
    tzdata \
    curl \
    xz-utils \
    libpci3

FROM base

ARG AMD_SITE_URL="https://drivers.amd.com/drivers/linux/"
ARG PREFIX="amdgpu-pro-"
ARG POSTFIX="-ubuntu-20.04"
ARG VERSION_MAJOR="20.50"
ARG VERSION_MINOR="1234664"
ARG AMDGPU_VERSION="${PREFIX}${VERSION_MAJOR}-${VERSION_MINOR}${POSTFIX}"

RUN curl --referer ${AMD_SITE_URL} -O ${AMD_SITE_URL}${AMDGPU_VERSION}.tar.xz \
    && tar -Jxvf ${AMDGPU_VERSION}.tar.xz \
    && ${AMDGPU_VERSION}/amdgpu-install -y --opencl=legacy --headless --no-dkms --no-32 \
    && rm -rf amdgpu-pro-* /var/opt/amdgpu-pro-local /var/lib/apt/lists/*