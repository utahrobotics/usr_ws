FROM ros:kinetic-robot

# install packages
RUN apt-get update && \
  apt-get -y install sudo && \
  apt-get -y install screen

# Setup utahrobotics user
RUN useradd -M --uid 1000 utahrobotics
RUN echo "utahrobotics ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# make volume for code
RUN mkdir -p /home/utahrobotics/usr_ws
RUN chmod a+rw /home/utahrobotics
VOLUME [ "/home/utahrobotics/usr_ws" ]

# switch user
USER utahrobotics

# setup ros
RUN echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
COPY ./usr_ws /tmp/usr_ws
WORKDIR /tmp/usr_ws
RUN rosdep update && sudo rosdep install --rosdistro kinetic --from-path src --ignore-src -r -y

# prep for run
WORKDIR /home/utahrobotics/usr_ws
RUN sudo rm -r /tmp/usr_ws