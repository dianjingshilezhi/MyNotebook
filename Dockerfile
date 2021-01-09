FROM alpine:latest

MAINTAINER Yueshang Zuo <yueshangzuo@outlook.com>

RUN apk update
RUN apk add iperf3 bash iproute2 tcpdump
RUN apk add -X http://dl-cdn.alpinelinux.org/alpine/edge/testing tcpreplay
ADD iot_flows /iot_flows
