#Get base image
FROM golang:1.10-alpine

# Set environment variables.
ENV HOME /root

#Run some commands
RUN apk add --update git make gcc curl musl-dev linux-headers 		       && \
  	git clone --depth=1 https://github.com/ethereum/go-ethereum.git 	   && \
  	cd go-ethereum                      			                           && \
    (git fetch --tags                                                    && \
    latestTag=$(git describe --tags `git rev-list --tags --max-count=1`) && \
    git checkout $latestTag)                                             && \
    make geth                                                            && \
  	cp /go/go-ethereum/build/bin/geth /usr/local/bin/                    && \
  	rm -rf /go-ethereum

#Delete installed packages
RUN apk del git go make gcc curl musl-dev linux-headers && \
	  rm -rf /var/cache/apk/*

ADD files/startscript.sh /root/startscript.sh

RUN chmod +x /root/startscript.sh
#expose the ports
EXPOSE 8545
EXPOSE 30303
EXPOSE 30303/udp

ENTRYPOINT ["/root/startscript.sh"]