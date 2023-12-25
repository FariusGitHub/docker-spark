Please refer to https://medium.com/p/1b54bd938d96/edit for complete story of this repo.
All of docker and terraform codes are available at github.com/FariusGitHub/docker-spark

1. WEB APP
A web app that is selected here would be a spark example app that is publicly available - /spark/examples/jars/spark-examples_2.12-3.5.0.jar.
Which is a finite computation app. If it is stored inside docker-compose.yml services it requires a parameter of how many steps needed to complete the computation.


2. MICROSERVICES
The web app environment in this repo could contain 2 or more microservices we will experiement with below scenarios: 
A.   one spark-worker microservice  with one   spark-submit microservice.   
B. three spark-worker microservices with three spark-submit microservices. 
C. three spark-worker microservices with one   spark-submit microservice.  
D.  four spark-worker microservices with one   spark-submit microservice.  


3. BASIC DOCKER OPERATION 
In this part, we will just use Dockerfile to build image and run container with docker build and docker run commands.
Not so much multiple containers could be replicated.

Based on https://medium.com/p/e457b92f0821/edit the common commands to build image and container could be

sudo docker build -t workshop/spark:latest .
sudo docker run --rm -it --name spark-master --hostname spark-master -p 7077:7077 -p 8080:8080 workshop/spark:latest /bin/sh

Assuming you already have DockerHub account, we can push this image into x86_64 and arm64 formats , like

docker build -t docker-spark-arm64 --platform linux/arm64 .
docker build -t docker-spark-amd64 --platform linux/amd64 .

docker tag docker-spark-arm64 ftjioesman/docker-spark-arm64
docker tag docker-spark-amd64 ftjioesman/docker-spark-amd64

docker push ftjioesman/docker-spark-arm64
docker push ftjioesman/docker-spark-amd64


4. DOCKER COMPOSE AND AWS EC2 
To enable multi container we will apply docker compose as below by taking the four cases of section 2 above. 

A.   one spark-worker microservice  with one   spark-submit microservice.  --> sudo docker compose up --scale spark-worker=1 --scale spark-submit=1 
B. three spark-worker microservices with three spark-submit microservices. --> sudo docker compose up --scale spark-worker=3 --scale spark-submit=3
C. three spark-worker microservices with one   spark-submit microservice.  --> sudo docker compose up --scale spark-worker=3 --scale spark-submit=1
D.  four spark-worker microservices with one   spark-submit microservice.  --> sudo docker compose up --scale spark-worker=4 --scale spark-submit=1

At each of above case the terminal will keep running, press Ctrl+c at any time to stop the containers (spark-submit, spark-worker and spark-master).

As the test passed in local machine, we can proceed with production deployment on EC2 created by Terraform to ease turn on/turn off all the resources.
I just pick one of the case above (scenario C) to illustrate the automation. Feel free to open EC2 terminal and type your own choice of case to run.
When EC2 instance was created and launched an it will serve as the container server to host Docker app containers.

The docker-compose.yml has three microservices where it will orchestrate the containers through Docker Compose 
- spark-master service is responsible for running the Spark master node. 
- spark-worker service is responsible for running a Spark worker node that connects to the Spark master and executes tasks assigned by it.
- spark-submit service is responsible for submitting Spark applications to the Spark cluster for execution.

EC2 server will download and install Docker engine and Docker Compose through user_data (dockerinstall.sh).
Above docker-compose.yaml file contains the configurations necessary to run your multi-container with Docker Compose.

Given a public IP address when EC2 was created this web app can be accessible through any browser.
Don't forget to turn off all the AWS resources after you finish with terraform destroy -auto-approve.