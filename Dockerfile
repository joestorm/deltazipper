FROM centos:latest

# Set correct environment variables.
ENV	HOME /root
ENV	LANG en_US.UTF-8
ENV	LC_ALL en_US.UTF-8

RUN yum install -y curl; yum upgrade -y; yum update -y;  yum clean all

ENV JDK_VERSION 8u112
ENV JDK_BUILD_VERSION b15
RUN curl -LO "http://download.oracle.com/otn-pub/java/jdk/$JDK_VERSION-$JDK_BUILD_VERSION/jdk-$JDK_VERSION-linux-x64.rpm" -H 'Cookie: oraclelicense=accept-securebackup-cookie' && rpm -i jdk-$JDK_VERSION-linux-x64.rpm; rm -f jdk-$JDK_VERSION-linux-x64.rpm; yum clean all
ENV JAVA_HOME /usr/java/default



RUN yum -y install zip
RUN yum -y install unzip
RUN yum -y install which
RUN yum -y install rsync

ENV JAVA_HOME=/usr/lib/jvm/jre-1.8.0-openjdk.x86_64

RUN mkdir /var/opt/MyDir

RUN mkdir /var/opt/MyDir/watchInDir
VOLUME /var/opt/MyDir/watchInDir
RUN mkdir /var/opt/MyDir/deltaCompareDir
VOLUME /var/opt/MyDir/deltaCompareDir
RUN mkdir /var/opt/MyDir/deltaZips
VOLUME /var/opt/MyDir/deltaZips
RUN mkdir /var/opt/scripts
ADD deltaZip.sh /var/opt/scripts/
