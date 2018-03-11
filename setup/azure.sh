#!/bin/sh

#TODO: customize the config such as subscription-id, etc.

#Setup k8s cluster using acs-engine
acs-engine deploy --subscription-id 6246852d-dc90-4a16-bb24-fb15db0a0dc1 --dns-prefix ya1-k8s-test-lei --location westus2 --auto-suffix --api-model ./setup/templates/azure-cluster.json

