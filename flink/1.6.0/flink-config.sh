#!/usr/bin/env bash

sed -i "s/\$RPC_ADDRESS/"$RPC_ADDRESS"/g" /app/conf/flink-conf.yaml
sed -i "s/\$RPC_PORT/"$RPC_PORT"/g" /app/conf/flink-conf.yaml
sed -i "s/\$JOB_MEM/"$JOB_MEM"/g" /app/conf/flink-conf.yaml
sed -i "s/\$TASK_MEM/"$TASK_MEM"/g" /app/conf/flink-conf.yaml
sed -i "s/\$TASK_SLOTS/"$TASK_SLOTS"/g" /app/conf/flink-conf.yaml
sed -i "s/\$REST_PORT/"$REST_PORT"/g" /app/conf/flink-conf.yaml
sed -i "s/\$BLOB_SERVER_PORT/"$BLOB_SERVER_PORT"/g" /app/conf/flink-conf.yaml
