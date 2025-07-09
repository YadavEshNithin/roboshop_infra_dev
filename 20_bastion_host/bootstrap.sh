#!/bin/bash

sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum -y install terraform

# --- Install AWS CLI ---
# This is crucial for local-exec provisioners within Terraform modules
# that might call 'aws' commands.
echo "Installing AWS CLI..."
sudo yum install -y unzip

# Download the AWS CLI v2 installer bundle
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

# Unzip the downloaded package
# Added -o flag to overwrite existing files without prompting, preventing hangs.
unzip -o awscliv2.zip

# Run the AWS CLI installer.
# Added --update flag to handle existing installations gracefully.
# By default, this installs AWS CLI to /usr/local/aws-cli and creates a symlink
# in /usr/local/bin, which is typically in the system's PATH.
sudo ./aws/install --update

# Ensure /usr/local/bin is in PATH for the current script session.
# This is important because non-interactive shells might not fully source .profile or .bashrc.
export PATH="/usr/local/bin:$PATH"

# Verify the installation. If it fails, the script will exit due to 'set -e'.
aws --version || { echo "AWS CLI installation failed. Exiting."; exit 1; }
echo "AWS CLI installed successfully."


sudo growpart /dev/nvme0n1 4
sudo lvextend -L +20G /dev/RootVG/rootVol
sudo lvextend -L +10G /dev/RootVG/homeVol 

sudo xfs_growfs /

sudo xfs_growfs /home

git clone https://github.com/YadavEshNithin/roboshop_infra_dev.git

cd roboshop_infra_dev/

for i in 40_databases/ 90_components/ ;
do  cd "$i" ; 
terraform init ;
terraform apply -auto-approve ; 
cd ..; 
done
