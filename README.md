# mission-command



oc label ns command-post argocd.argoproj.io/managed-by=user1-argocd
oc label ns command-post argocd.argoproj.io/managed-by=mod-cicd --overwrite

argocd.argoproj.io/managed-by: user1-argocd

oc policy add-role-to-user edit system:serviceaccount:demo-cicd:pipeline -n command-post
oc policy add-role-to-user system:image-puller system:serviceaccount:command-post:default -n demo-cicd

 
| oc apply -f apps/battalion-team-app.yaml -n mod-cicd


sed -i 's/BATTALION/$(params.battalion)/g' battalion-apps/battalion-team-app.yaml | oc apply -n demo-cicd -f -


sed -i 's/BATTALION/$(params.battalion)/g' battalion-apps/battalion-team-app.yaml | oc create -f - -n demo-cicd 



echo $(params.battalion) | cat  apps/battalion-team/kustomization.yaml | sed -i 's/yellow/$(params.battalion)/g' apps/battalion-team/kustomization.yaml | cat  apps/battalion-team/kustomization.yaml | oc apply -f apps/battalion-team-app.yaml -n demo-cicd

oc new-project battalion-$(params.battalion) | oc label ns battalion-$(params.battalion) argocd.argoproj.io/managed-by=demo-cicd | oc apply -f battalion-apps/battalion-team-app.yaml -n demo-cicd


oc label ns battalion-$(params.battalion) argocd.argoproj.io/managed-by=demo-cicd


oc label ns command-post argocd.argoproj.io/managed-by=demo-cicd

oc adm polci system:serviceaccount:mod-cicd:argocd-argocd-application-controller

oc adm policy add-cluster-role-to-user cluster-admin system:serviceaccount:demo-cicd:pipeline 


oc policy add-cluster-role-to-user self-provisioner -z gitlab-sa



oc adm policy add-cluster-role-to-user self-provisioner system:serviceaccount:command-post:pipeline

oc adm policy add-cluster-role-to-user cluster-reader system:serviceaccount:command-post:pipeline

oc adm policy add-cluster-role-to-user namespaces-manager system:serviceaccount:command-post:pipeline


oc create clusterrole test --verb=create --resource=namespace --dry-run

oc policy add-role-to-user edit system:serviceaccount:command-post:pipeline -n demo-cicd


oc new-project battalion-$(params.battalion) 


sed -i 's/TARGET_NAMESPACE/$(params.battalion)/g' apps/battalion-team-app.yaml | oc apply -n demo-cicd -f -