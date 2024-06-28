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
wine reg add "HKCU\\Software\\Wine\\Direct3D" /v DirectDrawRenderer /t REG_SZ /d gdi /f
wine reg add "HKCU\\Software\\Wine\\Direct3D" /v VideoMemorySize /t REG_SZ /d 2048 /f
wineserver -k
#
export WINEPREFIX=~/.wine
#
winetricks --force dxvk
#
wget https://raw.githubusercontent.com/k-oden2/SW/main/Registry -O Registry.zip
# EXTRACT FILE
unzip Registry.zip 
mv Registry.zip
wineserver -k

echo "DONE"

# ADD LC JP
sudo apt-get install language-pack-ja -y
sudo apt update
wineboot

# EXPLORER
echo -e "[Desktop Entry]\nName=Explorer\nExec=env wine explorer.exe\nType=Application\nStartupNotify=true\nPath=/home/user/.wine/drive_c:/windows\nStartupWMClass=explorer.exe\nIcon=1CD8_rundll32.0\nComment=\nTerminal=false" > ~/Desktop/Explorer.desktop
# EXPLORER JP
echo -e "[Desktop Entry]\nName=Explorer JP\nExec=env LANG=\"ja_JP.UTF8\" wine explorer.exe\nType=Application\nStartupNotify=true\nPath=/home/user/.wine/drive_c:/windows\nStartupWMClass=explorer.exe\nIcon=1CD8_rundll32.0\nComment=\nTerminal=false" > ~/Desktop/Explorer_JP.desktop
# Explorer DXVK
echo -e "[Desktop Entry]\n\
Name=Explorer JP\n\
Exec=env LANG=\"ja_JP.UTF8\" WINEPREFIX=\"/home/user/.wine\" DXVK_HUD=1 wine explorer.exe\n\
Type=Application\n\
StartupNotify=true\n\
Path=/home/user/.wine/drive_c/windows\n\
StartupWMClass=explorer.exe\n\
Icon=1CD8_rundll32.0\n\
Comment=\n\
Terminal=false" > ~/Desktop/Exp_DXVK.desktop

# PERMISSION 
chmod +x ~/Desktop/Explorer.desktop
chmod +x ~/Desktop/Explorer_JP.desktop
chmod +x ~/Desktop/Exp_DXVK.desktop
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
