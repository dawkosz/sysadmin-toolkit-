#!/bin/bash

# 👋 Pierwsze kroki na świeżym serwerze (Ubuntu/Debian)

echo "== Aktualizacje systemu =="
apt update && apt upgrade -y

echo "== Ustaw hostname =="
read -p "Podaj hostname: " newhost
hostnamectl set-hostname "$newhost"

echo "== Dodaj nowego usera =="
read -p "Nazwa użytkownika: " username
adduser "$username"
usermod -aG sudo "$username"

echo "== Dodaj klucz SSH dla $username =="
mkdir -p /home/$username/.ssh
read -p "Wklej publiczny klucz SSH: " sshkey
echo "$sshkey" >> /home/$username/.ssh/authorized_keys
chown -R $username:$username /home/$username/.ssh
chmod 600 /home/$username/.ssh/authorized_keys

echo "== Wyłącz logowanie root hasłem =="
sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
systemctl restart ssh

echo "== Gotowe! Nowy użytkownik ma dostęp przez SSH =="

