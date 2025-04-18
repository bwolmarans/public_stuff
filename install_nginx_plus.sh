#!/bin/bash
# 
# NGINX Plus Simple Install Script
# --------------------------------
# b.wolmarans@f5.com 4/8/2025
#
echo ""
echo "NGINX Plus Simple Install Script"
echo "--------------------------------"
echo "b.wolmarans@f5.com"
echo ""
echo ""
echo "-------------------------------------------------------------------------------"
echo "Changing to home directory of user ubuntu"
echo "-------------------------------------------------------------------------------"
echo ""
cd ~ubuntu
echo ""
echo "-------------------------------------------------------------------------------"
echo "Installing a few pre-requisite packages such a wget, etc"
echo "-------------------------------------------------------------------------------"
echo ""
echo Y | sudo apt-get install apt-transport-https lsb-release ca-certificates wget gnupg2 ubuntu-keyring
echo ""
echo "-------------------------------------------------------------------------------"
echo "Installing NGINX Plus repository signing key"
echo "-------------------------------------------------------------------------------"
echo ""
wget -qO - https://cs.nginx.com/static/keys/nginx_signing.key | gpg --dearmor | sudo tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null
echo ""
echo "-------------------------------------------------------------------------------"
echo "Adding repo information to the /etc/apt/source.list.d"
echo "-------------------------------------------------------------------------------"
echo ""
printf "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] https://pkgs.nginx.com/plus/ubuntu `lsb_release -cs` nginx-plus\n" | sudo tee /etc/apt/sources.list.d/nginx-plus.list
echo ""
echo "-------------------------------------------------------------------------------"
echo "Getting the 90pkgs-nginx files and placing them in /etc/apt/apt.conf.d"
echo "-------------------------------------------------------------------------------"
echo ""
sudo wget -P /etc/apt/apt.conf.d https://cs.nginx.com/static/files/90pkgs-nginx
echo ""
echo "-------------------------------------------------------------------------------"
echo "Doing an apt-get update"
echo "-------------------------------------------------------------------------------"
echo ""
echo Y | sudo apt-get update
echo ""
echo "-------------------------------------------------------------------------------"
echo "Backing up NGINX Plus files because the install will replace them with defaults"
echo "-------------------------------------------------------------------------------"
echo ""
sudo mkdir /etc/nginx-plus-backup 
sudo cp -a /etc/nginx /etc/nginx-plus-backup
sudo cp -a /var/log/nginx /var/log/nginx-plus-backup
echo ""
echo "-------------------------------------------------------------------------------"
echo "Installing NGINX Plus"
echo "-------------------------------------------------------------------------------"
echo ""
echo Y | sudo apt-get install -y nginx-plus
echo ""
echo "-------------------------------------------------------------------------------"
echo "Backing up the NGINX Plus default files that were just installed"
echo "-------------------------------------------------------------------------------"
echo ""
sudo mkdir /etc/nginx-default-install-files
sudo cp -a /etc/nginx /etc/nginx-default-install-files
echo ""
echo "-------------------------------------------------------------------------------"
echo "Restoring the backup of the original NGINX Plus files"
echo "-------------------------------------------------------------------------------"
echo ""
sudo cp -a /etc/nginx-plus-backup /etc/nginx
echo ""
echo "-------------------------------------------------------------------------------"
echo "Restarting NGINX Plus"
echo "-------------------------------------------------------------------------------"
echo ""
sudo systemctl restart nginx
echo ""
echo "-------------------------------------------------------------------------------"
echo "Checking status of NGINX Plus"
echo "-------------------------------------------------------------------------------"
echo ""
systemctl status nginx
echo ""
echo "-------------------------------------------------------------------------------"
echo "Checking NGINX Plus version"
echo "-------------------------------------------------------------------------------"
echo ""
nginx -v
echo ""
echo "-------------------------------------------------------------------------------"
echo "Enabling NGINX Plus to start on startup"
echo "-------------------------------------------------------------------------------"
echo ""
sudo systemctl enable nginx
echo ""
echo "-------------------------------------------------------------------------------"
echo "Testing a curl to some common local ports, a 000 code means it failed."
echo "-------------------------------------------------------------------------------"
echo ""
echo "Testing 127.0.0.1:80"
curl -s -o /dev/null -w "%{http_code}" 127.0.0.1
echo ""
echo "Testing 127.0.0.1:8080"
curl -s -o /dev/null -w "%{http_code}" 127.0.0.1:8080
echo ""
echo "Testing https://127.0.0.1:443"
curl -k -s -o /dev/null -w "%{http_code}" 127.0.0.1:443
echo ""
echo "Testing https://127.0.0.1:8443"
curl -k -s -o /dev/null -w "%{http_code}" https://127.0.0.1:8443
echo ""
echo ""
echo "-------------------------------------------------------------------------------"
echo "Done"
echo "-------------------------------------------------------------------------------"
echo ""
