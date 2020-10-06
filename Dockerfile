ARG BASE_IMAGE=nvcr.io/nvidia/l4t-base:r32.4.3
FROM ${BASE_IMAGE}
ARG BUILD_SRC="/usr/local/src"
MAINTAINER Sean Pollock
RUN apt update -y
RUN apt install git libjansson-dev \
	libssl-dev libsrtp-dev \
	libtool libnice-dev automake -y
RUN git clone https://github.com/meetecho/janus-gateway.git \
	${BUILD_SRC}/janus-gateway/ \
	&& cd ${BUILD_SRC}/janus-gateway \
	&& ./autogen.sh \
	&& ./configure \
	--disable-websockets --disable-data-channels --disable-rabbitmq --disable-mqt \
	&& make \
	&& make install
