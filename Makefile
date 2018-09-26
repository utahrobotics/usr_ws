jetson:
	catkin_make -DCATKIN_BLACKLIST_PACKAGES="amee_2dnav;amee_gazebo;emcee_navigation;usr_zed;"
anon_git:
	git config --global user.name "JETSON TX2"
	git config --global user.email "utahstudentrobotics@gmail.com"
matt_git:
	git config --global user.name "Matthew Wilson"
	git config --global user.email "mattwilsonmbw@gmail.com"
cole:
	git config --global user.name "Cole Mortensen"
	git config --global user.email "colemortensen@gmail.com"
john:
	git config --global user.name "John Robe"
	git config --global user.email "john@jrobe.me"
vm:
	catkin_make -DCATKIN_BLACKLIST_PACKAGES="zed_wrapper;usr_zed"

