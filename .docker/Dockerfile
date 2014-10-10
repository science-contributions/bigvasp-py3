FROM ubuntu:14.04

MAINTAINER andresroot <strike1609@gmail.com>

# Set correct environment variables.
ENV DEBIAN_FRONTEND noninteractive

# Install deps
RUN apt-get autoclean
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get check
RUN apt-get install -y -q curl wget git git-core gcc build-essential nano vim emacs curl unzip wget dpkg openssl software-properties-common g++ make python-software-properties python libnss3-1d python-dev python-setuptools python-pip
RUN apt-get install -y -q libssl-dev libatlas-dev
RUN apt-get install -y -q python3-dev python3-crypto python3-pip libpython3-dev 
RUN apt-get install -y -q libffi-dev
RUN apt-get install -y -q libatlas3-base libblas-dev libblas3 libatlas-base-dev libatlas-dev
RUN apt-get install -y -q python3-numpy python3-scipy python3-pandas
RUN apt-get install -y -q gfortran
RUN apt-get install -y -q python3-gdbm
RUN apt-get install -y -q liblapack-dev

ENV LAPACK /usr/lib/liblapack.so
ENV ATLAS /usr/lib/libatlas.so
ENV BLAS /usr/lib/libblas.so

RUN pip3 install -U pip
RUN pip install -U virtualenv
RUN pip install -U ipython
RUN pip install -U Django==1.7

#install oh my zsh
RUN apt-get install -y zsh 
RUN curl -L http://install.ohmyz.sh | zsh
RUN chsh -s /bin/zsh

# we need to install postgresql
RUN DEBIAN_FRONTEND=noninteractive apt-get -qq install -y libpq-dev --force-yes
RUN locale-gen en_US.UTF-8
ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8
RUN DEBIAN_FRONTEND=noninteractive apt-get -qq install -y -q postgresql postgresql-contrib
RUN /etc/init.d/postgresql stop

# Create a virtualenv with pyvenv
# RUN pyvenv-3.4 --without-pip /webapp
# RUN virtualenv --no-site-packages webapp
# ADD setup_pip.sh /webapp/default/setup_pip.sh
# RUN bash -c 'cd /webapp/default/ ; ./setup_pip.sh'
# ADD setup_pip.sh /webapp/default/setup_pip.sh
# RUN bash -c 'source /webapp/bin/activate'
# WORKDIR /root/
# RUN wget https://pypi.python.org/packages/source/s/setuptools/setuptools-3.4.4.tar.gz
# RUN tar -vzxf setuptools-3.4.4.tar.gz
# WORKDIR ./setuptools-3.4.4/
# RUN /usr/bin/python3 setup.py install
# WORKDIR /root/
# RUN wget https://pypi.python.org/packages/source/p/pip/pip-1.5.6.tar.gz
# RUN tar -vzxf pip-1.5.6.tar.gz
# WORKDIR ./pip-1.5.6/
# RUN /usr/bin/python3 setup.py install
# ADD deactivate.sh /webapp/default/deactivate.sh
# RUN bash -c 'cd /webapp/default/ ; ./deactivate.sh'
# WORKDIR /

# create virtualenv with python3.4
RUN virtualenv -p /usr/bin/python3.4 webapp
RUN mkdir -p /webapp/default/
ADD requirements.txt /webapp/default/requirements.txt
RUN /webapp/bin/pip3 install -r /webapp/default/requirements.txt
RUN bash -c 'echo "source /webapp/bin/activate; cd /webapp/bigvasp/" >> /.zshrc'


RUN LOGFILE=/webapp/bigvasp/logs/gunicorn.log

WORKDIR /webapp/default

# add keys
ADD ssh/.ssh/ /root/.ssh/
RUN chmod -R 700 /root/.ssh/

# add github config
ADD git/.gitconfig /.gitconfig
RUN chmod 700 /.gitconfig

RUN DEBIAN_FRONTEND=noninteractive apt-get -qq clean
RUN DEBIAN_FRONTEND=noninteractive apt-get -qq autoclean
RUN DEBIAN_FRONTEND=noninteractive apt-get -qq purge

WORKDIR /
EXPOSE 8000
CMD ["/bin/zsh"]