#!/bin/bash

sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum -y install terraform

sudo growpart /dev/nvme0n1 4
sudo lvextend -L +20G /dev/RootVG/rootVol
sudo lvextend -L +10G /dev/RootVG/homeVol 

sudo xfs_growfs /

sudo xfs_growfs /home

git clone https://github.com/YadavEshNithin/roboshop_infra_dev.git

cd roboshop_infra_dev/

for i in 20_bastion_host/ ;
do  cd "$i" ; 
terraform init ;
terraform apply -auto-approve ; 
cd ..; 
done
