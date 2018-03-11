#Migrating AWS k8s cluster with Hadoop/Tensorflow to ACS
##Installation
Please check out the scripts inside the setup folder and make sure you have two clusters up and running in both AWS and Azure.

##AWS setup
Once we finish the aws scripts, there should be a Hadoop cluster installed with Helm and a Tensorflow serving using an existing docker.

##Migration
Run /migration/migration.controller.sh

###Step1 (import.sh)
Export three json config files from AWS cluster, including namespaces, secrets and everything else.

###Step2 
Fetch those files to local then upload them to Azure server (We can use the kubectl's multi-context support to save this step).

###Step3 (export.sh)
Based on the config files, create the resources repectively.
####Caveats
The new cluster will generate new secrets with different names, thus we need to replace the referring secrets with the new ones.

##Verification
A simple verification of the new cluster in Azure for both Hadoop and Tensorflow is in /tools/verify.sh.

##Issues encountered during development
Please see Issues.md.