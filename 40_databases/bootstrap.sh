#!/bin/bash

component=$1
dnf install ansible -y
ansible-pull -U https://github.com/YadavEshNithin/ansible_roles.git -e component=$1 -e env=$2 main.yaml




###################
# #!/bin/bash

# component=$1
# MYSQL_ROOT_PASSWORD=$2

# dnf install ansible -y

# if [ "$component" == "mysql" ]
# then
#     mysql_secure_installation --set-root-pass $MYSQL_ROOT_PASSWORD
#     ansible-pull -U https://github.com/YadavEshNithin/ansible_roles.git -e component=$1 -e mysql_root_password=$MYSQL_ROOT_PASSWORD  main.yaml
# else
#     component=$1
#     ansible-pull -U https://github.com/YadavEshNithin/ansible_roles.git -e component=$1 main.yaml
# fi