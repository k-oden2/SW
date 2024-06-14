#!/usr/bin/env bash

echo '123456' | sudo -S yourCommand

# NO PASSWORD
echo "user ALL=(ALL) NOPASSWD: ALL" | sudo EDITOR="tee -a" visudo

# SCRIPT
# SET DPI
xfconf-query -c xsettings -n -t int -p "/Xft/DPI" -s 96

# INSTALL FONTS
sudo apt update
wget https://raw.githubusercontent.com/k-oden2/SW/main/Fonts.zip -O FONTSPACK.zip

# INSTALL UNIZP
sudo apt install -y unzip

# EXTRACT FILE
unzip FONTSPACK.zip

mv Fonts .fonts

# DEL
cd
rm FONTSPACK.zip

# FIX FONTS
sudo apt-get install --reinstall --purge fontconfig fontconfig-config
sudo apt update

# CHANGE SIZE & THEME 
xfconf-query -c xfce4-panel -p /panels/panel-1/size -t int -s 28

ls /usr/share/themes/
xfconf-query -c xfwm4 -p /general/theme -s "Default-hdpi"

xfconf-query -c xsettings -p /Gtk/FontConfig/TitleFontSize -s "12"

# CHROME UPDATE
sudo apt -y purge google-chrome-stable
sudo apt -y autoremove

#
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt --fix-broken install -y

# DEL DB
cd
rm google-chrome-stable_current_amd64.deb

# PEAZIP
wget https://github.com/peazip/PeaZip/releases/download/9.1.0/peazip_9.1.0.LINUX.GTK2-1_amd64.deb
sudo dpkg -i peazip_9.1.0.LINUX.GTK2-1_amd64.deb

# DEL DEB
cd
rm peazip_9.1.0.LINUX.GTK2-1_amd64.deb

# PURGE
sudo apt purge firefox -y
sudo apt purge xarchiver -y
# PERMISSION
sudo chmod 777 /

# CLEAN
sudo apt-get clean
sudo apt-get autoclean -y
sudo apt-get autoremove -y
sudo apt update

# Done
clear
echo -e "\e[31mDone\e[0m"
