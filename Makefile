jetson:
	catkin_make -DCATKIN_BLACKLIST_PACKAGES="amee_2dnav;amee_gazebo;emcee_navigation;usr_zed;"
anon_git:
	git config --global user.name "JETSON TX2"
	git config --global user.email "utahstudentrobotics@gmail.com"
vm:
	catkin_make -DCATKIN_BLACKLIST_PACKAGES="zed_wrapper"

