kubectl delete -n kafka statefulset pzoo
kubectl delete -n kafka statefulset kafka
kubectl delete -n kafka pvc data-pzoo-0
kubectl delete -n kafka pvc data-kafka-0