FROM nodesource/node:wheezy
MAINTAINER Nadrieril "nadrieril@eleves.polytechnique.fr"

#ENV HTTP_PROXY http://kuzh.polytechnique.fr:8080
#ENV http_proxy http://kuzh.polytechnique.fr:8080
#ENV https_proxy http://kuzh.polytechnique.fr:8080

RUN apt-get update && \
    apt-get install -y nginx

RUN npm install -g npm && \
    npm install -g bower gulp

RUN mkdir /app
WORKDIR /app
ADD package.json /app/
RUN npm install
ADD .bowerrc /app/
ADD bower.json /app/
RUN bower install --allow-root

ADD . /app
RUN gulp build
RUN ln -s /app/dist /srv/client

ADD nginx.conf /etc/nginx/nginx.conf

EXPOSE 8000
CMD nginx

