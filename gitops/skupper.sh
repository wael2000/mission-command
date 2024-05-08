oc project mc
skupper init --enable-console --enable-flow-collector --console-auth unsecured
oc project demo
skupper init --enable-console --enable-flow-collector --console-auth unsecured
skupper token create demo.token
oc project mc
skupper link create demo.token --name demo-to-mc
skupper expose deploymentconfig/postgresql --address postgresql --port 5432 --protocol tcp
oc project demo
skupper expose deploymentconfig/postgresql --address postgresql --port 5432 --protocol tcp



skupper service create postgresql 5432 --protocol tcp