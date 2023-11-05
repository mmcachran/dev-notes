# https://www.digitalocean.com/community/tutorials/initial-server-setup-with-ubuntu-20-04

ssh root@157.230.178.203
adduser toptaco
usermod -aG sudo toptaco
ufw app list
ufw allow OpenSSH
ufw enable
ufw status


rsync --archive --chown=toptaco:toptaco ~/.ssh /home/toptaco
sudo apt update
sudo apt install wireguard

toptaco@wireguard:~$ wg genkey | sudo tee /etc/wireguard/private.key
MGDQSKWoQUIeJoGZC0iy1sbJ9+qsBq6Y+wV82O+3O2Q=
toptaco@wireguard:~$ sudo chmod go= /etc/wireguard/private.key
toptaco@wireguard:~$ sudo cat /etc/wireguard/private.key | wg pubkey | sudo tee /etc/wireguard/public.key
Cn3mTR3EuuunUskYbl21ATNYg/a0V2uen/Mlmj8ZSF8=