#Get base image
FROM alpine:3.6

# Set environment variables.
ENV HOME /root

#Run some commands
RUN apk add --update git nodejs nodejs-npm 	&& \
	npm install npm@latest -g

RUN cd /root/ && \
	git clone --depth=1  https://github.com/cubedro/eth-netstats.git && \
    cd eth-netstats && \
    npm install && \
    npm install -g grunt-cli && \
    grunt

#Delete installed packages
RUN npm cache clean --force && \
	apk del git nodejs-npm  && \
	rm -rf /var/cache/apk/*

ADD files/startscript.sh /root/startscript.sh

RUN chmod +x /root/startscript.sh
#expose the ports
EXPOSE 3000

ENTRYPOINT ["/root/startscript.sh"]