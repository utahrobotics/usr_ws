#!/bin/bash

#installing ros
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

sudo apt update

sudo apt install ros-melodic-desktop-full
sudo rosdep init
rosdep update

#setting up the enviorment
#source the ros melodifc setup so that ros packages can be found upon opening a new terminal
echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
source ~/.bashrc

#installing various dependencies used in the usr workstation
sudo apt install catkin python-rosinstall python-rosinstall-generator python-wstool build-essential

#install some package specific dependencies

#packages needed for realtime cameras
sudo apt-get install --fix-missing ros-melodic-ddynamic-reconfigure
sudo apt-key adv --keyserver keys.gnupg.net --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE || sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE
sudo add-apt-repository "deb http://realsense-hw-public.s3.amazonaws.com/Debian/apt-repo bionic main" -u
sudo apt-get install librealsense2-dkms librealsense2-utils librealsense2-dev

#teleop packages
sudo apt-get install ros-melodic-joy

#navigation packages
sudo apt install ros-melodic-rtabmap-ros

#make the workstation
cd ../
catkin_make

#source the setup file for usr_ws on terminal startup
echo "source `pwd`/devel/setup.bash" >> ~/.bashrc

#finish up
sudo apt autoremove
echo "finshed"