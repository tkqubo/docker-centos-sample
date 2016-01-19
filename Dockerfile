FROM centos:centos7

MAINTAINER tkqubo

ADD supervisord.conf /etc/supervisord.conf
ADD index.html /var/www/html/

RUN rpm -iUvh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm

RUN yum -y groupinstall "Development tools"
RUN yum -y install initscripts MAKEDEV
RUN yum check
RUN yum -y update
RUN yum -y install epel-release sudo wget
RUN yum -y install gcc-c++ libgeos-dev
RUN yum -y install openssh-server httpd python-pip
RUN yum -y install python-setuptools
RUN yum -y install openssl-devel
RUN yum -y install zlib-devel
RUN yum -y install readline-devel
RUN yum -y install sqlite-devel
RUN yum -y install bzip2-devel
RUN yum -y install libevent-devel
RUN yum -y install openssh
RUN yum -y install openssh-server
RUN yum -y install openssh-clients
RUN yum -y install git
RUN yum -y install postgresql-server
RUN yum -y install postgresql-devel

# # Python 3.3.5:
# RUN wget http://python.org/ftp/python/3.3.5/Python-3.3.5.tar.xz
# RUN tar xf Python-3.3.5.tar.xz
# RUN cd Python-3.3.5
# RUN ./configure --prefix=/usr/local --enable-shared LDFLAGS="-Wl,-rpath /usr/local/lib"
# RUN make && make altinstall

RUN echo include ld.so.conf.d/*.conf > /etc/ld.so.conf
RUN echo /usr/local/lib >> /etc/ld.so.conf 
RUN wget https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py
RUN python ez_setup.py
RUN python -v
RUN python -v
RUN python -v
RUN python -v
RUN pip install --upgrade pip
RUN pip install supervisor

RUN sed -i -e "s/Defaults    requiretty.*/ #Defaults    requiretty/g" /etc/sudoers
RUN sed -ri 's/^#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN echo 'root:root' | chpasswd
RUN ssh-keygen -t rsa -N "" -f /etc/ssh/ssh_host_rsa_key

EXPOSE 22 80

COPY install-osm-tasking-manager2.sh .
RUN bash install-osm-tasking-manager2.sh

CMD ["/usr/bin/supervisord"]
