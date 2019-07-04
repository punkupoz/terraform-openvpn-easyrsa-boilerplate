#!/bin/bash

# Sleep until boot finished
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
  sleep 1
done

sudo apt update

# Install packages
sudo apt install openssl -y
sudo apt install openvpn -y
curl -L https://github.com/OpenVPN/easy-rsa/archive/3.0.1.tar.gz -o /home/ubuntu/easy-rsa.tar.gz
tar xzvf /home/ubuntu/easy-rsa.tar.gz
rm /home/ubuntu/easy-rsa.tar.gz

# Enable ipv4 package forward
sudo sed -i "s/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g" /etc/sysctl.conf
sudo sysctl -p
