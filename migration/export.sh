#!/bin/sh

cd ~/workspace
mkdir FOLDER_NAME
cd FOLDER_NAME

#export interesting namespaces
kubectl get --export -o=json ns | \
jq '.items[] | select(.metadata.name!="kube-system") | select(.metadata.name!="kube-public") | select(.metadata.name!="default") | del(.status, .metadata.uid, .metadata.selfLink, .metadata.resourceVersion, .metadata.creationTimestamp, .metadata.generation )' \
> namespaces-exported.json

#export secrets
for ns in $(jq -r '.metadata.name' < ./namespaces-exported.json);
do
	kubectl --namespace=${ns} get --export -o=json secret \
	| jq '.items[]' \
	>> "secrets-exported.json"
	kubectl --namespace=${ns} get --export -o=json svc,rc,ds,deploy,rs,po,configmaps \
	| jq '.items[] | select(.type!="kubernetes.io/service-account-token") | del( .spec.clusterIP, .metadata.uid, .metadata.selfLink, .metadata.ownerReferences, .metadata.resourceVersion, .metadata.creationTimestamp, .metadata.generation, .status, .spec.nodeName, .spec.template.spec.securityContext, .spec.template.spec.dnsPolicy, .spec.template.spec.terminationGracePeriodSeconds, .spec.template.spec.restartPolicy )' \
	>> "cluster-exported.json"
done

exit;