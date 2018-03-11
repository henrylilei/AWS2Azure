#!/bin/sh

echo "Make sure you have kops/helm/python3 installed"

#TODO: customize the config such as cluster name, etc.

#create cluster with default config
kops create cluster --zones=us-east-1c test.k8s1.hunterchain.io

#edit agent node to different size and count
kops edit ig --name=test.k8s1.hunterchain.io nodes

#edit master node to different size
kops edit ig --name=test.k8s1.hunterchain.io master-us-east-1c

#rollout changes
kops update cluster test.k8s1.hunterchain.io --yes

#setup hadoop
curl https://raw.githubusercontent.com/kubernetes/charts/master/stable/hadoop/tools/calc_resources.sh > calc_resources.sh
helm init
sudo apt-get install bc
sudo apt-get install jq
helm install --name hadoop $(./calc_resources.sh 50) stable/hadoop
kubectl exec -n default -it hadoop-hadoop-yarn-nm-0 -- /usr/local/hadoop/bin/hadoop version

#setup tensorflow
kubectl create -f ./setup/templates/tensorflow_inception_k8s.yaml