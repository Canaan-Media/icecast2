FROM ubuntu:focal

LABEL maintainer="Canaan Media <info@canaanmedia.co>" \
      github="https://github.com/canaanmedia/icecast2"

# install icecast2 and enable its autostart
RUN apt update && apt upgrade -y && \
    apt install -y icecast2 nano && \
    sed -i "s#ENABLE=.*#ENABLE=true#" /etc/default/icecast2 && \
    sed -i 's/Earth/North Platte, NE/g' /etc/icecast2/icecast.xml && \
    sed -i 's/icemaster@localhost/fyi@canaanradio.com/g' /etc/icecast2/icecast.xml && \
    sed -i 's/<hostname>localhost/<hostname>audio.canaanradio.com/g' /etc/icecast2/icecast.xml && \
    sed -i 's/user>admin/user>source/g' /etc/icecast2/icecast.xml && \
    sed -i 's/password>hackme/password>william/g' /etc/icecast2/icecast.xml && \
    cat /etc/default/icecast2 && \
    apt autoremove && apt clean && \
    rm -rf /var/lib/apt/lists/*

CMD /etc/init.d/icecast2 start && tail -F /var/log/icecast2/error.log
