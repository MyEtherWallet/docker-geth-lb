#Get base image
FROM alpine:edge

# Set environment variables.
ENV HOME /root

#Run some commands
RUN apk add --no-cache --update gcc musl-dev openssl-dev pkgconfig g++ make curl \
	eudev-dev rust cargo git file binutils libusb-dev linux-headers
	
RUN git clone https://github.com/paritytech/parity && \
	cd parity && \
	git checkout stable && \
	cargo build --release && \
	cp ./target/release/parity /usr/local/bin/ && \
	rm -rf ~/parity

RUN apk add --update nodejs nodejs-npm 	&& \
	npm install npm@latest -g

RUN cd /root/ && \
	git clone --depth=1 https://github.com/cubedro/eth-net-intelligence-api.git && \
    cd eth-net-intelligence-api 												&& \
    npm install 																&& \
    npm install -g pm2

#Delete installed packages
RUN npm cache clean --force && \
	apk del gcc musl-dev openssl-dev pkgconfig g++ make curl \
	eudev-dev rust cargo git file binutils libusb-dev linux-headers nodejs-npm  && \
	rm -rf /var/cache/apk/*

ADD files/app.json /root/eth-net-intelligence-api/app.json
ADD files/startscript.sh /root/startscript.sh

RUN chmod +x /root/startscript.sh

#expose the ports
EXPOSE 8545
EXPOSE 30303
EXPOSE 30303/udp

ENTRYPOINT ["/root/startscript.sh"]
