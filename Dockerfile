FROM ubuntu:18.04

# install dependencies
RUN apt-get update && apt-get install autoconf automake libtool curl make g++ unzip git wget python-setuptools -y

# install protobuf
RUN git clone https://github.com/google/protobuf.git
RUN cd protobuf && ./autogen.sh && ./configure && make && make install && ldconfig

# install nanopb (embedded)
RUN wget https://jpa.kapsi.fi/nanopb/download/nanopb-0.4.1-linux-x86.tar.gz \
    && tar -xzvf nanopb-0.4.1-linux-x86.tar.gz \
    && rm nanopb-0.4.1-linux-x86.tar.gz

# install protobuf for python
RUN cd /protobuf/python && python setup.py build && python setup.py install
