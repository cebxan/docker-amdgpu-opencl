FROM ubuntu:20.04 AS base

ARG DEBIAN_FRONTEND=noninteractive

ENV TZ America/Caracas

LABEL Name=amdgpu-opencl
LABEL Version=20.04
LABEL maintainer="Carlos Berroteran (cebxan)"

RUN apt-get -y update && apt-get install -y --no-install-recommends \
    ca-certificates \
    tzdata \
    curl \
    xz-utils \
    libpci3 \
    && rm -rf /var/lib/apt/lists/*

ARG AMD_SITE_URL="https://drivers.amd.com/drivers/linux/"
ARG PREFIX="amdgpu-pro-"
ARG POSTFIX="-ubuntu-20.04"
ARG VERSION_MAJOR="20.40"
ARG VERSION_MINOR="1147286"
ARG AMDGPU_VERSION="${PREFIX}${VERSION_MAJOR}-${VERSION_MINOR}${POSTFIX}"

WORKDIR /tmp

RUN curl --referer ${AMD_SITE_URL} -O ${AMD_SITE_URL}${AMDGPU_VERSION}.tar.xz \
    && tar -Jxvf ${AMDGPU_VERSION}.tar.xz \
    && ${AMDGPU_VERSION}/amdgpu-install -y --opencl=pal,legacy --headless --no-dkms \
    && rm -rf amdgpu-pro-* /var/opt/amdgpu-pro-local