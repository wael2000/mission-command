DC_URL=https://api.cluster-gg776.gg776.sandbox2839.opentlc.com:6443
DC_UID=admin
DC_PWD=P@ssw0rd

AWS_URL=https://api.cluster-vk4dx.vk4dx.sandbox1545.opentlc.com:6443
AWS_UID=admin
AWS_PWD=OTAwMTc1

AZURE_URL=https://api.azure-vk4dx-1.vk4dx-1.sandbox1507.opentlc.com:6443
AZURE_UID=admin
AZURE_PWD=OTAwMTc1

MSG="Welcome to Red Hat Dora Demo"
RESULT=""

declare -A menu_array
#menu_array=( ["1"]="1) init" ["woof"]="dog")
#menu_array+=(["1"]="1) init")
#menu_array=(["1"]="\033[43m1)\033[0m init")

menu_array["1"]="1) init"
menu_array["2"]="2) init"
menu_array["3"]="3) init"
menu_array["4"]="4) init"
menu_array["5"]="5) bind service"
menu_array["6"]="6) bind service"
menu_array["7"]="7) bind service"
menu_array["8"]="8) bind service"
menu_array["9"]="9) unbind service"
menu_array["10"]="10) unbind service"
menu_array["11"]="11) unbind service"
menu_array["12"]="12) unbind service"

# Function to check if an array contains an item
highlight() {
  return "\033[43m$1\033[0m"
}



print_fixed_line() {
    # Save cursor position
    tput sc

    # Get the terminal height
    rows=$(tput lines)

    # Move cursor to the bottom line
    tput cup $((rows-1)) 0

    # Print the fixed message
    echo "\033[1;37m$MSG.\033[0m"

    # Restore cursor position
    tput rc
}


menu (){
clear
print_fixed_line
echo "                              ┏   ┏┓        ┓┏  ┓   • ┓  ┏┓┓     ┓   ┓"
echo "           _\|/_             ━┫   ┃┃┏┓┏┓┏┓  ┣┫┓┏┣┓┏┓┓┏┫  ┃ ┃┏┓┓┏┏┫   ┣━"
echo "           (o o)              ┗   ┗┛┣┛┗ ┛┗  ┛┗┗┫┗┛┛ ┗┗┻  ┗┛┗┗┛┗┻┗┻   ┛"
echo " ┏━━━━━━oOO.{-}.OOo━━━━━━━┳━━━━━━━━━┛━━━━━━━━━━┛━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━[Capters]━┓"
echo " ┃  ╦═╗╔═╗╔╦╗  ╦ ╦╔═╗╔╦╗  ┃      ╔╦╗╔═╗╦═╗╔═╗       ┃ \033[4m\033[1;37mc1\033[0m Risk Management       \033[4m\033[1;37mc2\033[0m Incident Reports     ┃"
echo " ┃  ╠╦╝║╣  ║║  ╠═╣╠═╣ ║   ┃       ║║║ ║╠╦╝╠═╣       ┃ \033[4m\033[1;37mc3\033[0m Resilience Testing    \033[4m\033[1;37mc4\033[0m Third Party Risk     ┃"
echo " ┃  ╩╚═╚═╝═╩╝  ╩ ╩╩ ╩ ╩   ┃      ═╩╝╚═╝╩╚═╩ ╩       ┃ \033[4m\033[1;37mc5\033[0m Information sharing                           ┃"
echo " ┣━━━━━━━━━━━━━━━━━━━━━━━━╋━━━━━━━━━━━━━━━━━━━━━━━━━╋━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫"
echo " ┃  ┳┓┏┓                  ┃  ┏┓┓ ┏┏┓                ┃  ┏┓┏┓┳┳┳┓┏┓         ┃  ┏┓┏┓┳┳┳┓┏┓  ┳┓┏┓┏┳┓┳┓┏┏┓  ┃"
echo " ┃  ┃┃┃                   ┃  ┣┫┃┃┃┗┓                ┃  ┣┫┏┛┃┃┣┫┣          ┃  ┣┫┏┛┃┃┣┫┣   ┃┃┣┫ ┃ ┃┃┃┣   ┃"
echo " ┃  ┻┛┗┛                  ┃  ┛┗┗┻┛┗┛                ┃  ┛┗┗┛┗┛┛┗┗┛         ┃  ┛┗┗┛┗┛┛┗┗┛  ┛┗┛┗ ┻ ┻┗┛┗┛  ┃"
echo " ┣━━━━━━━━━━━━━━━━━━━━━━━━╋━━━━━━━━━━━━━━━━━━━━━━━━━╋━━━━━━━━━━━━━━━━━━━━━╋━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫"
echo " ┃ ${menu_array[1]}                ┃ ${menu_array[2]}                 ┃ ${menu_array[3]}             ┃ ${menu_array[4]}                    ┃"
echo " ┃ ${menu_array[5]}        ┃ ${menu_array[6]}         ┃ ${menu_array[7]}     ┃ ${menu_array[8]}            ┃"
echo " ┃ ${menu_array[9]}      ┃ ${menu_array[10]}      ┃ ${menu_array[11]}  ┃ ${menu_array[12]}         ┃"
echo " ┣━━━━━━━━━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━━━━━━━╋━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛"
echo " ┃  [l] Link All        [e] Expose DB service        [d] Delete all       ┃ $RESULT"
echo " ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛"

}

