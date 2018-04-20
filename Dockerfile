# Version: 0.0.1
FROM vcatechnology/linux-mint

MAINTAINER Poul Lysunenko <mpoul@hungosh.net>
RUN apt update 
RUN apt install -y net-tools language-pack-ru cinnamon nginx chromium-browser vnc4server xvnc4viewer xfonts-base
RUN locale-gen ru_RU.UTF-8 && dpkg-reconfigure locales
COPY noVNC/ /root/
COPY .vnc/ /root/.vnc
COPY default /etc/nginx/sites-available/
COPY Telegram /root/
COPY cron /etc/cron.d/sample
RUN apt install -y cron
EXPOSE 6080

ENTRYPOINT /usr/sbin/service nginx start && /usr/sbin/service cron start && VNCAPP=/root/Telegram vnc4server -depth 24 -geometry 800x600 && /root/utils/launch.sh --vnc localhost:5901