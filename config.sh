# argocd 
oc adm groups new cluster-admins
oc adm policy add-cluster-role-to-group cluster-admin cluster-admins
oc adm groups add-users cluster-admins admin
oc label ns mc-datacenter argocd.argoproj.io/managed-by=openshift-gitops --overwrite

#pipeline
oc policy add-role-to-user admin system:serviceaccount:mc-datacenter:pipeline -n openshift-gitops

# lift pipeline permission up 
# create a new cluster role 

apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: namespaces-manager
rules:
- apiGroups: [""]
  resources: ["namespaces"]
  verbs: ["get", "watch", "list", "create", "update", "patch", "delete"]

# add pipeline service account of the project where the pipeline runs to this role 

oc adm policy add-cluster-role-to-user namespaces-manager system:serviceaccount:mc-datacenter:pipeline

# add cluster-reader role
oc adm policy add-cluster-role-to-user cluster-reader system:serviceaccount:mc-datacenter:pipeline

oc adm policy \
    add-cluster-role-to-user self-provisioner \
    system:serviceaccount:mc-datacenter:pipeline




#podman with quarkus fix
export TESTCONTAINERS_RYUK_DISABLED=true

# https://quarkus.io/blog/quarkus-devservices-testcontainers-podman/

curl -XPOST -k -d '{"id" : "1", "systemStatus" : "on"}' https://mission-command-service-command-post.apps.cluster-fdbd4.dynamic.opentlc.com/battalion/system  -H 'Content-Type: application/json' -v


curl -XPOST -k -d '{"id" : "1", "systemStatus" : "off"}' https://mission-command-service-command-post.apps.cluster-fdbd4.dynamic.opentlc.com/battalion/system  -H 'Content-Type: application/json' -v







# create ocp-admins group
oc adm groups new ocp-admins

# give cluster admin rightsto ocp-admins group
oc adm policy add-cluster-role-to-group cluster-admin ocp-admins

# add username to ocp-admins group
oc adm groups add-users ocp-admins admin

# add label to the ns refer to ArgoCD ns
oc label ns command-post argocd.argoproj.io/managed-by=demo-cicd --overwrite



curl -XPOST -k -d '{"altitude":1.19, "latitude":1.15,"longitude":1.11}' http://mc-mc-datacenter.apps.cluster-gg776.gg776.sandbox2839.opentlc.com/battalion/location/1 -H 'Content-Type: application/json' -v