FROM ubuntu:20.04 AS base

ARG DEBIAN_FRONTEND=noninteractive

ENV TZ America/Caracas

LABEL Name=amdgpu-legacy
LABEL Version=0.1

RUN apt-get -y update && apt-get install -y --no-install-recommends \
    ca-certificates \
    tzdata \
    curl \
    xz-utils \
    libpci3

FROM base AS amdgpu-legacy-base
ARG AMD_SITE_URL="https://drivers.amd.com/drivers/linux/"
ARG AMDGPU_VERSION="amdgpu-pro-20.45-1188099-ubuntu-20.04"

RUN curl --referer ${AMD_SITE_URL} -O ${AMD_SITE_URL}${AMDGPU_VERSION}.tar.xz \
    && tar -Jxvf ${AMDGPU_VERSION}.tar.xz \
    && ${AMDGPU_VERSION}/amdgpu-install -y --opencl=legacy --headless --no-dkms --no-32 \
    && rm -rf amdgpu-pro-* /var/opt/amdgpu-pro-local /var/lib/apt/lists/*