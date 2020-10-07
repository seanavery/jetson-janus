ARG BASE_IMAGE=nvcr.io/nvidia/l4t-base:r32.4.3
FROM ${BASE_IMAGE}
ARG BUILD_SRC="/root"
MAINTAINER Sean Pollock
RUN apt update && apt-get upgrade -y
# install dependencies
RUN apt install git-core libjansson-dev \
	libssl-dev \
	libtool libnice-dev automake \
	ca-certificates \
	libconfig-dev \
	# libsrtp2-dev -y \
	gengetopt \
	wget -y
# install libsrtp2
RUN wget https://github.com/cisco/libsrtp/archive/v2.3.0.tar.gz && \
	tar xfv v2.3.0.tar.gz && \
	cd libsrtp-2.3.0 && \
	./configure --prefix=/usr --enable-openssl && \
	make shared_library && \
	make install
# make janus-gateway
RUN git clone https://github.com/meetecho/janus-gateway.git /janus \
	&& cd /janus \
	&& ./autogen.sh \
	&& ./configure --prefix=/janus \
 	--disable-websockets --disable-data-channels --disable-rabbitmq --disable-mqt --disable-all-handlers \
 	&& make \
 	&& make install
# run janus
ARG LD_LIBRARY_PATH=/usr/lib
COPY ./janus /janus
