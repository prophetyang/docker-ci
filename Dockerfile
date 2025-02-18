FROM centos:centos6
MAINTAINER The CentOS Project <cloud-ops@centos.org>


#Install redhat-release
RUN rm -f /etc/centos-release;
ADD ./redhat-release /etc/

#Install development tools 
RUN yum -y groupinstall 'Development tools';
RUN yum -y install rpm-devel tar readline-devel zlib-devel libacl-devel vim wget

#Install kernels 
ADD ./kernels/* /tmp/
RUN /tmp/install_extra_kernel.sh

#Install lcov
RUN yum -y install perl perl-GD
ADD ./lcov/lcov-1.10-4.el6.noarch.rpm /tmp/
RUN rpm -hvi /tmp/lcov-1.10-4.el6.noarch.rpm
RUN rm -f /tmp/lcov-1.10-4.el6.noarch.rpm

#Install httpd
RUN yum install -y httpd

#Install Jenkins
RUN wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
RUN rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
RUN yum install -y jenkins java
ADD ./conf/httpd-jenkins.conf /tmp/
RUN cat /tmp/httpd-jenkins.conf >> /etc/httpd/conf/httpd.conf
RUN rm -f /tmp/httpd-jenkins.conf

ENTRYPOINT service httpd start && service jenkins start && /bin/bash
CMD ["/bin/bash"]
