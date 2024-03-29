#
# Dockerfile
#
FROM ubuntu:16.04
LABEL maintainer "Sandesh Kumar Sodhi"

#
# Build
#
# [sudo] docker build -t workdocker .
#
# Run:
#
# [sudo] docker run --name mywork -i -t workdocker /bin/bash
#

RUN apt-get update && apt-get install -y --no-install-recommends \
 apache2 \
 autoconf \
 automake \
 bsdmainutils \
 build-essential \
 ca-certificates \
 curl \
 ethtool \
 expect \
 g++ \
 gdb \
 git \
 gdebi-core \
 iputils-ping \
 less \
 libboost-all-dev \
 libevent-pthreads-2.0-5 \
 libjsoncpp-dev \
 libnet1-dev \
 libpcap-dev \
 libtool \
 libxml2-utils \
 nmap \
 openssh-client \
 openssl \
 pkg-config \
 psmisc \
 realpath \
 sed \
 software-properties-common \
 ssh \
 sshpass \
 tcpdump \
 telnet \
 tmux \
 tdom \
 unzip \
 vim \
 wget

RUN apt-get update && apt-get install -y --no-install-recommends \
 python \
 pylint \
 python-pip \
 python-scapy

RUN pip install --upgrade pip
RUN pip install -U setuptools
RUN pip install scapy
RUN pip install ipaddr

RUN apt-get update && apt-get install -y --no-install-recommends \
 curl \
 git


#
# perl
#
# 'PERL_MM_USE_DEFAULT=1' makes perl automatically answer "yes" when CPAN asks
# "Would you like to configure as much as possible automatically? [yes]"
#
RUN PERL_MM_USE_DEFAULT=1 cpan App::cpanminus
RUN cpanm XML::Simple
RUN cpanm CGI
RUN cpanm Net::Telnet
RUN cpanm Net::Telnet
RUN cpanm XML::XPath
RUN cpanm Net::SSH::Perl
RUN cpanm Text::Banner
RUN cpanm Getopt::Mixed



#
# GO
#
RUN mkdir -p /root/downloads && cd /root/downloads && wget https://redirector.gvt1.com/edgedl/go/go1.9.2.linux-amd64.tar.gz
RUN cd /root/downloads && tar -C /usr/local -xzf go1.9.2.linux-amd64.tar.gz
RUN mkdir -p /root/go
ENV PATH=$PATH:/usr/local/go/bin
ENV GOPATH=/root/go

COPY env/bash_aliases /root/.bash_aliases
COPY env/vimrc        /root/.vimrc
COPY env/tmux.conf    /root/.tmux.conf

COPY entrypoint.sh /root/entrypoint.sh

ENTRYPOINT ["/root/entrypoint.sh"]
