#!/bin/bash
# ═══════════════════════════════════════════════════
#  G3D - سكريبت التثبيت
#  المطور: الجنرال
# ═══════════════════════════════════════════════════

R='\033[1;31m'
G='\033[1;32m'
Y='\033[1;33m'
C='\033[1;36m'
W='\033[1;37m'
P='\033[1;35m'
NC='\033[0m'

clear
echo ""
echo -e "${C}   ██████╗  ██████╗ ██████╗ ${NC}"
echo -e "${C}  ██╔════╝ ██╔═══██╗╚════██╗${NC}"
echo -e "${C}  ██║  ███╗██║   ██║ █████╔╝${NC}"
echo -e "${C}  ██║   ██║██║   ██║ ╚═══██╗${NC}"
echo -e "${C}  ╚██████╔╝╚██████╔╝██████╔╝${NC}"
echo -e "${C}   ╚═════╝  ╚═════╝ ╚═════╝ ${NC}"
echo -e "${P}  ╔═══════════════════════════╗${NC}"
echo -e "${P}  ║  ${Y}تثبيت أداة G3D${P}          ║${NC}"
echo -e "${P}  ║  ${G}المطور: الجنرال${P}        ║${NC}"
echo -e "${P}  ╚═══════════════════════════╝${NC}"
echo ""

echo -e "${C}[*] ${W}جاري التثبيت...${NC}"

# التحقق من المتطلبات
echo -e "${C}[*] ${W}التحقق من المتطلبات...${NC}"

install_pkg() {
    if command -v apt &> /dev/null; then
        apt update -y && apt install -y "$@"
    elif command -v pkg &> /dev/null; then
        pkg update -y && pkg install -y "$@"
    elif command -v pacman &> /dev/null; then
        pacman -Sy --noconfirm "$@"
    elif command -v dnf &> /dev/null; then
        dnf install -y "$@"
    elif command -v yum &> /dev/null; then
        yum install -y "$@"
    elif command -v zypper &> /dev/null; then
        zypper install -y "$@"
    else
        echo -e "${R}[!] ${Y}لم يتم العثور على مدير حزم!${NC}"
        exit 1
    fi
}

# التحقق من curl
if ! command -v curl &> /dev/null; then
    echo -e "${Y}[!] ${W}جاري تثبيت curl...${NC}"
    install_pkg curl
fi

# التحقق من jq
if ! command -v jq &> /dev/null; then
    echo -e "${Y}[!] ${W}جاري تثبيت jq...${NC}"
    install_pkg jq
fi

# التحقق من dig (dnsutils)
if ! command -v dig &> /dev/null; then
    echo -e "${Y}[!] ${W}جاري تثبيت dnsutils...${NC}"
    install_pkg dnsutils || install_pkg bind-utils || install_pkg bind-tools
fi

# التحقق من whois
if ! command -v whois &> /dev/null; then
    echo -e "${Y}[!] ${W}جاري تثبيت whois...${NC}"
    install_pkg whois
fi

# التحقق من python3
if ! command -v python3 &> /dev/null; then
    echo -e "${Y}[!] ${W}جاري تثبيت python3...${NC}"
    install_pkg python3
fi

# إنشاء المجلد
INSTALL_DIR="$HOME/.g3d"
mkdir -p "$INSTALL_DIR"

echo -e "${C}[*] ${W}جاري نسخ الملفات...${NC}"
cp g3d.sh "$INSTALL_DIR/"
cp config.sh "$INSTALL_DIR/" 2>/dev/null || true
chmod +x "$INSTALL_DIR/g3d.sh"

# إنشاء اختصار
echo -e "${C}[*] ${W}جاري إنشاء الاختصار...${NC}"

if [ -d "$HOME/.local/bin" ]; then
    BIN_DIR="$HOME/.local/bin"
elif [ -d "/usr/local/bin" ] && [ -w "/usr/local/bin" ]; then
    BIN_DIR="/usr/local/bin"
else
    BIN_DIR="$HOME/.local/bin"
    mkdir -p "$BIN_DIR"
fi

cat > "$BIN_DIR/g3d" << 'EOF'
#!/bin/bash
bash "$HOME/.g3d/g3d.sh" "$@"
EOF
chmod +x "$BIN_DIR/g3d"

# إضافة للـ PATH
if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.zshrc" 2>/dev/null
fi

echo ""
echo -e "${G}[✓] ${W}تم التثبيت بنجاح!${NC}"
echo ""
echo -e "${C}[*] ${W}طريقة الاستخدام:${NC}"
echo -e "${Y}  • ${W}اكتب: ${C}g3d${NC}"
echo -e "${Y}  • ${W}أو: ${C}bash $INSTALL_DIR/g3d.sh${NC}"
echo ""
echo -e "${C}[*] ${W}للإزالة:${NC}"
echo -e "${Y}  • ${W}rm -rf $INSTALL_DIR${NC}"
echo -e "${Y}  • ${W}rm $BIN_DIR/g3d${NC}"
echo ""
echo -e "${P}  ═══════════════════════════════════════${NC}"
echo -e "${P}  ${G}المطور: الجنرال${NC}"
echo -e "${P}  ${G}مفتوحة المصدر - MIT License${NC}"
echo -e "${P}  ═══════════════════════════════════════${NC}"
echo ""
