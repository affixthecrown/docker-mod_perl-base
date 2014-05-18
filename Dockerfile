#start with ubuntu
FROM ubuntu:12.04

#install packages (mysql-server and apache2)
# Install pre-requisites
ENV DEBIAN_FRONTEND noninteractive

ADD sources.list /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -yq curl git wget vim build-essential libxml2-dev libssl-dev libapache2-mod-perl2 libapache2-mod-perl2-dev mysql-server libgd2-noxpm libgd2-noxpm-dev 
#install CPAN minus
RUN curl -L http://cpanmin.us | perl - --self-upgrade

#install required perl modules
ADD all_modules.txt /root/all_modules.txt
RUN for x in $(cat /root/all_modules.txt); do cpanm $x; done

#add apache config
ADD site.conf /etc/apache2/conf.d/site.conf
