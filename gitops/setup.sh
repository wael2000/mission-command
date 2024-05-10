function PP () {
  local longest=0
  local string_array=("${@}")
  for i in "${string_array[@]}"; do
    if [[ "${#i}" -gt "${longest}" ]]; then
      local longest=${#i}
      local longest_line="${i}" # Longest line
    fi
  done
  local edge=$(echo "$longest_line" | sed 's/./#/g' | sed 's/^#/###/' | sed 's/#$/###/')
  local middle_edge=$(echo "$longest_line" | sed 's/./\ /g' | sed 's/^\ /#\  /' | sed 's/\ $/\ \ #/')
  echo "\n${edge}"
  echo "${middle_edge}"
  for i in "${string_array[@]}"; do
    local length_i=${#i}
    local length_ll="${#longest_line}"
    if [[ "${length_i}" -lt "${length_ll}"  ]]; then
            printf "# "
            local remaining_spaces=$((length_ll-length_l))
            printf "${i}"
            while [[ ${remaining_spaces} -gt ${#i} ]]; do
                    printf " "
                    local remaining_spaces=$((remaining_spaces-1))
            done
            printf " #\n"
    else
      echo "# ${i} #"
    fi
  done
  echo "${middle_edge}"
  echo "${edge}\n"
}

# Azure
AZURE_URL=$(yq e '.azure.api-url' env.yaml)
AZURE_TOEKN=$(yq e '.azure.token' env.yaml)
PP "Azure" " URL=  $AZURE_URL"  " TOKEN= $AZURE_TOEKN"
# DC
DC_URL=$(yq e '.dc.api-url' env.yaml)
DC_TOEKN=$(yq e '.dc.token' env.yaml)
PP "DC" " URL=  $DC_URL"  " TOKEN= $DC_TOEKN"
# AWS
AWS_URL=$(yq e '.aws.api-url' env.yaml)
AWS_TOEKN=$(yq e '.aws.token' env.yaml)
PP "AWS" " URL=  $AWS_URL"  " TOKEN= $AWS_TOEKN"


# add project to GitOps 
oc label ns mc-datacenter argocd.argoproj.io/managed-by=openshift-gitops --overwrite

# Gitops permissions 
# create ocp-admins group
oc adm groups new cluster-admins
# give cluster admin rightsto ocp-admins group
oc adm policy add-cluster-role-to-group cluster-admin cluster-admins
# add username to ocp-admins group
oc adm groups add-users cluster-admins admin


Unable to create application: application spec for db is invalid: InvalidSpecError: Unable to generate manifests in gitops/db: rpc error: code = Unknown desc = gitops/db: app path does not exist


#oc login --token=$AZURE_TOKEN --server=$AZURE_URL --insecure-skip-tls-verify=true

