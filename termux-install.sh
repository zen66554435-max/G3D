#!/bin/bash
# G3D v3.0 - Quick Termux Install
# Developer: الجنرال

clear
echo ""
echo "   ██████╗  ██████╗ ██████╗ "
echo "  ██╔════╝ ██╔═══██╗╚════██╗"
echo "  ██║  ███╗██║   ██║ █████╔╝"
echo "  ██║   ██║██║   ██║ ╚═══██╗"
echo "  ╚██████╔╝╚██████╔╝██████╔╝"
echo "   ╚═════╝  ╚═════╝ ╚═════╝ "
echo ""
echo "  ╔═══════════════════════════════════════════════════════╗"
echo "  ║        Quick Install on Termux                      ║"
echo "  ╚═══════════════════════════════════════════════════════╝"
echo ""

export PATH="$HOME/.local/bin:$PATH"

echo "[*] Updating packages..."
pkg update -y && pkg upgrade -y

echo "[*] Installing requirements..."
pkg install -y python3 python-pip git curl

echo "[*] Downloading G3D..."
cd $HOME
rm -rf G3D-v3 2>/dev/null
git clone https://github.com/zen66554435-max/G3D-v3.git

cd G3D-v3
chmod +x install.sh

echo "[*] Installing..."
bash install.sh
