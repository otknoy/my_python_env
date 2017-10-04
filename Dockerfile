FROM debian:latest

MAINTAINER Naoya Otsuka <otknoy@gmail.com>

ENV PYENV_ROOT /root/.pyenv
ENV PATH /root/.pyenv/shims:/root/.pyenv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN apt-get update && apt-get install -y git curl
RUN apt-get install -y gcc make libssl-dev libbz2-dev libreadline-dev libsqlite3-dev zlib1g-dev

# install pyenv
RUN curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash

# install python
RUN pyenv install 3.6.1
RUN pyenv global 3.6.1

# install python library
RUN pip install numpy scipy pandas sklearn jupyter

# jupyter config
RUN jupyter notebook --generate-config 

# install mecab
RUN apt-get install -y wget g++ make
RUN wget -O mecab-0.996.tar.gz https://drive.google.com/uc?'export=download&id=0B4y35FiV1wh7cENtOXlicTFaRUE'
RUN wget -O mecab-ipadic-2.7.0-20070801.tar.gz https://drive.google.com/uc?'export=download&id=0B4y35FiV1wh7MWVlSDBCSXZMTXM'
RUN tar xvf mecab-0.996.tar.gz
RUN cd mecab-0.996 && ./configure --enable-utf8-only && make && make install
RUN echo '/usr/local/lib' > /etc/ld.so.conf.d/mecab
RUN ldconfig

# install mecab-ipadic
RUN tar xvf mecab-ipadic-2.7.0-20070801.tar.gz
RUN cd mecab-ipadic-2.7.0-20070801 && ./configure --with-charset=utf8 && make && make install

# install mecab python binding
RUN pip install mecab-python3

EXPOSE 8888

CMD cd /root/ && jupyter notebook --ip=0.0.0.0 --allow-root
