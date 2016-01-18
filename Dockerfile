FROM centos:centos7

MAINTAINER tkqubo

ADD supervisord.conf /etc/supervisord.conf
ADD index.html /var/www/html/

RUN yum -y install initscripts MAKEDEV
RUN yum check
RUN yum -y update
RUN yum -y install epel-release
RUN yum -y install openssh-server httpd python-pip


RUN sed -ri 's/^#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config

RUN echo 'root:root' | chpasswd

RUN ssh-keygen -t rsa -N "" -f /etc/ssh/ssh_host_rsa_key

RUN pip install supervisor

EXPOSE 22 80

CMD ["/usr/bin/supervisord"]
