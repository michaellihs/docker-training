Building the Images
===================

Run from this directory:

    docker image build -t michaellihs/mydb:latest database
    docker image build -t michaellihs/myapi:latest api
    docker image build -t michaellihs/myfrontend:latest ui


Running the containers
======================

After building the images:

    docker network create demo_net
    docker container run -d --network demo_net --name database michaellihs/mydb:latest
    docker container run -d --network demo_net -p 8081:8080 --name api michaellihs/myapi:latest
    docker container run -d --network demo_net -p 3000:3000 --name frontend michaellihs/myfrontend:latest


Running with `docker-compose`
=============================

After building the images:

    docker-compose up -d
    
