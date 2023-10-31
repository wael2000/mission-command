# mission-command



oc label ns command-post argocd.argoproj.io/managed-by=user1-argocd
oc label ns command-post argocd.argoproj.io/managed-by=demo-argocd

argocd.argoproj.io/managed-by: user1-argocd

oc policy add-role-to-user edit system:serviceaccount:demo-cicd:pipeline -n command-post
oc policy add-role-to-user system:image-puller system:serviceaccount:command-post:default -n demo-cicd

 



role:readonly