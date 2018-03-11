#!/bin/sh

cd ~/workspace/FOLDER_NAME

kubectl create -f namespaces-exported.json
kubectl create -f secrets-exported.json

hinit() {
    rm -rf /tmp/hashmap.$1
    mkdir -p /tmp/hashmap.$1
}

hput() {
    printf "$3" > /tmp/hashmap.$1/$2
}

hget() {
    cat /tmp/hashmap.$1/$2
}

hkeys() {
    ls -1 /tmp/hashmap.$1
}

hdestroy() {
    rm -rf /tmp/hashmap.$1
}

#TODO: I still haven't figured out how to make this fully automatic,
#      I had tried label, annotation, etc., yet it seems the 
#      kubectl create -f secrets.json will not take any of these values...
#      the hashmap is a good datastructure that might be of some future use
hinit secrets
hadoop_secret_old='default-token-hpswz'
hadoop_secret_new=$(kubectl get secret --namespace=hadoop-ns | tail -n 1 | sed 's/ .*//')
hput secrets hadoop_secret_old hadoop_secret_new

tf_secret_old='default-token-jrvmp'
tf_secret_new=$(kubectl get secret --namespace=tensorflow-ns | tail -n 1 | sed 's/ .*//')
hput secrets tf_secret_old tf_secret_new
hdestroy secrets

sed -i 's/'$hadoop_secret_old/$hadoop_secret_new'/g' cluster-exported.json
sed -i 's/'$tf_secret_old/$tf_secret_new'/g' cluster-exported.json

kubectl create -f cluster-exported.json
