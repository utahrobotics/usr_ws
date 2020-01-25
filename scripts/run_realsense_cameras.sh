#!/bin/bash
echo "launch the realsense t265 camera"
roslaunch realsense2_camera rs_t265.launch &
echo "Done launching the realsense d400i camera"

sleep 3

echo "launch the realsense d400i camera"

roslaunch realsense2_camera rs_camera.launch &
