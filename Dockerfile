ARG BASE_IMAGE=nvcr.io/nvidia/l4t-base:r32.4.3
FROM ${BASE_IMAGE}
ARG BUILD_SRC="/root"
MAINTAINER Sean Pollock
RUN apt update && apt-get upgrade -y
RUN apt install git-core libjansson-dev \
	libssl-dev libsrtp-dev \
	libtool libnice-dev automake -y
RUN apt install ca-certificates -y
RUN git clone https://github.com/meetecho/janus-gateway.git 
# 	&& cd /janus-gateway \
# 	&& ./autogen.sh \
# 	&& ./configure \
# 	--disable-websockets --disable-data-channels --disable-rabbitmq --disable-mqt \
# 	&& make \
# 	&& make install
