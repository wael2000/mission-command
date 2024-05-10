# SNO
oc login --token=TOKEN --server=https://api.cluster-rg8x2.dynamic.redhatworkshops.io:6443 --insecure-skip-tls-verify=true
oc  project mc-datacenter
oc delete svc postgresql
skupper delete
# Oher
oc login --token=TOKEN --server=https://api.cluster-f44mq.dynamic.redhatworkshops.io:6443 --insecure-skip-tls-verify=true
oc  project mc-azure
oc delete svc postgresql
skupper delete

# SNO
oc login --token=TOKEN --server=https://api.cluster-rg8x2.dynamic.redhatworkshops.io:6443 --insecure-skip-tls-verify=true
oc project mc-datacenter
skupper init --enable-console --enable-flow-collector --console-auth unsecured
skupper token create sno.token

# other
oc login --token=TOKEN --server=https://api.cluster-f44mq.dynamic.redhatworkshops.io:6443 --insecure-skip-tls-verify=true
oc project mc-azure
skupper init --enable-console --enable-flow-collector --console-auth unsecured
skupper link create sno.token --name sno-to-other
skupper service create postgresql 5432 --protocol tcp
skupper service bind postgresql deploymentconfig postgresql

# SNO
oc login --token=TOKEN --server=https://api.cluster-rg8x2.dynamic.redhatworkshops.io:6443 --insecure-skip-tls-verify=true
oc project mc-datacenter
skupper service bind postgresql deploymentconfig postgresql


#skupper expose service postgresqldb --address postgresql
#skupper expose deploymentconfig/postgresql --address postgresql --port 5432 --protocol tcp
#oc project demo
#skupper expose deploymentconfig/postgresql --address postgresql --port 5432 --protocol tcp
