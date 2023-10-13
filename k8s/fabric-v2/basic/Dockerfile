# This image is a microservice in golang for the Degree chaincode
# FROM golang:1.14.6-alpine AS build

# ENV GOPROXY=https://goproxy.cn,direct

# COPY ./ /go/src/github.com/basic
# WORKDIR /go/src/github.com/basic

# # Build application
# RUN go build -o chaincode -v .

# # Production ready image
# # Pass the binary to the prod image
FROM ubuntu:20.04

# COPY --from=build /go/src/github.com/basic/chaincode /app/chaincode
COPY ./chaincode /app/chaincode

USER 1000

WORKDIR /app
CMD ./chaincode