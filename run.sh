# build images
# sh docker/build.sh

# build persitant volumes
kubectl apply -f ./storage

# deploy zookeeper
kubectl apply -f ./zookeeper/00namespace.yml
kubectl apply -f ./zookeeper/20pzoo-service.yml
kubectl apply -f ./zookeeper/30service.yml
cat zookeeper/50pzoo.yml | sed "s/{{VERSION}}/`cat docker/version.txt`/g" | kubectl apply -f -

# deploy kafka
kubectl apply -f ./00namespace.yml
kubectl apply -f ./20dns.yml
cat 50kafka.yml | sed "s/{{VERSION}}/`cat docker/version.txt`/g" | kubectl apply -f -