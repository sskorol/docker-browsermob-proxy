# Browsermob Proxy container

Docker container for raising latest [Browsermob Proxy](https://github.com/lightbody/browsermob-proxy) version.

You can raise it as a part of docker-compose configuration with Selenium Grid images:

```bash
seleniumhub:
 image: sskorol/hub:2.53.1
 ports:
 - "4444:4444"
firefoxnode:
 image: sskorol/node-firefox-debug:2.53.1
 volumes:
 - ~/Work:/e2e/uploads
 - ~/Work/tmp:/e2e/uploads/tmp
 ports:
 - "5900"
 expose:
 - "80"
 links:
 - seleniumhub:hub
chromenode:
 image: sskorol/node-chrome-debug:2.53.1
 volumes:
 - ~/Work:/e2e/uploads
 - ~/Work/tmp:/e2e/uploads/tmp
 ports:
 - "5900"
 expose:
 - "80"
 links:
 - seleniumhub:hub
browsermobproxy:
 image: sskorol/browsermob-proxy:2.1.1
 ports:
 - "9090-9191:9090-9191"
 expose:
 - "9090-9191"
 links:
 - seleniumhub:hub_sel
 - firefoxnode:node_ff
 - chromenode:node_ch
```

Usage example is covered in [docker-selenium-samples](https://github.com/sskorol/docker-selenium-samples) project.

Note that to expose valid proxy IP from running container for further usage via REST, you'll need the following script:

```bash
#!/bin/bash
PROXY_NAME=`docker ps --format {{.Names}} | grep 'proxy'`
IP=`docker inspect --format {{.NetworkSettings.IPAddress}} $PROXY_NAME`
echo $IP
```