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

RUN jupyter notebook --generate-config 

EXPOSE 8888

CMD cd /root/ && jupyter notebook --ip=0.0.0.0 --allow-root

