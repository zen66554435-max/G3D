#!/bin/bash
# G3D - تثبيت سريع على Termux
# المطور: الجنرال

clear
echo ""
echo "   ██████╗  ██████╗ ██████╗ "
echo "  ██╔════╝ ██╔═══██╗╚════██╗"
echo "  ██║  ███╗██║   ██║ █████╔╝"
echo "  ██║   ██║██║   ██║ ╚═══██╗"
echo "  ╚██████╔╝╚██████╔╝██████╔╝"
echo "   ╚═════╝  ╚═════╝ ╚═════╝ "
echo ""
echo "  ╔═══════════════════════════╗"
echo "  ║  تثبيت سريع على Termux   ║"
echo "  ╚═══════════════════════════╝"
echo ""

# تحديث PATH
export PATH="$HOME/.local/bin:$PATH"

echo "[*] جاري تحديث الحزم..."
pkg update -y && pkg upgrade -y

echo "[*] جاري تثبيت المتطلبات..."
pkg install -y git curl jq dnsutils whois python3

echo "[*] جاري تحميل الأداة..."
cd $HOME
rm -rf G3D 2>/dev/null
git clone https://github.com/zen66554435-max/G3D.git

cd G3D
chmod +x g3d.sh install.sh

echo "[*] جاري التثبيت..."
bash install.sh
