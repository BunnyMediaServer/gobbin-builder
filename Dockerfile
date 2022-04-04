FROM golang:1.17.8
LABEL org.opencontainers.image.source="https://github.com/BunnyMediaServer/gobin-builder"
WORKDIR /builder
ENV BASE="/usr/local"
ENV UPX_VERSION="3.96"
ENV UPX_ZIP="upx-${UPX_VERSION}-amd64_linux.tar.xz"
ENV UPX_DIR="upx-${UPX_VERSION}-amd64_linux"
ENV UPX_URL="https://github.com/upx/upx/releases/download/v${UPX_VERSION}/${UPX_ZIP}"

# GIT as requirement in case I use this to compile private dependencies (not necessarily for BMS)
RUN apt-get update && apt-get install -y curl git xz-utils
RUN go get github.com/mitchellh/gox
# TODO: Install MacOS sdk?

# Install UPX (with our version constraint for stability)
RUN echo "Downloading UPX from: ${UPX_URL}"
RUN wget "${UPX_URL}"
RUN tar -Jxf "./${UPX_ZIP}" "${UPX_DIR}/upx"
RUN chmod 755 ./${UPX_DIR}/upx && chmod +x ./${UPX_DIR}/upx
RUN cp ./${UPX_DIR}/upx "${BASE}/bin/"
# Clean up
RUN rm -r ./${UPX_DIR}
RUN rm "${UPX_ZIP}"

# Check UPX is installed
RUN upx --version
