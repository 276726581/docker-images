FROM java:8

RUN cd /tmp \
&& wget http://www-us.apache.org/dist/flink/flink-1.6.0/flink-1.6.0-bin-scala_2.11.tgz \
&& tar -xvf flink-1.6.0-bin-scala_2.11.tgz \
&& mkdir -p /app \
&& cd flink-1.6.0 \
&& cp -r * /app \
&& cd /app \
&& mkdir -p upload \
&& rm -rf /app/conf/flink-conf.yaml \
&& > /app/conf/masters \
&& > /app/conf/slaves \
&& rm -rf /tmp/*

COPY flink-conf.yaml /app/conf/flink-conf.yaml
COPY flink-config.sh /bin/flink-config.sh
COPY master.sh /bin/master.sh
COPY slave.sh /bin/slave.sh
RUN chmod 777 /bin/flink-config.sh /bin/master.sh /bin/slave.sh

ENV RPC_ADDRESS localhost
ENV RPC_PORT 6123
ENV JOB_MEM 1024m
ENV TASK_MEM 1024m
ENV TASK_SLOTS 1
ENV REST_PORT 8081
ENV BLOB_SERVER_PORT 6124

VOLUME ["/app/upload"]
EXPOSE 6123 6124 8081

WORKDIR /app/bin
