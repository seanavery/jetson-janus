ARG BASE_IMAGE=nvcr.io/nvidia/l4t-base:r32.4.3
ARG BUILD_SRC="/usr/local/src"
MAINTAINER Sean Pollock
FROM ${BASE_IMAGE}
RUN apt update
RUN apt install libjansson-dev \
	libssl-dev libsrtp-dev \
	libtool libnice-dev automake -y
RUN git clone https://github.com/meetecho/janus-gateway.git \
	${BUILD_SRC}/janus-gateway/ \
	&& cd ${BUILD_SRC}/janus-gateway \
	&& ./autogen.sh \
	&& ./configure \
	&& make \
	&& make install
