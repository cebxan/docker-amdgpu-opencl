# Docker AMDGPU OpenCL image

This Docker image is based on Ubuntu 20.04 and was compiled with support for legacy GPUs (Polaris and older) and ROCr (Vega and newer)

## Build

You can pull the latest version in your Dockerfile

```Dockerfile
FROM cebxan/amdgpu-opencl:latest
```

Or pull and specific tag

```Dockerfile
FROM cebxan/amdgpu-opencl:21.10-1247438
```

You can use it with multi-stage builds for smaller images

```Dockerfile
FROM ubuntu:20.04 AS base

WORKDIR /tmp

# run your steps to build your app

FROM cebxan/amdgpu-opencl:21.10-1247438

COPY --from=base /tmp/app/yourbinary /usr/local/bin/yourbinary
ENTRYPOINT ["yourbinary"]
```

## Usage

You have to use `--device=/dev/dri:/dev/dri` to access the GPU resource on Linux. For example:

```bash
docker run --rm --name amdgpu-example \
--device='/dev/dri:/dev/dri' \
-e TZ="America/Caracas" \
cebxan/amdgpu-opencl
```

The TZ environment variable is available to set your desired timezone.

No default command is defined because it's intended to be used as a base for other images.

## Support

This has only been tested with a **RX 580**. If you can confirm other GPUs, please let me know so I can create a list of tested cards.

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License

[MIT](https://choosealicense.com/licenses/mit/)
