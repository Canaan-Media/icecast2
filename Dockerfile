FROM ubuntu:focal

LABEL maintainer="Canaan Media <info@canaanmedia.co>" \
      github="https://github.com/canaanmedia/icecast2"

# install icecast2 and enable its autostart
RUN apt update && apt upgrade -y && \
    apt install -y icecast2 nano && \
    sed -i "s#ENABLE=.*#ENABLE=true#" /etc/default/icecast2 && \
    sed -i -e "s/localhost/audio.canaanradio.com/g" -e "s/<admin-password>hackme/<admin-password>william/g" -e "s/<admin-user>admin/<admin-user>source/g" -e "s/<relay-password>hackme/<relay-password>william/g" -e "s/<source-password>hackme/<source-password>william/g" -e "s/<location>Earth/<location>North Platte, NE/g" -e "s/<admin>icemaster@localhost/<admin>fyi@canaanradio.com/g" /etc/icecast2/icecast.xml && \
    cat /etc/default/icecast2 && \
    apt autoremove && apt clean && \
    rm -rf /var/lib/apt/lists/*

CMD /etc/init.d/icecast2 start && tail -F /var/log/icecast2/error.log