menu

while true
do
read n
MS = ""
case $n in
"1")
# DC
oc login --server=$DC_URL -u $DC_UID -p $DC_PWD --insecure-skip-tls-verify=true
oc project battalion-fox-team
skupper init --enable-console --enable-flow-collector --console-auth unsecured --site-name dc-site
skupper token create aws_to_dc.token
skupper token create azure_to_dc.token
skupper token create azure_native_to_dc.token
menu_array["1"]="\033[43m1) init\033[0m"
;;

"2")
#AWS
oc login --server=$AWS_URL -u $AWS_UID -p $AWS_PWD --insecure-skip-tls-verify=true
oc project battalion-fox-team
skupper init --enable-console --enable-flow-collector --console-auth unsecured --site-name aws-site
menu_array["2"]="\033[43m2) init\033[0m"
;;

"3")
#AZURE
oc login --server=$AZURE_URL -u $AZURE_UID -p $AZURE_PWD --insecure-skip-tls-verify=true
oc project battalion-fox-team
skupper init --enable-console --enable-flow-collector --console-auth unsecured --site-name azure-site
menu_array["3"]="\033[43m3) init\033[0m"
;;

"4")
# Azure Native DB
oc login --server=$DC_URL -u $DC_UID -p $DC_PWD --insecure-skip-tls-verify=true
oc project battalion-fox-team-azure
skupper init --enable-console --enable-flow-collector --console-auth unsecured --site-name azure-native-site
menu_array["4"]="\033[43m4) init\033[0m"
;;


"5")
# DC Bind
oc login --server=$DC_URL -u $DC_UID -p $DC_PWD --insecure-skip-tls-verify=true
oc project battalion-fox-team
skupper service bind postgresql service postgresqldb
menu_array["5"]="\033[43m5) bind service\033[0m"
menu_array["9"]="9) unbind service"
;;

"6")
# bind service on AWS
oc login --server=$AWS_URL -u $AWS_UID -p $AWS_PWD --insecure-skip-tls-verify=true
oc project battalion-fox-team
skupper service bind postgresql service postgresqldb
menu_array["6"]="\033[43m6) bind service\033[0m"
menu_array["10"]="10) unbind service"
;;

"7")
# bind service on Azure
oc login --server=$AZURE_URL -u $AZURE_UID -p $AZURE_PWD --insecure-skip-tls-verify=true
oc project battalion-fox-team
skupper service bind postgresql service postgresqldb
menu_array["7"]="\033[43m7) bind service\033[0m"
menu_array["11"]="11) unbind service"
;;

"8")
# bind Azure Native DB
oc login --server=$DC_URL -u $DC_UID -p $DC_PWD --insecure-skip-tls-verify=true
oc project battalion-fox-team-azure
skupper service bind postgresql service azure-postgresql-service
menu_array["8"]="\033[43m8) bind service\033[0m"
menu_array["12"]="12) unbind service"
;;



"9")
# DC unbind
# unbind the service in DC to see the impact
oc login --server=$DC_URL -u $DC_UID -p $DC_PWD --insecure-skip-tls-verify=true
oc project battalion-fox-team
skupper service unbind postgresql service postgresqldb
menu_array["9"]="\033[43m9) unbind service\033[0m"
menu_array["5"]="5) bind service"
;;

"10")
# unbind service on AWS
oc login --server=$AWS_URL -u $AWS_UID -p $AWS_PWD --insecure-skip-tls-verify=true
oc project battalion-fox-team
skupper service unbind postgresql service postgresqldb
menu_array["10"]="\033[43m10) unbind service\033[0m"
menu_array["6"]="6) bind service"
;;

"11")
# unbind service on Azure
oc login --server=$AZURE_URL -u $AZURE_UID -p $AZURE_PWD --insecure-skip-tls-verify=true
oc project battalion-fox-team
skupper service unbind postgresql service postgresqldb
menu_array["11"]="\033[43m11) unbind service\033[0m"
menu_array["7"]="7) bind service"
;;

"12")
# unbind Azure Native DB
oc login --server=$DC_URL -u $DC_UID -p $DC_PWD --insecure-skip-tls-verify=true
oc project battalion-fox-team-azure
skupper service unbind postgresql service azure-postgresql-service
menu_array["12"]="\033[43m12) unbind service\033[0m"
menu_array["8"]="8) bind service"
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

"c1")
MSG="[c1] Business continuity policies and disaster recovery plans as a C-level responsibility"
;;
"c2")
MSG="[c2] Harmonization of mandatory incident reporting frameworks (e.g. GDPR, NIS, eIDAs, SSM, PSD2)"
;;
"c3")
MSG="[c3] At least annually, including remediation plans with ICT third party providers direct involvement"
;;
"c4")
MSG="[c4] Critical ICT Third-Parties subject to an EU oversight framework under a financial European Supervisory Authority"
;;
"c5")
MSG="[c5] Voluntary exchange of threat information & Intelligence are allowed and supported"
;;

esac

#RESULT="\033[43m step $n is done\033[0m"
RESULT="\033[4m\033[1;37mstep $n is done\033[0m"
menu "done" $n

done
