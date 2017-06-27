#Get base image
FROM ubuntu:16.04

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root

#Run some commands
RUN apt-get update && \
	apt-get -y upgrade && \
	apt-get install -y git build-essential curl python-software-properties

RUN apt-get update &&\
    curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get update &&\
    apt-get install -y nodejs

RUN git clone https://github.com/cubedro/eth-netstats.git && \
    cd eth-netstats && \
    npm install && \
    npm install -g grunt-cli && \
    grunt

ADD files/startscript.sh /root/startscript.sh

RUN chmod +x /root/startscript.sh
#expose the ports
EXPOSE 3000

ENTRYPOINT ["/root/startscript.sh"]