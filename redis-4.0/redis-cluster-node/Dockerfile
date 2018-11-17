#Dockerfile
FROM redis:4.0
MAINTAINER timogroup "redmine@tiho-mobi.com"
USER root

WORKDIR /data

ENV port 6379

#COPY
RUN mkdir -p /data
COPY ./redis.conf /redis.conf
CMD echo "port ${port}" >> /redis.conf && redis-server /redis.conf

#End
