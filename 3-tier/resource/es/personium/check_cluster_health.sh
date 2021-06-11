#!/bin/bash
#
# Shell script for checking Elasticsearch's cluster health
# Copyright 2016 - 2018 FUJITSU LIMITED
#

ES_IP=$1
CLUSTER_HEALTH_STATUS=red

while [ $CLUSTER_HEALTH_STATUS = "red" ]
do
    CLUSTER_HEALTH_STATUS=`curl -X GET 'http://${ES_IP}:9200/_cluster/health' | cut -d',' -f2 | cut -d':' -f2 | tr -d '"'`

    if [ $CLUSTER_HEALTH_STATUS != "green" && $CLUSTER_HEALTH_STATUS != "yellow" ]; then
        CLUSTER_HEALTH_STATUS=red
        sleep 30
    fi

done
