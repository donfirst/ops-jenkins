# Elastera Jenkins Using Docker

Create a jenkins server that runs in docker and uses docker slaves for it's jobs

## REFRESH FOLLOWER IMAGES
If you are wanted to refresh follower images only please follow this instruction
https://elastera.atlassian.net/wiki/display/EL/Jenkins
This link will explain you how to refresh imges using Jenkins - 
## REFRESH JENKINS LEADER IMAGE
If you are wanted to refresh follower images only please follow this instruction
https://elastera.atlassian.net/wiki/display/EL/Jenkins
This link will explain you how to refresh Jenkins imge using Jenkins :-)
Both documents describe the automation of the activities described below


## Install docker

See the docker website.

## AWS Docker Registry (ECR)

The registries are created using the cloudformation scripts. They are

1. elastera/jenkins-leader
2. elastera/jenkins-follower

All on the elastera dev account

## Building, Tagging and Pushing Images

Remove the old images locally. This is not strictly necessary but it helps to keep things tidy.

*Danger* brute force :
`docker container rm $(docker container ps -a -q)`
`docker image rm $(docker image list -q)`

Set your login allowing you to push images to the AWS Registry. The profile must have `push` privileges

`$(aws --profile sudo-elproducto ecr get-login)`

Build the jenkins image locally

`docker-compose build --force-rm jenkins-leader`

Push the jenkins image to the ECR repository

`docker-compose push jenkins-leader`

Repeat the above for each of the follower images:
* jenkins-follower-basic
* jenkins-follower-chef
* jenkins-follower-packer

Note because the images are built from each other build and push in the order above to ensure images use the latest version

## Jenkins Docker Images

There are currently four images:

### jenkins-leader:latest

This images has the main jenkins 'master' server. It is built using the public jenkinsci image.

#### Upgrading Jenkins leader ( incl plugins )

* Add the new plugin to `./leader/plugins.txt`. You need to specify it's plugin id and the version number (optional but necessary if you are adding a *new* plugin)
* Run the script `./leader/update_plugins.py` (optional but necessary if you are *upgrading* an existing plugin) (you need to instal "request" library first - pip install requests)
* Pull the latest jenkinsci image `docker pull jenkinsci/jenkins`
* Build the image and push as described above.
* Log onto the jenkins instance via the bastion.
* run `sudo service elastera-jenkins restart`

### jenkins-follower:basic

This image is the 'slave' that will run all jenkins jobs. You can use this to build further slave
images that do specific things for jobs. e.g. pre-installed chef, kitchen etc

The image takes a public key as an argument or via an environment setting

### jenkins-follower:chef

This image has chef libraries installed and is built from the `jenkins-follower:basic` image

### jenkins-follower:packer

This image has packer libraries installed and is built from the `jenkins-follower:chef` image

## Running jenkins-leader locally ( using Docker on Mac )

You must mount your local docker.sock file and a folder that will be used to store jenkins data/configuration. See
docker-compose.yml for information.

```
mkdir -p volume
docker-compose up [-d] jenkins-leader
```

The jenkins url will then be at http://localhost:8080

The jenkins url will then be found at http://$DOCKER_HOST:8080 i.e. The url of your VM running docker.

## Creating the infrastructure

### Resources Stack

```
aws --profile=sudo-elproducto cloudformation create-stack --template-body file://cloudformation/jenkins-resources.yml --stack-name jenkins-resources --parameters file://cloudformation/parameters-jenkins-resources.json --capabilities CAPABILITY_IAM
```

### ECS Cluster
This is managed by the [elastera-infrastructure](git@bitbucket.org:elastera/elastera-infrastructure.git) templates. Please refer to it for changes to the cluster.


### Jenkins Leader Stack

```
aws --profile=sudo-elproducto cloudformation create-stack --template-body file://cloudformation/jenkins-asg.yml --stack-name jenkins-asg --parameters file://cloudformation/parameters-jenkins-asg.json --capabilities CAPABILITY_IAM
```

# More Information

See [confluence](https://elastera.atlassian.net/wiki/display/EL/Jenkins)