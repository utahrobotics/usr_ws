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

```bash
git clone --recursive https://github.com/utahrobotics/usr_ws.git
```

If you have already cloned it and want to clone the submodules

```bash
git submodule init
git submodule update
```

Updating the submodules to the most recent commit:

```bash
git submodule update
```

Adding new submodules:

**See instructions below for how to create a new ROS package/submodule**

```bash
git submodule add <git url> <path to submodule>
```

Removing submodules:

See this website: https://gist.github.com/myusuf3/7f645819ded92bda6677


## Creating a New ROS Package / Submodule


First create the repository on github and get the clone link. The following instructions
assume that you are starting in the usr_ws directory.

```bash
git submodule add <git url> src/<name of /repo>
cd src/
# Make sure that there is not a trailing slash after <name of repo> below
catking_create_pkg <name of repo> std_msgs roscpp rospy <other dependencies>
```

## Submodule Commit / Update Procedure
The following commands commit code to the submodule, push it and then updates the usr_ws reference to the latest commit in that submodule. Assume we start in usr/ws. This should be used as a general reference, not exact instructions.

```bash
# update the submodule
cd <package name>
git add <files changed>
git commit -m '<commit message>'
git push

# update the usr_ws
cd ../ # you would now be in the src folder
git add <package name>
git commit -m '<commit message>'
git push
```

## Additional Node Documentation

### Zed
See [this document](https://docs.google.com/document/d/1FfmyJrUSkt-5UIluGyUdXrSw1mTrPsxC6YVyUTOSYd8/edit?usp=sharing) in the shared Google Drive folder for information on interacting with Zed.
