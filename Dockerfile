ARG BASE_IMAGE=nvcr.io/nvidia/l4t-base:r32.4.3
FROM ${BASE_IMAGE}
RUN apt update
RUN apt install libjansson-dev \
	libssl-dev libsrtp-dev \
	libtool automake -y
