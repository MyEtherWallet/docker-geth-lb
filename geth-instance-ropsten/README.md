sudo docker build -t geth-instance-ropsten .
sudo docker run -e WS_SECRET='abcdef' -e WS_SERVER='ws://127.0.0.1:3000' -e INSTANCE_NAME="mew-instance-$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)" -it -p 8545:8545 -p 30303:30303 -v "temp_files:/root/.ethereum" geth-instance-ropsten


To ssh into your instance use 

docker exec -i -t <containerId> sh