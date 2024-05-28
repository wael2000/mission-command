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
echo " | 1) init                  | 2) init                 | 3) init               | 4) init             |"
echo " | 5) bind service          | 6) bind service         | 7) bind service       | 8) bind service     |"
echo " | 9) unbind service        | 10) unbind service      | 11) unbind service    | 12) unbind service  |" 
echo " +..................................................................................................+"
echo " |  █████████ l) link All ████████████ e) expose db service █████████████ d) delete all ██████████  |"
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
;;

"3")
#AZURE
oc login --server=$AZURE_URL -u $AZURE_UID -p $AZURE_PWD --insecure-skip-tls-verify=true
oc project battalion-fox-team
skupper init --enable-console --enable-flow-collector --console-auth unsecured --site-name azure-site
;;

"4")
# Azure Native DB
oc login --server=$DC_URL -u $DC_UID -p $DC_PWD --insecure-skip-tls-verify=true
oc project battalion-fox-team-azure
skupper init --enable-console --enable-flow-collector --console-auth unsecured --site-name azure-native-site
;;


"5")
# DC Bind
oc login --server=$DC_URL -u $DC_UID -p $DC_PWD --insecure-skip-tls-verify=true
oc project battalion-fox-team
skupper service bind postgresql service postgresqldb
;;

"6")
# bind service on AWS
oc login --server=$AWS_URL -u $AWS_UID -p $AWS_PWD --insecure-skip-tls-verify=true
oc project battalion-fox-team
skupper service bind postgresql service postgresqldb
;;

"7")
# bind service on Azure
oc login --server=$AZURE_URL -u $AZURE_UID -p $AZURE_PWD --insecure-skip-tls-verify=true
oc project battalion-fox-team
skupper service bind postgresql service postgresqldb
;;

"8")
# bind Azure Native DB
oc login --server=$DC_URL -u $DC_UID -p $DC_PWD --insecure-skip-tls-verify=true
oc project battalion-fox-team-azure
skupper service bind postgresql service azure-postgresql-service
;;



"9")
# DC unbind
# unbind the service in DC to see the impact
oc login --server=$DC_URL -u $DC_UID -p $DC_PWD --insecure-skip-tls-verify=true
oc project battalion-fox-team
skupper service unbind postgresql service postgresqldb
;;

"10")
# unbind service on AWS
oc login --server=$AWS_URL -u $AWS_UID -p $AWS_PWD --insecure-skip-tls-verify=true
oc project battalion-fox-team
skupper service unbind postgresql service postgresqldb
;;

"11")
# unbind service on Azure
oc login --server=$AZURE_URL -u $AZURE_UID -p $AZURE_PWD --insecure-skip-tls-verify=true
oc project battalion-fox-team
skupper service unbind postgresql service postgresqldb
;;

"12")
# unbind Azure Native DB
oc login --server=$DC_URL -u $DC_UID -p $DC_PWD --insecure-skip-tls-verify=true
oc project battalion-fox-team-azure
skupper service unbind postgresql service azure-postgresql-service
;;





"l")
# Link All
oc login --server=$AWS_URL -u $AWS_UID -p $AWS_PWD --insecure-skip-tls-verify=true
oc project battalion-fox-team
skupper link create aws_to_dc.token --name aws-to-dc
oc login --server=$AZURE_URL -u $AZURE_UID -p $AZURE_PWD --insecure-skip-tls-verify=true
oc project battalion-fox-team
skupper link create azure_to_dc.token --name azure-to-dc
oc login --server=$DC_URL -u $DC_UID -p $DC_PWD --insecure-skip-tls-verify=true
oc project battalion-fox-team-azure
skupper link create azure_native_to_dc.token --name azure-native-to-dc
;;


"e")
# DC : Expose db service
oc login --server=$DC_URL -u $DC_UID -p $DC_PWD --insecure-skip-tls-verify=true
oc project battalion-fox-team
skupper service create postgresql 5432 --protocol tcp
;;

"d")
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

menu "done" $n

done