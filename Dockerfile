# Version: 0.0.2
FROM vcatechnology/linux-mint

MAINTAINER Konstanitn Terekhov <terehovk@ya.ru>
RUN apt update 
RUN apt install -y net-tools language-pack-ru cinnamon nginx chromium-browser vnc4server xvnc4viewer xfonts-base
RUN locale-gen ru_RU.UTF-8 && dpkg-reconfigure locales
COPY cron /etc/cron.d/sample
RUN apt install -y cron
COPY noVNC/ /root/
COPY .vnc/ /root/.vnc
COPY default /etc/nginx/sites-available/
COPY Telegram /root/
EXPOSE 6080

ENTRYPOINT /usr/sbin/service nginx start && /usr/sbin/service cron start && VNCAPP=/root/Telegram vnc4server -depth 24 -geometry 800x600 && /root/utils/launch.sh --vnc localhost:5901