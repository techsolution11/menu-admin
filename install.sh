#!/bin/bash
if [ "${EUID}" -ne 0 ]; then
  echo "You need to run this script as root"
  exit 1
fi
if [ "$(systemd-detect-virt)" == "openvz" ]; then
  echo "OpenVZ is not supported"
  exit 1
fi

# Color Validation
DF='\e[39m'
Bold='\e[1m'
Blink='\e[5m'
yell='\e[33m'
red='\e[31m'
green='\e[32m'
blue='\e[34m'
PURPLE='\e[35m'
CYAN='\e[36m'
Lred='\e[91m'
Lgreen='\e[92m'
Lyellow='\e[93m'
NC='\e[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
CYAN='\e[36m'
LIGHT='\033[0;37m'
MYIP=$(curl -s https://icanhazip.com)
echo "Checking VPS"
cek=$(curl -sS https://raw.githubusercontent.com/techsolution11/admin-ip/main/access | grep $MYIP)
if [ $cek = $MYIP ]; then
  echo -e "${green}Permission Accepted...${NC}"
else
  echo -e "${red}Permission Denied!${NC}"
  echo "Your IP NOT REGISTER / EXPIRED"
  exit 0
fi
clear

# install Admin Menu
echo -e "$green   =============================================$NC"
echo -e "$green                 Install Admin Menu              $NC"
echo -e "$green   =============================================$NC"
sleep 2
wget -O /usr/bin/add-ip https://raw.githubusercontent.com/techsolution11/menu-admin/main/add-ip.sh && chmod +x /usr/bin/add-ip
wget -O /usr/bin/del-ip https://raw.githubusercontent.com/techsolution11/menu-admin/main/del-ip.sh && chmod +x /usr/bin/del-ip
wget -O /usr/bin/renew-ip https://raw.githubusercontent.com/techsolution11/menu-admin/main/renew-ip.sh && chmod +x /usr/bin/renew-ip
wget -O /usr/bin/cek-ip https://raw.githubusercontent.com/techsolution11/menu-admin/main/cek-ip.sh && chmod +x /usr/bin/cek-ip
wget -O /usr/bin/menu-admin https://raw.githubusercontent.com/techsolution11/menu-admin/main/menu-admin.sh && chmod +x /usr/bin/menu-admin
wget -O /usr/bin/exp-ip https://raw.githubusercontent.com/techsolution11/menu-admin/main/exp-ip.sh && chmod +x /usr/bin/exp-ip

echo "1 0 * * * root /usr/bin/exp-ip # delete expired IP VPS License" >>/etc/crontab

sleep 2
clear

echo ""
rm -f /root/install.sh
rm -f /root/.bash_history
sleep 5
echo " Setelah Selesai type menu-admin"
