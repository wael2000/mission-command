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

oc adm policy add-cluster-role-to-user namespaces-manager system:serviceaccount:command-post:pipeline

# add cluster-reader role
# oc adm policy add-cluster-role-to-user cluster-reader system:serviceaccount:command-post:pipeline

# add command-post pipeline sa as edit role in demo-cicd

oc policy add-role-to-user edit system:serviceaccount:command-post:pipeline -n demo-cicd

oc adm policy \
    add-cluster-role-to-user self-provisioner \
    system:serviceaccount:command-post:pipeline




curl -XPOST -k -d '{"id" : "1", "systemStatus" : "on"}' https://mission-command-service-command-post.apps.cluster-fdbd4.dynamic.opentlc.com/battalion/system  -H 'Content-Type: application/json' -v


curl -XPOST -k -d '{"id" : "1", "systemStatus" : "off"}' https://mission-command-service-command-post.apps.cluster-fdbd4.dynamic.opentlc.com/battalion/system  -H 'Content-Type: application/json' -v




# Clean
 

oc delete application battalion-delta-team -n demo-cicd
oc delete application battalion-fox-team -n demo-cicd
oc delete application battalion-hauk-team -n demo-cicd
oc delete application battalion-mes-team -n demo-cicd
oc delete application battalion-zwarte-team -n demo-cicd

oc delete project battalion-delta-team 
oc delete project battalion-fox-team
oc delete project battalion-hauk-team
oc delete project battalion-mes-team
oc delete project battalion-zwarte-team




https://api.cluster-zzmdz.dynamic.opentlc.com:6443/api/v1/namespaces/demo-cicd/pods?limit=500


https://api.cluster-zzmdz.dynamic.opentlc.com:6443/apis/project.openshift.io/v1/projects?labelSelector=kubernetes.io/metadata.name=demo-cicd