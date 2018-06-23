#Get base image
FROM golang:1.10-alpine

# Set environment variables.
ENV HOME /root

#Run some commands
RUN apk add --update git make gcc curl musl-dev linux-headers tar	supervisor py-pip && \
  	git clone --depth=1 https://github.com/ethereum/go-ethereum.git 	   && \
  	cd go-ethereum                      			                           && \
    (git fetch --tags                                                    && \
    latestTag=$(git describe --tags `git rev-list --tags --max-count=1`) && \
    git checkout $latestTag)                                             && \
    make geth                                                            && \
  	cp /go/go-ethereum/build/bin/geth /usr/local/bin/                    && \
  	rm -rf /go-ethereum

RUN pip install s3cmd      

#Delete installed packages
RUN  apk del git go make gcc curl musl-dev linux-headers py-pip && \
	   rm -rf /var/cache/apk/*

ADD files/startscript.sh /root/startscript.sh
ADD files/runner.sh /root/runner.sh
ADD files/cron.txt /root/cron.txt
ADD files/geth.supervisor.conf /etc/supervisord.conf

RUN chmod +x /root/startscript.sh
RUN chmod +x /root/runner.sh
RUN /usr/bin/crontab /root/cron.txt

#expose the ports
EXPOSE 9001
EXPOSE 8545
EXPOSE 30303
EXPOSE 30303/udp

ENTRYPOINT ["supervisord", "--nodaemon"]