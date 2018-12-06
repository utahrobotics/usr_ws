@echo off

rem this script is for running the usr_ws docker continer on windows machines
rem to build to image do `docker build -t usr_ws .`

docker run -it -v %cd%:/home/utahrobotics/usr_ws usr_ws
