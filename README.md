# Out of the Box Kube Kafka 
###### By Paddy Green 3 Apr 2019
### Deploy

`sh run.sh`

### Test Running

`kubectl -n kafka exec -it pzoo-0 -c zookeeper -- echo ruok | nc -w 1 127.0.0.1 2181`
Should get `imok` returned

`kubectl exec -it -n kafka kafka-0 -c broker -- echo "" | nc -w 1 127.0.0.1 9092`
Should not fail

### Test Functionality
Listen
`kubectl exec -it -n kafka kafka-0 -c broker -- /bin/bash`
`sh /opt/kafka/bin/kafka-console-consumer.sh --bootstrap-server PLAINTEXT://kafka-0.broker.kafka.svc.cluster.local:9092 --topic test`

Write
`kubectl exec -it -n kafka kafka-0 -c broker -- /bin/bash`
`echo "0" | sh /opt/kafka/bin/kafka-console-producer.sh --broker-list PLAINTEXT://kafka-0.broker.kafka.svc.cluster.local:9092 --topic test`

You should get a "0" out of you're listening prompt
