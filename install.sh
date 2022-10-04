#!/bin/sh
#
# Goorm.io Initialization Script
#
# Installed Services 
# - TigerVNCServer v1.8.0 for Ubuntu 14.04 LTS
# - Nanum Fonts
# - XFCE4 with Goodies
# - Korean language support

echo "Username [ENTER]: "
read USERNAME

apt-get update
apt-get install xfce4 xfce4-goodies -y
apt-get autoremove tightvncserver --purge -y
wget "https://bintray.com/tigervnc/stable/download_file?file_path=ubuntu-14.04LTS%2Famd64%2Ftigervncserver_1.8.0-3ubuntu1_amd64.deb" -O "tigervncserver_1.8.0-3ubuntu1_amd64.deb"
dpkg -i tigervncserver_1.8.0-3ubuntu1_amd64.deb

# Install required dependency files
apt-get install -f -y

adduser $USERNAME
usermod -aG sudo $USERNAME

echo -e "\nLANG=\"en_US.UTF-8\"\nLANGUAGE=\"us:en\"" > /etc/default/locale
echo -e "\nLANG=\"en_US.UTF-8\"\nLANGUAGE=\"us:en\"" > ~$USERNAME/.pam_environment

# Configure VNC Server to run with port 5900
su -c "vncserver -geometry 1280x720 :0" $USERNAME 
su -c "vncserver -kill :0" $USERNAME

cd /home/$USERNAME/.vnc
mv xstartup xstartup.original
echo "xfce4-session &" > xstartup
chown $USERNAME.$USERNAME xstartup
chmod +x xstartup

# Configure noVNC server
cd /home/$USERNAME/
git clone https://github.com/novnc/noVNC.git noVNC
echo -e "rm -rf /tmp/.X0-lock /tmp/.X11-unix\nsu -c \"vncserver :0 -geometry 1680x920\" $USERNAME\n/home/$USERNAME/noVNC/utils/launch.sh --listen 80 --vnc localhost:5900 --web /home/$USERNAME/noVNC/" > start_vnc.sh
chmod +x start_vnc.sh
./start_vnc.sh

