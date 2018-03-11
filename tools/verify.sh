#!/bin/sh

#verify hadoop migration
kubectl exec -n hadoop-ns -it hadoop-hadoop-yarn-nm-0 -- /usr/local/hadoop/bin/hadoop fs -mkdir /test
kubectl exec -n hadoop-ns -it hadoop-hadoop-yarn-nm-0 -- /usr/local/hadoop/bin/hadoop fs -ls /

#verify tensorflow serving migration
python inception_client.py --server=20.190.60.27:9000 --image=lion.jpg