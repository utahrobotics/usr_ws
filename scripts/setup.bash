#!/usr/bin/env bash

#setup the gazebo enviorment variables
cd ../
echo "export GAZEBO_MODEL_PATH=`pwd`/src" >> ~/.bashrc

#setup sourceing usr_ws ros packages 
echo "source `pwd`/devel/setup.bash" >> ~/.bashrc
