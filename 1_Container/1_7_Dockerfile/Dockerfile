FROM ubuntu:20.04

RUN apt-get update
RUN apt-get install -y tar
RUN apt-get install -y xz-utils
RUN apt-get install -y gcc
RUN apt-get install -y build-essential
RUN apt-get install -y libssl-dev

ADD https://cache.ruby-lang.org/pub/ruby/2.7/ruby-2.7.2.tar.xz .

RUN tar -xf /ruby-2.7.2.tar.xz
RUN cd /ruby-2.7.2 && ./configure && make && make install

EXPOSE 80
CMD ruby -v
