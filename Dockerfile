# Browser Mob Proxy
FROM phusion/baseimage:latest
MAINTAINER Serhii Korol <serhii.s.korol@gmail.com.com>

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

RUN echo deb http://ppa.launchpad.net/openjdk-r/ppa/ubuntu trusty main > /etc/apt/sources.list.d/openjdk8.list \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys DA1A4A13543B466853BAF164EB9B1D8886F44E2A \
    && DEBIAN_FRONTEND=noninteractive apt-get update \
    && apt-get -y install curl zip openjdk-8-jre-headless \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN curl -SL "https://github.com/lightbody/browsermob-proxy/releases/download/browsermob-proxy-2.1.2/browsermob-proxy-2.1.2-bin.zip" -o "/browsermob-proxy.zip" \
    && unzip -q /browsermob-proxy.zip \
    && rm -f /browsermob-proxy.zip

RUN mkdir /etc/service/browsermob-proxy
ADD entry_point.sh /etc/service/browsermob-proxy/run
RUN chmod +x /etc/service/browsermob-proxy/run

# 100 ports for listeners
EXPOSE 9090-9191
