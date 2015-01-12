FROM phusion/baseimage:latest

ENV HOME /root

ENTRYPOINT ["/sbin/my_init"]

# Nginx Installation
RUN add-apt-repository -y ppa:nginx/stable
RUN apt-get update
RUN apt-get install -y nginx

RUN echo "daemon off;" >> /etc/nginx/nginx.conf

ADD build/default   /etc/nginx/sites-available/default
RUN mkdir           /etc/service/nginx
ADD build/nginx.sh  /etc/service/nginx/run
RUN chmod +x        /etc/service/nginx/run

VOLUME ["/etc/nginx/sites-enabled"]

EXPOSE 80 443
# End Nginx

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
