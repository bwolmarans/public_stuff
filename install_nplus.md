Install NGINX+ on Ubuntu
-------------------------

* You need a trial from myF5 of N+ nginx-repo.cert and nginx-repo.key.  Get both of these files you're going to need them.
* Now you're going to add your NGINX Plus repo cert and key to /etc/ssl/nginx. You will need to be root or use sudo. Use vi, use echo, use a heredoc, use any tool you want with some copy paste magic.   As you can see I'm using root here. 
```bash
sudo apt-get update
sudo bash
cd /etc/ssl
mkdir nginx
cd nginx
echo '<paste the text of your repo crt>' > nginx-repo.crt
echo '<paste the text of your repo key>' > nginx-repo.key
```
* When are done with this, if you used root, you can exit back out of root
```bash
exit 
```
```bash
cd ~ubuntu
echo Y | sudo apt-get install apt-transport-https lsb-release ca-certificates wget gnupg2 ubuntu-keyring
```
```bash
wget -qO - https://cs.nginx.com/static/keys/nginx_signing.key | gpg --dearmor | \
sudo tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null
```
```bash
printf "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] \
https://pkgs.nginx.com/plus/ubuntu `lsb_release -cs` nginx-plus\n" | \
sudo tee /etc/apt/sources.list.d/nginx-plus.list
```
```bash
sudo wget -P /etc/apt/apt.conf.d https://cs.nginx.com/static/files/90pkgs-nginx
echo Y | sudo apt-get update
echo Y | sudo apt-get install -y nginx-plus
```
```bash
sudo systemctl restart nginx
systemctl status nginx
sudo systemctl enable nginx
```
