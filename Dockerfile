FROM ubuntu:16.04
MAINTAINER Dr. Snyder <dr.wes.snyder.v@gmail.com>
LABEL version=1.3

ENV BUILD_PACKAGES build-essential libncurses5-dev libncursesw5-dev \
                   libsqlite3-dev libglib2.0-dev libgtk2.0-dev \ 
                   libgirepository1.0-dev tmux xterm wget \
                   apt-transport-https winbind \
                   software-properties-common \
                   python-software-properties
ENV RUBY_PACKAGES ruby2.2 ruby2.2-dev

RUN apt-get update && apt-get install -y software-properties-common && \
    apt-add-repository -y ppa:brightbox/ruby-ng && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y $BUILD_PACKAGES && \
    apt-get install -y $RUBY_PACKAGES

# Wine setup
RUN dpkg --add-architecture i386
RUN wget https://dl.winehq.org/wine-builds/Release.key
RUN apt-key add Release.key
RUN apt-add-repository -y https://dl.winehq.org/wine-builds/ubuntu/
RUN apt-get update && apt-get install -y winehq-stable winetricks # this installs Wine2

# delete all the apt list files since they're big and get stale quickly
RUN sudo apt-get purge -y software-properties-common python-software-properties
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN rm Release.key

# Install gems for ruby
RUN gem install sqlite3 gtk2 --no-ri --no-rdoc && \
    gem install curses logger

# Download Launcher
RUN wget -P /app/ http://www.play.net/software/lnchInst.exe

RUN mkdir /home/lich
COPY start-tmux.sh /app
RUN mkdir /app/SIMU # For installing the Launcher into. 
RUN useradd profanity # In case wine does not run in root.

WORKDIR /app

EXPOSE 8000:8000
EXPOSE 8001:8001
EXPOSE 8002:8002
EXPOSE 8003:8003
EXPOSE 8004:8004
EXPOSE 11024:11024

# Define default command.
CMD ["/bin/bash"]
#CMD ["/home/start-tmux.sh"]