DC_URL=https://api.cluster-gg776.gg776.sandbox2839.opentlc.com:6443
DC_UID=admin
DC_PWD=P@ssw0rd

AWS_URL=https://api.cluster-vk4dx.vk4dx.sandbox1545.opentlc.com:6443
AWS_UID=admin
AWS_PWD=OTAwMTc1

AZURE_URL=https://api.azure-vk4dx-1.vk4dx-1.sandbox1507.opentlc.com:6443
AZURE_UID=admin
AZURE_PWD=OTAwMTc1

# A hello world bash function
menu () {
  # https://patorjk.com/software/taag/#p=display&f=ANSI%20Shadow&t=Connect
clear
echo "       _\|/_"
echo "       (o o)"
echo " +..oOO.{-}.OOo............................. select an option ....+"
echo " |                                                                |"
echo " | ██████╗ ██████╗ ███╗   ██╗███╗   ██╗███████╗ ██████╗████████╗  |"
echo " | ██╔════╝██╔═══██╗████╗  ██║████╗  ██║██╔════╝██╔════╝╚══██╔══╝ |"
echo " | ██║     ██║   ██║██╔██╗ ██║██╔██╗ ██║█████╗  ██║        ██║    |"
echo " | ██║     ██║   ██║██║╚██╗██║██║╚██╗██║██╔══╝  ██║        ██║    |"
echo " | ╚██████╗╚██████╔╝██║ ╚████║██║ ╚████║███████╗╚██████╗   ██║    |"
echo " | ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═╝     |"
echo " +................................................................+.................................+"
echo " | DC                       | AWS                     | Azure                 | Azure Native        |"
echo " +..................................................................................................+"
echo " | 1) init DC               | 2) init and link        | 3) init and link      | 4) init and link    |"
echo " | 5) expose db service     | 8) bind service         | 10) bind service      | 12) bind service    |"
echo " | 6) bind service          | 9) unbind service       | 11) unbind service    | 13) unbind service  |"
echo " | 7) unbind service        |                         |                       |                     |" 
echo " | 14) delete all           |                         |                       |                     |" 
echo " +..................................................................................................+"

if [ "$1" = "done" ]; then
echo " step $2 ==> $1 "
fi
}

menu 

while true
do 
read n
case $n in
"1")
# DC
oc login --server=$DC_URL -u $DC_UID -p $DC_PWD --insecure-skip-tls-verify=true
oc project battalion-fox-team
skupper init --enable-console --enable-flow-collector --console-auth unsecured --site-name dc-site
skupper token create aws_to_dc.token 
skupper token create azure_to_dc.token
skupper token create azure_native_to_dc.token
;;

"2")
#AWS
oc login --server=$AWS_URL -u $AWS_UID -p $AWS_PWD --insecure-skip-tls-verify=true
oc project battalion-fox-team
skupper init --enable-console --enable-flow-collector --console-auth unsecured --site-name aws-site
skupper link create aws_to_dc.token --name aws-to-dc
;;

"3")
#AZURE
oc login --server=$AZURE_URL -u $AZURE_UID -p $AZURE_PWD --insecure-skip-tls-verify=true
oc project battalion-fox-team
skupper init --enable-console --enable-flow-collector --console-auth unsecured --site-name aws-site
skupper link create aws_to_dc.token --name azure-to-dc
;;

"4")
# Azure Native DB
oc login --server=$DC_URL -u $DC_UID -p $DC_PWD --insecure-skip-tls-verify=true
oc project battalion-fox-team-azure
skupper init --enable-console --enable-flow-collector --console-auth unsecured --site-name azure-native-site
skupper link create azure_native_to_dc.token --name azure-native-to-dc
;;


"5")
# DC
oc login --server=$DC_URL -u $DC_UID -p $DC_PWD --insecure-skip-tls-verify=true
oc project battalion-fox-team
skupper service create postgresql 5432 --protocol tcp
;;


"6")
# DC
oc login --server=$DC_URL -u $DC_UID -p $DC_PWD --insecure-skip-tls-verify=true
oc project battalion-fox-team
skupper service bind postgresql service postgresqldb
;;


"7")
# DC
# unbind the service in DC to see the impact
oc login --server=$DC_URL -u $DC_UID -p $DC_PWD --insecure-skip-tls-verify=true
oc project battalion-fox-team
skupper service unbind postgresql service postgresqldb
;;


"8")
# bind service on AWS
oc login --server=$AWS_URL -u $AWS_UID -p $AWS_PWD --insecure-skip-tls-verify=true
oc project battalion-fox-team
skupper service bind postgresql service postgresqldb
;;


"9")
# unbind service on AWS
oc login --server=$AWS_URL -u $AWS_UID -p $AWS_PWD --insecure-skip-tls-verify=true
oc project battalion-fox-team
skupper service unbind postgresql service postgresqldb
;;


"10")
# bind service on Azure
oc login --server=$AZURE_URL -u $AZURE_UID -p $AZURE_PWD --insecure-skip-tls-verify=true
oc project battalion-fox-team
skupper service bind postgresql service postgresqldb
;;


"11")
# unbind service on Azure
oc login --server=$AZURE_URL -u $AZURE_UID -p $AZURE_PWD --insecure-skip-tls-verify=true
oc project battalion-fox-team
skupper service unbind postgresql service postgresqldb
;;


"12")
# bind Azure Native DB
oc login --server=$DC_URL -u $DC_UID -p $DC_PWD --insecure-skip-tls-verify=true
oc project battalion-fox-team-azure
skupper service bind postgresql service azure-postgresql-service
;;

"13")
# unbind Azure Native DB
oc login --server=$DC_URL -u $DC_UID -p $DC_PWD --insecure-skip-tls-verify=true
oc project battalion-fox-team-azure
skupper service unbind postgresql service azure-postgresql-service
;;



"14")
oc login --server=$DC_URL -u $DC_UID -p $DC_PWD --insecure-skip-tls-verify=true
oc project battalion-fox-team
skupper delete
oc project battalion-fox-team-azure
skupper delete
oc login --server=$AWS_URL -u $AWS_UID -p $AWS_PWD --insecure-skip-tls-verify=true
oc project battalion-fox-team
skupper delete
oc login --server=$AZURE_URL -u $AZURE_UID -p $AZURE_PWD --insecure-skip-tls-verify=true
oc project battalion-fox-team
skupper delete
;;


esac

#menu "done" $n

done