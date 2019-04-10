FROM 085913924494.dkr.ecr.eu-west-1.amazonaws.com/elastera/jenkins-follower:basic
MAINTAINER support@elastera.com

ENV TERRAFORM_VERSION=0.9.1
ENV TERRAFORM_SHA256SUM=0965cf0f9d373a550163aef4732438c201c7271ea5f96a902863248cb7f39f1c
RUN apt-get -y upgrade && apt-get -y update && apt-get -y install build-essential
RUN apt-get -y install git
RUN apt-get -y install curl
RUN  mkdir /home/jenkins/.ssh && chmod 400 /home/jenkins/.ssh


RUN curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip > terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    echo "${TERRAFORM_SHA256SUM}  terraform_${TERRAFORM_VERSION}_linux_amd64.zip" > terraform_${TERRAFORM_VERSION}_SHA256SUMS && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /bin && \
    rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip
