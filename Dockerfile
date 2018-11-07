FROM ubuntu:16.04
MAINTAINER Dr. Snyder <dr.wes.snyder.v@gmail.com>

ENV BUILD_PACKAGES build-essential libncurses5-dev libncursesw5-dev libsqlite3-dev libglib2.0-dev libgtk2.0-dev libgirepository1.0-dev tmux
ENV RUBY_PACKAGES ruby2.2 ruby2.2-dev

RUN apt-get update && apt-get install software-properties-common -y
RUN apt-add-repository ppa:brightbox/ruby-ng -y
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install $BUILD_PACKAGES -y && \
    apt-get install $RUBY_PACKAGES -y

# delete all the apt list files since they're big and get stale quickly
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN gem install sqlite3 --no-ri --no-rdoc #gtk2 (still working out gui display)
RUN gem install curses logger

EXPOSE 8000:8000
EXPOSE 8001:8001
EXPOSE 8002:8002
EXPOSE 8003:8003
EXPOSE 8004:8004
EXPOSE 11024:11024

WORKDIR /home/lich

# Define default command.
CMD ["/bin/bash"]