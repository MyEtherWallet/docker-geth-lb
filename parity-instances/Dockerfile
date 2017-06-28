#Get base image
FROM ubuntu:16.04

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root

#Run some commands
RUN apt-get update && \
	apt-get -y upgrade && \
	apt-get install -y git build-essential curl libssl-dev libudev-dev pkg-config && \
	curl https://sh.rustup.rs -sSf | sh /dev/stdin -y && \
	git clone https://github.com/paritytech/parity && \
	cd parity && \
	~/.cargo/bin/cargo build --release && \
	cp ./target/release/parity /usr/local/bin/ && \
	rm -rf ~/parity

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
