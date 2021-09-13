FROM ubuntu:18.04
RUN apt-get update
RUN apt-get install -y nginx

ADD webserver.conf /etc/nginx/nginx.conf
ADD ./src/www /www

EXPOSE 80
CMD ["nginx"]
