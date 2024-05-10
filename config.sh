# create ocp-admins group
oc adm groups new ocp-admins

# give cluster admin rightsto ocp-admins group
oc adm policy add-cluster-role-to-group cluster-admin ocp-admins

# add username to ocp-admins group
oc adm groups add-users ocp-admins admin

# add label to the ns refer to ArgoCD ns
oc label ns command-post argocd.argoproj.io/managed-by=demo-cicd --overwrite


3 - lift pipeline permission up 
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

oc policy add-role-to-user admin system:serviceaccount:mc-datacenter:pipeline

oc adm policy \
    add-cluster-role-to-user self-provisioner \
    system:serviceaccount:mc-datacenter:pipeline




curl -XPOST -k -d '{"id" : "1", "systemStatus" : "on"}' https://mission-command-service-command-post.apps.cluster-fdbd4.dynamic.opentlc.com/battalion/system  -H 'Content-Type: application/json' -v


curl -XPOST -k -d '{"id" : "1", "systemStatus" : "off"}' https://mission-command-service-command-post.apps.cluster-fdbd4.dynamic.opentlc.com/battalion/system  -H 'Content-Type: application/json' -v




