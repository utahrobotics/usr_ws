FROM ros:kinetic-robot

# install packages
RUN apt-get update && \
  apt-get -y install sudo && \
  apt-get -y install udev && \
  apt-get -y install 

# install pip
RUN curl https://bootstrap.pypa.io/get-pip.py -o /tmp/get-pip.py
RUN python /tmp/get-pip.py

# Setup utahrobotics user
RUN useradd -M --uid 1000 utahrobotics
RUN echo "utahrobotics ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# make volume for code
RUN mkdir -p /home/utahrobotics/usr_ws
RUN chmod a+rw /home/utahrobotics
VOLUME [ "/home/utahrobotics/usr_ws" ]

# copy code base
COPY . /tmp/usr_ws

# COPY udev rules
RUN cp /tmp/usr_ws/99-usb-serial.rules /etc/udev/rules.d/99-usb-serial.rules
RUN udevadm trigger

# switch user
USER utahrobotics

# setup ros
RUN echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
RUN echo "[ ! -f /home/utahrobotics/devel/setup.bash ] || source /home/utahrobotics/devel/setup.bash" >> ~/.bashrc

RUN rosdep update

# install dependencies for usr_ws
WORKDIR /tmp/usr_ws
RUN sudo rosdep install --rosdistro kinetic --from-path src --ignore-src -r -y

# prep for run
WORKDIR /home/utahrobotics/usr_ws
RUN sudo rm -r /tmp/usr_ws
