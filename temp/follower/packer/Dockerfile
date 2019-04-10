# This images uses the ECS jenkins plugin
FROM 085913924494.dkr.ecr.eu-west-1.amazonaws.com/elastera/jenkins-follower:chef
MAINTAINER support@elastera.com

ENV PACKER_VERSION=0.10.2
ENV PACKER_SHA256SUM=eadd33bc0f8fa42034059fc1cda5f43ed6f540746e767480f0706ebed49b45e5

RUN apt-get -y upgrade && apt-get -y update && apt-get -y install git bash wget

ADD https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip ./

RUN unzip packer_${PACKER_VERSION}_linux_amd64.zip -d /bin
RUN rm -f packer_${PACKER_VERSION}_linux_amd64.zip
