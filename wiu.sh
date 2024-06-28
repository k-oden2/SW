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
wineserver -k
#
export WINEPREFIX=~/.wine
#
winetricks --force dxvk -y
wineserver -k
#
wine reg add "HKCU\Software\Wine\Direct3D" /v "AlwaysOffscreen" /t REG_SZ /d "enabled" /f
wine reg add "HKCU\Software\Wine\Direct3D" /v "CheckFloatConstants" /t REG_SZ /d "disabled" /f
wine reg add "HKCU\Software\Wine\Direct3D" /v "csmt" /t REG_DWORD /d 0x00000003 /f
wine reg add "HKCU\Software\Wine\Direct3D" /v "DirectDrawRenderer" /t REG_SZ /d "gdi" /f
wine reg add "HKCU\Software\Wine\Direct3D" /v "MaxVersionGL" /t REG_DWORD /d 0x00030002 /f
wine reg add "HKCU\Software\Wine\Direct3D" /v "MultisampleTextures" /t REG_DWORD /d 0x00000001 /f
wine reg add "HKCU\Software\Wine\Direct3D" /v "Multisampling" /t REG_SZ /d "disabled" /f
wine reg add "HKCU\Software\Wine\Direct3D" /v "OffScreenRenderingMode" /t REG_SZ /d "fbo" /f
wine reg add "HKCU\Software\Wine\Direct3D" /v "PixelShaderMode" /t REG_SZ /d "enabled" /f
wine reg add "HKCU\Software\Wine\Direct3D" /v "renderer" /t REG_SZ /d "gl" /f
wine reg add "HKCU\Software\Wine\Direct3D" /v "RenderTargetLockMode" /t REG_SZ /d "readdraw" /f
wine reg add "HKCU\Software\Wine\Direct3D" /v "SampleCount" /t REG_DWORD /d 0x00000001 /f
wine reg add "HKCU\Software\Wine\Direct3D" /v "shader_backend" /t REG_SZ /d "glsl" /f
wine reg add "HKCU\Software\Wine\Direct3D" /v "strict_shader_math" /t REG_DWORD /d 0x00000001 /f
wine reg add "HKCU\Software\Wine\Direct3D" /v "UseGLSL" /t REG_SZ /d "enabled" /f
wine reg add "HKCU\Software\Wine\Direct3D" /v "VertexBufferMode" /t REG_SZ /d "hardware" /f
wine reg add "HKCU\Software\Wine\Direct3D" /v "VertexShaderMode" /t REG_SZ /d "hardware" /f
wine reg add "HKCU\Software\Wine\Direct3D" /v "VideoDescription" /t REG_SZ /d "NVIDIA GeForce GTX 470" /f
wine reg add "HKCU\Software\Wine\Direct3D" /v "VideoDriver" /t REG_SZ /d "nv4_disp.dll" /f
wine reg add "HKCU\Software\Wine\Direct3D" /v "VideoMemorySize" /t REG_SZ /d "204648" /f
wine reg add "HKCU\Software\Wine\Direct3D" /v "VideoPciDeviceID" /t REG_DWORD /d 0x000067df /f
wine reg add "HKCU\Software\Wine\Direct3D" /v "VideoPciVendorID" /t REG_DWORD /d 0x00001002 /f
wine reg add "HKCU\Software\Wine\Direct3D" /v "VideoMemoryManagement" /t REG_SZ /d "enabled" /f
wine reg add "HKCU\Software\Wine\Direct3D" /v "VideoCardRam" /t REG_SZ /d "2048" /f
wine reg add "HKCU\Software\Wine\Direct3D" /v "UseVRAMSize" /t REG_SZ /d "true" /f
wine reg add "HKCU\Software\Wine\Direct3D" /v "OffscreenRenderingMode" /t REG_SZ /d "fbo" /f
#
wineserver -k
#
cd
wget https://raw.githubusercontent.com/k-oden2/SW/main/Registry.zip -O Registry.zip
# EXTRACT FILE
cd
unzip Registry.zip
rm Registry.zip

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
