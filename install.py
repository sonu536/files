import os

cmd = 'sudo apt update'
os.system(cmd)
cmd = 'sudo DEBIAN_FRONTEND=noninteractive apt install --assume-yes xfce4 desktop-base xfce4-terminal tightvncserver novnc websockify autocutsel dbus-x11'
os.system(cmd)
cmd = 'sudo apt remove --assume-yes gnome-terminal'
os.system(cmd)
cmd = 'sudo apt install xscreensaver -y'
os.system(cmd)
cmd = 'sudo apt install firefox-esr -y'
os.system(cmd)
cmd = 'vncserver'
os.system(cmd)
cmd = 'vncserver kill :1'
os.system(cmd)
cmd = 'nano ~/.vnc/xstartup'
os.system(cmd)
cmd = 'sudo cd /etc/ssl ; openssl req -x509 -nodes -newkey rsa:2048 -keyout novnc.pem -out novnc.pem -days 365'
os.system(cmd)
cmd = 'websockify -D --web=/usr/share/novnc/ --cert=/etc/ssl/novnc.pem 80 localhost:5901'
os.system(cmd)
print("vnc up")
