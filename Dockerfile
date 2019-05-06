#FROM centos:7.5.1804
FROM centos:7.5.1804 
MAINTAINER "xhaihua 851628816@qq.com"
RUN mkdir -p /opt/apply

WORKDIR /opt/apply
ADD  mongodb-linux-x86_64-3.6.12.tgz  ./
ADD  pwgen-2.08.tar.gz ./
ADD  run.sh /tmp/
ADD  set_mongodb_password.sh /tmp/

RUN yum -y install gcc gcc-c++ make iproute \
    && cd pwgen-2.08 && ./configure && make && make install \
    && ln -s /opt/apply/mongodb-linux-x86_64-3.6.12 /opt/apply/mongodb \
    && chmod +x /tmp/run.sh && chmod +x /tmp/set_mongodb_password.sh \
    && yum clean all 

ENV PATH /opt/apply/mongodb/bin:$PATH

EXPOSE 27017
EXPOSE 28017

VOLUME ["/data/db"]
VOLUME ["/data/log"]


CMD ["/tmp/run.sh"]

ENV AUTH yes



