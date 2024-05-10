# SNO
oc login --token=TOKEN --server=https://api.cluster-rg8x2.dynamic.redhatworkshops.io:6443 --insecure-skip-tls-verify=true
oc  project mc-azure
skupper delete
# Oher
oc login --token=TOKEN--server=https://api.cluster-f44mq.dynamic.redhatworkshops.io:6443 --insecure-skip-tls-verify=true
oc  project mc-datacenter
skupper delete