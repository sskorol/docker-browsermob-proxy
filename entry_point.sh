#!/bin/bash
JAVA_OPTS=${JAVA_OPTS:="-Xmx1024m"} \
/browsermob-proxy-2.1.1/bin/browsermob-proxy \
${BMP_OPTS:="-port 9090 --use-littleproxy true -proxyPortRange 9091-9121 -ttl 60"}