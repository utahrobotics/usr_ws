#!/usr/bin/env bash

#install gazebo
sudo apt-get update
curl -sSL http://get.gazebosim.org | sh
sudo apt-get install ros-melodic-gazebo-ros-pkgs ros-melodic-gazebo-ros-control

#setup the gazebo enviorment variables
cd ../
echo "export GAZEBO_MODEL_PATH=`pwd`/src" >> ~/.bashrc

#setup sourceing usr_ws ros packages 
echo "source `pwd`/devel/setup.bash" >> ~/.bashrc
