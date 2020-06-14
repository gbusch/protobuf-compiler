FROM ubuntu:18.04

# install dependencies
RUN apt-get update && apt-get install autoconf automake libtool curl make g++ unzip git wget python-setuptools -y

# install protobuf
RUN git clone -b v3.5.2 https://github.com/google/protobuf.git
RUN cd protobuf && ./autogen.sh && ./configure && make && make install && ldconfig
