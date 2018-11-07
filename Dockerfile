FROM ubuntu:16.04
MAINTAINER Dr. Snyder <dr.wes.snyder.v@gmail.com>
LABEL version=1.1

ENV BUILD_PACKAGES build-essential libncurses5-dev libncursesw5-dev \
                   libsqlite3-dev libglib2.0-dev libgtk2.0-dev \ 
                   libgirepository1.0-dev tmux xterm
ENV RUBY_PACKAGES ruby2.2 ruby2.2-dev

RUN apt-get update && apt-get install -y software-properties-common
RUN apt-add-repository ppa:brightbox/ruby-ng -y
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y $BUILD_PACKAGES && \
    apt-get install -y $RUBY_PACKAGES

# delete all the apt list files since they're big and get stale quickly
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN gem install sqlite3 gtk2 --no-ri --no-rdoc
RUN gem install curses logger

COPY start-tmux.sh /home/lich

WORKDIR /home/lich

EXPOSE 8000:8000
EXPOSE 8001:8001
EXPOSE 8002:8002
EXPOSE 8003:8003
EXPOSE 8004:8004
EXPOSE 11024:11024

# Define default command.
CMD ["/bin/bash"]
#CMD ["/home/start-tmux.sh"]