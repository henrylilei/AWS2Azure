#!/bin/sh

#verify hadoop migration

#verify tensorflow serving migration
python inception_client.py --server=a3f7df761253411e89c690a8ad85db75-1188557235.us-east-1.elb.amazonaws.com:9000 --image=lion.jpg