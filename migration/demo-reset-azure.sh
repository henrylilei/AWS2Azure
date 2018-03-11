#!/bin/sh

AZURE_SSH='ssh -i ~/.ssh/azure_id_rsa lei@52.224.164.216'
cat ../tools/azure-teardown.sh | $AZURE_SSH