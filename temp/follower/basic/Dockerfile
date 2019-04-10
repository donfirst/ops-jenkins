FROM openjdk:8-jdk
MAINTAINER support@elastera.com

ENV SLAVE_VERSION 3.4
ENV HOME /home/jenkins
RUN useradd -c "Jenkins user" -d $HOME -m jenkins

RUN curl --create-dirs -sSLo /usr/share/jenkins/slave.jar http://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/$SLAVE_VERSION/remoting-$SLAVE_VERSION.jar \
  && chmod 755 /usr/share/jenkins \
  && chmod 644 /usr/share/jenkins/slave.jar

WORKDIR /home/jenkins

# setup SSH server
RUN apt-get update && apt-get install -y openssh-server
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
RUN mkdir /var/run/sshd

# Add aws commandline
RUN apt-get update && apt-get install -y python-pip python-dev groff less libyaml-cpp-dev libyaml-dev zip unzip
RUN pip install awscli

ENV DOCKER_ENGINE_VERSION 1.12.2-0~jessie
ENV DOCKER_COMPOSE_VERSION 1.11.2

RUN apt-get update \
    && apt-get install apt-transport-https ca-certificates rsync -y \
    && apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D \
    && echo "deb https://apt.dockerproject.org/repo debian-jessie main" > /etc/apt/sources.list.d/docker.list \
    && apt-get update \
    && apt-cache policy docker-engine \
    && apt-get upgrade -y \
    && apt-get install docker-engine=$DOCKER_ENGINE_VERSION -y \
    && gpasswd -a jenkins docker \
    && rm -rf /var/lib/apt/lists/*

RUN curl -L https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose

EXPOSE 22

COPY jenkins-slave.sh /usr/local/bin/jenkins-slave
ENTRYPOINT ["jenkins-slave"]
