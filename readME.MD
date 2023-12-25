Please refer to https://medium.com/p/1b54bd938d96/edit for complete story of this repo.

A web app that is selected here would be a spark example app that is publicly available - /spark/examples/jars/spark-examples_2.12-3.5.0.jar.
Which is a finite computation app. If it is stored inside docker-compose.yml services it requires a parameter of how many steps needed to complete the computation.

The web app environment in this repo could contain 2 or more microservices that communicate with each other by configuring docker compose call as follow: 
1.   one spark-worker microservice  with one   spark-submit microservice.  --> sudo docker compose up --scale spark-worker=1 --scale spark-submit=1 
2. three spark-worker microservices with three spark-submit microservices. --> sudo docker compose up --scale spark-worker=3 --scale spark-submit=3
3. three spark-worker microservices with one   spark-submit microservice.  --> sudo docker compose up --scale spark-worker=3 --scale spark-submit=1
4.  four spark-worker microservices with one   spark-submit microservice.  --> sudo docker compose up --scale spark-worker=4 --scale spark-submit=1

Press Ctrl+c at any time from the terminal to stop the containers (all spark-submit, all spark-worker and spark-master).


Dockerize the app(s) and/or database(s).
Create Dockerfiles with instructions to create the respective Docker images for this app(s)/
microservice(s)/database(s).
Create a DockerHub account - if you don’t already have one.
Build the Docker images in both x86_64 and arm64 formats - e.g. use Docker Buildx tool - and push
the Docker images to your DockerHub registry.
Deploy and orchestrate the containers with Docker Compose on AWS.
Create and launch an EC2 instance that will serve as the container server to host your app containers.
In this EC2 server download and install Docker engine and Docker Compose.
Create a docker-compose.yaml file containing the configurations necessary to run your multi-container
setup with Docker Compose.
1
Launch and run your containers in this server with Docker Compose and ensure it is accessible via the
public interne
