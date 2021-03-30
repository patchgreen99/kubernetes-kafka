#!/bin/bash
set -x

KAFKA_BROKER_ID=${HOSTNAME##*-}
sed -i "s/#init#broker.id=#init#/broker.id=$KAFKA_BROKER_ID/" /etc/kafka/server.properties

hash kubectl 2>/dev/null || {
  sed -i "s/#init#broker.rack=#init#/#init#broker.rack=# kubectl not found in path/" /etc/kafka/server.properties
} && {
  ZONE=$(kubectl get node "$NODE_NAME" -o=go-template='{{index .metadata.labels "failure-domain.beta.kubernetes.io/zone"}}')
  if [ $? -ne 0 ]; then
    sed -i "s/#init#broker.rack=#init#/#init#broker.rack=# zone lookup failed, see -c init-config logs/" /etc/kafka/server.properties
  elif [ "x$ZONE" == "x<no value>" ]; then
    sed -i "s/#init#broker.rack=#init#/#init#broker.rack=# zone label not found for node $NODE_NAME/" /etc/kafka/server.properties
  else
    sed -i "s/#init#broker.rack=#init#/broker.rack=$ZONE/" /etc/kafka/server.properties
  fi
}