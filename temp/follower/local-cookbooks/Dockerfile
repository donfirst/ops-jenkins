# This images uses the ECS jenkins plugin
FROM 085913924494.dkr.ecr.eu-west-1.amazonaws.com/elastera/jenkins-follower:chef
MAINTAINER support@elastera.com
RUN apt-get -y upgrade && apt-get -y update
COPY Berksfile.lock /home/jenkins/Berksfile.lock
COPY Berksfile /home/jenkins/Berksfile
RUN berks install
