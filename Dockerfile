ARG BASE_IMAGE=nvcr.io/nvidia/l4t-base:r32.4.3
FROM ${BASE_IMAGE}
ARG BUILD_SRC="/janus"
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
# install websockets
RUN apt install cmake -y
RUN git clone https://github.com/warmcat/libwebsockets.git /libwebsockets \
	&& mkdir /libwebsockets/build \
	&& cd /libwebsockets/build \
	&& cmake -DCMAKE_INSTALL_PREFIX:PATH=/usr -DCMAKE_C_FLAGS="-fpic" .. \
 	&& make \
   	&& make install
# make janus-gateway
RUN git clone https://github.com/meetecho/janus-gateway.git ${BUILD_SRC} \
	&& mv /libwebsockets ${BUILD_SRC} \
	&& cd ${BUILD_SRC} \
	&& ./autogen.sh \
	&& ./configure --prefix=/janus \
 	--disable-data-channels --disable-rabbitmq --disable-mqt --disable-all-handlers \
 	&& make \
 	&& make install
# clean up
ADD clean.sh /clean.sh
RUN chmod +x /clean.sh
RUN /clean.sh
# run janus
ARG LD_LIBRARY_PATH=/usr/lib
COPY ./janus /janus
