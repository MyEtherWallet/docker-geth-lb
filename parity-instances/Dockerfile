#Get base image
FROM alpine:3.9 AS builder

# Set environment variables.
ENV HOME /root
ENV RUST_BACKTRACE 1

#Run some commands
# RUN apk add --no-cache --update libgit2-dev 
RUN apk add --no-cache --update \
	git \
	build-base \
	cargo \
	cmake \
	eudev-dev \
	linux-headers \
	perl \
	rust

RUN cargo --version
RUN git clone https://github.com/paritytech/parity
RUN cd parity && \
	git checkout stable  && \
	cargo build --release --features final

FROM alpine:3.9

# Set environment variables. 
ENV HOME /root
ENV RUST_BACKTRACE 1

RUN apk add --no-cache --update nodejs nodejs-npm libstdc++ eudev-libs libgcc git && \
	npm install npm@latest -g

COPY --from=builder /parity/target/release/parity /usr/bin/

RUN cd /root/ && \
	git clone --depth=1 https://github.com/cubedro/eth-net-intelligence-api.git && \
	cd eth-net-intelligence-api 												&& \
	npm install 																&& \
	npm install -g pm2

#Delete installed packages
RUN npm cache clean --force && \
	apk del nodejs-npm  && \
	rm -rf /var/cache/apk/*

ADD files/app.json /root/eth-net-intelligence-api/app.json
ADD files/startscript.sh /root/startscript.sh

RUN chmod +x /root/startscript.sh

#expose the ports
EXPOSE 8545
EXPOSE 30303
EXPOSE 30303/udp

ENTRYPOINT ["/root/startscript.sh"]
