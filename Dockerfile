FROM golang:alpine

# GIT as requirement in case I use this to compile private dependencies (not necessarily for BMS)
RUN apk update && apk --no-cache add curl git && apk --no-cache add upx
RUN go get github.com/mitchellh/gox
# TODO: Install MacOS sdk?