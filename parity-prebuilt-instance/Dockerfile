#Get base image
FROM ubuntu:14.04

# Set environment variables.
ENV HOME /root

#Run some commands
RUN apt-get update && \
	apt-get upgrade -y && \
    apt-get install -y \
    curl \
    bash \
    wget \
    git
	
RUN wget https://raw.githubusercontent.com/paritytech/scripts/master/get-parity.sh && \
	bash get-parity.sh -r stable

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get update &&\
    apt-get install -y nodejs

RUN git clone https://github.com/cubedro/eth-net-intelligence-api && \
    cd eth-net-intelligence-api && \
    npm install && \
    npm install -g pm2

#Delete installed packages
RUN npm cache clean --force && \
	apt-get -y remove curl wget git

ADD files/app.json /root/eth-net-intelligence-api/app.json
ADD files/startscript.sh /root/startscript.sh

RUN chmod +x /root/startscript.sh

#expose the ports
EXPOSE 8545
EXPOSE 30303
EXPOSE 30303/udp

ENTRYPOINT ["/root/startscript.sh"]
