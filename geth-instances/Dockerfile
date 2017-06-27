#Get base image
FROM ubuntu:16.04

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root

# Define default command.
CMD ["bash"]

# Add files.
ADD files/autoRestarter.sh /root/autoRestarter.sh

#Run some commands
RUN \
	apt-get update && \
	apt-get -y upgrade && \
	apt-get install -y htop && \
	apt-get install -y git && \
	apt-get install -y build-essential curl nano && \
	curl -O https://storage.googleapis.com/golang/go1.7.3.linux-amd64.tar.gz && \
	tar -C /usr/local -xzf go1.7.3.linux-amd64.tar.gz && \
	mkdir -p ~/go; echo "export GOPATH=$HOME/go" >> ~/.bashrc && \
	echo "export PATH=$PATH:$HOME/go/bin:/usr/local/go/bin" >> ~/.bashrc && \
	. ~/.bashrc && \
	git clone https://github.com/ethereum/go-ethereum && \
	(cd go-ethereum && make geth) && \
	cp go-ethereum/build/bin/geth /usr/local/bin/ && \
	rm -rf /go-ethereum

#expose the ports
EXPOSE 8545
EXPOSE 30303
EXPOSE 30303/udp

ENTRYPOINT ["geth"]