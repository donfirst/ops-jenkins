FROM 085913924494.dkr.ecr.eu-west-1.amazonaws.com/elastera/jenkins-follower:basic
MAINTAINER support@elastera.com
RUN apt-get -y upgrade && apt-get -y update && apt-get -y install build-essential
RUN curl -L https://www.opscode.com/chef/install.sh | bash -s -- -P chefdk

ENV GEM_ROOT /opt/chefdk/embedded/lib/ruby/gems/2.1.0
ENV GEM_HOME $HOME/.chefdk/gem/ruby/2.1.0"
ENV GEM_PATH $HOME/.chefdk/gem/ruby/2.1.0:/opt/chefdk/embedded/lib/ruby/gems/2.1.0"
ENV PATH $PATH:/opt/chefdk/bin:$HOME/.chefdk/gem/ruby/2.1.0/bin:/opt/chefdk/embedded/bin:$HOME/bin:$HOME/.chefdk/gem/ruby/2.1.0/bin:/opt/chefdk/embedded/bin
RUN gem install kitchen-sync kitchen-docker yarjuf

RUN mkdir /home/jenkins/.chef
COPY ./client.pem /home/jenkins/.chef/client.pem
COPY ./knife.rb /home/jenkins/.chef/knife.rb
