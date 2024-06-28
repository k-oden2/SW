#!/usr/bin/env bash
# shellcheck disable=SC2140,SC2086

# INSTALL WINE
sudo dpkg --add-architecture i386
wget -nc https://dl.winehq.org/wine-builds/winehq.key
sudo apt-key add winehq.key
sudo add-apt-repository -y 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main'
sudo apt update
sudo apt install -y --install-recommends winehq-stable
# WINE UPDATE
cd
wine --version

# SET DPI
echo -e "REGEDIT4\n\n[HKEY_CURRENT_USER\\Control Panel\\Desktop]\n\"LogPixels\"=hex:60,00,00,00" > dpi.reg
wine regedit dpi.reg

# DEL
cd
rm dpi.reg

# ADD DRIVE
cd .wine
ln -s "/home/user" dosdevices/d:
ln -s /home/user/Downloads/ ~/Desktop/Downloads

# WINETRICKS
cd
sudo apt-get install -y winetricks
sudo apt install -y zenity
wineserver -k
winetricks --self-update
winetricks --unattended alldlls=builtin
#
wine reg add "HKCU\\Software\\Wine\\Direct3D" /v UseGLSL /t REG_SZ /d disabled /f
wine reg add "HKCU\\Software\\Wine\\Direct3D" /v StrictDrawOrdering /t REG_SZ /d enabled /f
wine reg add "HKCU\\Software\\Wine\\Direct3D" /v DirectDrawRenderer /t REG_SZ /d opengl /f
wine reg add "HKCU\\Software\\Wine\\Direct3D" /v VideoMemorySize /t REG_SZ /d 4096 /f
wineserver -k
#
export WINEPREFIX=~/.wine
#
winetricks --force dxvk -y

#
cd
wget https://raw.githubusercontent.com/k-oden2/SW/main/Registry.zip -O Registry.zip
# EXTRACT FILE
cd
unzip Registry.zip
mv Registry.zip

wineserver -k

echo "DONE"

# ADD LC JP
sudo apt-get install language-pack-ja -y
sudo apt update
wineboot

# EXPLORER EN
echo -e "[Desktop Entry]\n\
Name=wine\n\
Exec=env LANG=\"en_US.UTF8\" WINEPREFIX=\"/home/user/.wine\" DXVK_HUD=1 wine explorer.exe\n\
Type=Application\n\
StartupNotify=true\n\
Path=/home/user/.wine/drive_c/windows\n\
StartupWMClass=explorer.exe\n\
Icon=1CD8_rundll32.0\n\
Comment=\n\
Terminal=false" > ~/Desktop/wine_EN.desktop
# Explorer JP
echo -e "[Desktop Entry]\n\
Name=wine DXVK\n\
Exec=env LANG=\"ja_JP.UTF8\" WINEPREFIX=\"/home/user/.wine\" DXVK_HUD=1 wine explorer.exe\n\
Type=Application\n\
StartupNotify=true\n\
Path=/home/user/.wine/drive_c/windows\n\
StartupWMClass=explorer.exe\n\
Icon=1CD8_rundll32.0\n\
Comment=\n\
Terminal=false" > ~/Desktop/wine_JP.desktop

# PERMISSION 
chmod +x ~/Desktop/wine_EN.desktop
chmod +x ~/Desktop/wine_JP.desktop
# CLEAN
sudo apt-get clean
sudo apt-get autoclean -y
sudo apt-get autoremove -y
sudo apt update

# DONE
clear
echo -e "\e[31mDone\e[0m"

#DL 
wget https://files2.codecguide.com/K-Lite_Codec_Pack_1840_Standard.exe -O K-lite.exe

wget https://aka.ms/vs/17/release/vc_redist.x86.exe -O vcr32.exe

wget https://aka.ms/vs/17/release/vc_redist.x64.exe -O vcr64.exe
