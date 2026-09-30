#!/bin/bash

# 1. Install QEMU, Git, Python, and utilities
echo "Installing system dependencies..."
sudo apt update -y > /dev/null 2>&1
sudo apt install qemu-system-x86 curl wget unzip git python3 -y > /dev/null 2>&1

# 2. Clone noVNC repository
echo "Setting up noVNC..."
git clone https://github.com/novnc/noVNC.git /tmp/novnc
git clone https://github.com/novnc/websockify /tmp/novnc/utils/websockify > /dev/null 2>&1

# 3. Download Android-x86 ISO & create virtual drive
echo "Downloading Android-x86 (this may take a couple of minutes)..."
wget -c https://osdn.net/projects/android-x86/downloads/69703/android-x86_64-9.0-r2.iso -O android.iso > /dev/null 2>&1

echo "Creating virtual hard disk..."
qemu-img create -f qcow2 android_disk.img 8G > /dev/null 2>&1

# 4. Start Android via QEMU (VNC on port 5900)
echo "Starting Android inside QEMU..."
sudo qemu-system-x86_64 \
    -m 4096M \
    -smp cores=2 \
    -net nic,model=e1000 -net user \
    -cdrom android.iso \
    -hda android_disk.img \
    -vnc 127.0.0.1:0 \
    -device usb-mouse -device usb-tablet \
    > /dev/null 2>&1 &

# 5. Start noVNC web server on port 6080
echo "Starting noVNC web server..."
python3 /tmp/novnc/utils/novnc_proxy --vnc 127.0.0.1:5900 --listen 6080 &>/dev/null &

clear
echo "========================================================="
echo " Android-x86 & noVNC are running successfully!"
echo "========================================================="
echo " HOW TO OPEN:"
echo " 1. Click the **Web Preview** button (the small square icon"
echo "    with a diagonal arrow) at the top right of your Cloud Shell window."
echo " 2. Select **Change port** and type: 6080"
echo " 3. Click **Change and Preview** to open the desktop UI."
echo " 4. In the browser page, click **Connect** (leave password blank)."
echo "---------------------------------------------------------"
echo " Note: Software emulation is slow; please allow a few"
echo " minutes for Android to boot up on the screen."
echo "========================================================="

# Keep script running
sleep 43200
