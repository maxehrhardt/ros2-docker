# Base image
FROM ubuntu:bionic

ENV TZ=Europe/Amsterdam
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update
RUN apt-get install vim git tmux locales -y

# ROS2 installation
RUN apt-get install curl gnupg2 lsb-release -y
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -
RUN sh -c 'echo "deb [arch=amd64,arm64] http://packages.ros.org/ros2/ubuntu `lsb_release -cs` main" > /etc/apt/sources.list.d/ros2-latest.list'
RUN apt-get update
RUN apt-get install ros-eloquent-desktop -y
RUN echo "source /opt/ros/eloquent/setup.bash" >> ~/.bashrc

# ZSH Installation
RUN apt-get install zsh -y
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
RUN echo "source /opt/ros/eloquent/setup.zsh" >> ~/.zshrc
CMD zsh