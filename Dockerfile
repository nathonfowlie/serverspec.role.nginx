FROM centos:7

WORKDIR /tmp

#RUN rm /etc/yum.repos.d/*.repo

#ADD files/etc/yum.repos.d/artifactory.repo /etc/yum.repos.d/artifactory.repo
ADD files/serverspec serverspec

#RUN yum update -y && \
RUN yum install -y https://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-8.noarch.rpm && \
    yum install -y rubygems nginx

RUN systemctl enable nginx.service

#RUN gem sources --remove https://rubygems.org/ && \
#    gem sources --add https://artifactory.dev.cba//api/gems/org.rubygems/ && \
RUN  gem install serverspec rake

#RUN cd serverspec && \
#    rake serverspec:localhost
