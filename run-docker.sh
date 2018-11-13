#!/bin/sh

docker build -t usr_ws .
docker run -it -v $PWD:/home/utahrobotics/usr_ws usr_ws
