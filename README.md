# usr_ws
Top level workspace to hold all meta package and package repos


Using this repo is not required to run the code.  You can clone all the sub-repos
separately and place them wherever you want.  This repo just makes it easier to 
pull and manage all of the sub-repos at once, and you could use it as your 
catkin_ws.


This repo doesn't contain anything that important - essentially just pointers to all
the other repos.  It uses git submodules, which are kind of a pain, but seem to be a 
good fit and are good to learn.

# How to do stuff

Clone the repo:
```
git clone --recursive https://github.com/utahrobotics/usr_ws.git
```

If you have already cloned it and want to clone the submodules
```
git submodule init
git submodule update
```

Updating the submodules to the most recent commit:
```
TODO: (for now google)
```

Adding new submodules:
```
TODO: (for now google)
```

Removing submodules:
```
TODO: (for now google)
```






