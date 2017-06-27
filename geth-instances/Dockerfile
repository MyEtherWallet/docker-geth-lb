#Get base image
FROM ubuntu:16.04

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root

#Run some commands
RUN apt-get update && \
	apt-get -y upgrade && \
	apt-get install -y git build-essential curl python-software-properties && \
	curl -O https://storage.googleapis.com/golang/go1.7.3.linux-amd64.tar.gz && \
	tar -C /usr/local -xzf go1.7.3.linux-amd64.tar.gz && \
	mkdir -p ~/go; echo "export GOPATH=$HOME/go" >> ~/.bashrc && \
	echo "export PATH=$PATH:$HOME/go/bin:/usr/local/go/bin" >> ~/.bashrc && \
	. ~/.bashrc && \
	git clone https://github.com/ethereum/go-ethereum && \
	(cd go-ethereum && make geth) && \
	cp go-ethereum/build/bin/geth /usr/local/bin/ && \
	rm -rf /go-ethereum

RUN apt-get update &&\
    curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get update &&\
    apt-get install -y nodejs

RUN git clone https://github.com/cubedro/eth-net-intelligence-api && \
    cd eth-net-intelligence-api && \
    npm install && \
    npm install -g pm2

ADD files/app.json /root/eth-net-intelligence-api/app.json
ADD files/startscript.sh /root/startscript.sh

RUN chmod +x /root/startscript.sh
#expose the ports
EXPOSE 8545
EXPOSE 30303
EXPOSE 30303/udp

ENTRYPOINT ["/root/startscript.sh"]