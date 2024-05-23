# DC
skupper init --enable-console --enable-flow-collector --console-auth unsecured --site-name dc-site
skupper token create aws_to_dc.token  

#AWS
skupper init --enable-console --enable-flow-collector --console-auth unsecured --site-name aws-site
skupper link create aws_to_dc.token --name aws-to-dc

# DC
skupper service create postgresql 5432 --protocol tcp
skupper service bind postgresql service postgresqldb

#AWS
skupper service bind postgresql service postgresqldb

# every API component will access the DB next to it (least expensive route)
# UI->dc-dc
# UI->aws-aws

# DC
# unbind the service in DC to see the impact
skupper service unbind postgresql service postgresqldb

# API components in both sites will connect to DB on aws
# UI->dc-aws
# UI->aws-aws


# =======================================


oc project battalion-hauk
skupper init --enable-console --enable-flow-collector --console-auth unsecured
skupper token create aws_to_azure.token

oc project battalion-hauk-azure
skupper init --enable-console --enable-flow-collector --console-auth unsecured
skupper link create aws_to_azure.token --name aws-to-azure
skupper token create azure_to_aws.token
oc project battalion-hauk
skupper link create azure_to_aws.token --name azure-to-aws
skupper network status


# expose 
skupper expose service postgresqldb --address postgresql --port 5432 -n battalion-hauk
skupper service delete postgresql -n battalion-hauk

skupper expose service azure-postgresql-service.battalion-hauk-azure.svc.cluster.local --address postgresql --port 5432 -n battalion-hauk-azure
skupper service delete postgresql -n battalion-hauk-azure

# create and bind
skupper service create postgresql 5432 --protocol tcp -n battalion-hauk


skupper service bind postgresql service postgresqldb -n battalion-hauk

skupper service bind postgresql service postgresqldb.battalion-hauk.svc.cluster.local  -n battalion-hauk
skupper service bind postgresql service azure-postgresql-service.battalion-hauk-azure.svc.cluster.local  -n battalion-hauk-azure



skupper service unbind postgresql service postgresqldb.battalion-hauk.svc.cluster.local  -n battalion-hauk


# delete 
oc project battalion-hauk
skupper delete 
oc project battalion-hauk-azure
skupper delete 




#Azure-Central India(ARO Cluster) 
#Expose the service
skupper expose service backend.backend-ns --port 8080 --protocol tcp --address backend
skupper expose service backend.backend-ns --port 8080 --protocol tcp --address backend









#skupper unbind service  postgresql service azure-postgresql-service -n battalion-hauk-azure

skupper service create postgresql 5432 --protocol tcp -n battalion-hauk
skupper service create postgresql 5432 --protocol tcp -n battalion-hauk-azure

skupper service bind postgresql service postgresqldb -n battalion-hauk
skupper service bind postgresql service azure-postgresql-service -n battalion-hauk-azure



#skupper service create postgresql 5432 --protocol tcp
#skupper service bind postgresql service postgresqldb
#oc project battalion-hauk-azure
#skupper service bind postgresql service azure-postgresql-service
#skupper service unbind postgresql service postgresqldb


#skupper expose service postgresqldb --address postgresql --port 5432
#skupper expose service postgresqldb --address postgresql --port 5432

#skupper expose service azure-postgresql-service --address postgresql --port 5432 --target-namespace battalion-hauk-azure



#oc project battalion-hauk
#skupper service delete postgresql
#skupper service unbind postgresql service postgresqldb

#oc project battalion-hauk-azure
#skupper unexpose service azure-postgresql-service --address postgresql