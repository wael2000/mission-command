# mission-command

1 - allow ArgoCD to create apps 
# create ocp-admins group
oc adm groups new ocp-admins

# give cluster admin rightsto ocp-admins group
oc adm policy add-cluster-role-to-group cluster-admin ocp-admins

# add username to ocp-admins group
oc adm groups add-users ocp-admins USERNAME

2 - label projects that need to be managed by argoCD

# add label to the ns refer to ArgoCD ns
oc label ns command-post argocd.argoproj.io/managed-by=mod-cicd --overwrite

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

oc adm policy add-cluster-role-to-user namespaces-manager system:serviceaccount:command-post:pipeline

# add cluster-reader role
oc adm policy add-cluster-role-to-user cluster-reader system:serviceaccount:command-post:pipeline
