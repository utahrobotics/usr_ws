#!/bin/sh

# this script is for running the usr_ws docker continer on linux machines
# to build to image do `docker build -t usr_ws .`

docker run -it \
    -e "DISPLAY" \
    -v $PWD:/home/utahrobotics/usr_ws \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    usr_ws
