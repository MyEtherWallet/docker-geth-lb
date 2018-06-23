docker build -t geth .
docker run -v ./temp_files:/root/.ethereum -e AWS_S3_ACCESS=$AWS_S3_ACCESS -e AWS_S3_SECRET=$AWS_S3_SECRET -e AWS_S3_BUCKET=$AWS_S3_BUCKET geth