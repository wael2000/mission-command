# mission-command



oc label ns command-post argocd.argoproj.io/managed-by=demo-cicd


oc policy add-role-to-user edit system:serviceaccount:demo-cicd:pipeline -n command-post
oc policy add-role-to-user system:image-puller system:serviceaccount:command-post:default -n demo-cicd

 