# mission-command



oc label ns command-post argocd.argoproj.io/managed-by=user1-argocd
oc label ns command-post argocd.argoproj.io/managed-by=demo-cicd --overwrite

argocd.argoproj.io/managed-by: user1-argocd

oc policy add-role-to-user edit system:serviceaccount:demo-cicd:pipeline -n command-post
oc policy add-role-to-user system:image-puller system:serviceaccount:command-post:default -n demo-cicd

 


sed -i 's/COLOR/$(params.battalion)/g' apps/battalion-team/kustomization.yaml | oc apply -n demo-cicd -f -

echo $(params.battalion) | cat  apps/battalion-team/kustomization.yaml | sed -i 's/yellow/$(params.battalion)/g' apps/battalion-team/kustomization.yaml | cat  apps/battalion-team/kustomization.yaml | oc apply -f apps/battalion-team-app.yaml -n demo-cicd