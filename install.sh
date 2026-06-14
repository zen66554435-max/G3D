#!/bin/bash
# ═══════════════════════════════════════════════════
#  G3D - سكريبت التثبيت
#  المطور: الجنرال
# ═══════════════════════════════════════════════════

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
echo "  ║  تثبيت أداة G3D          ║"
echo "  ║  المطور: الجنرال         ║"
echo "  ╚═══════════════════════════╝"
echo ""

# ─── تحديث PATH فوراً ───
export PATH="$HOME/.local/bin:$PATH"

# ─── تثبيت المتطلبات ───
echo "[*] جاري تحديث الحزم..."
if command -v pkg &> /dev/null; then
    pkg update -y && pkg upgrade -y
    echo "[*] جاري تثبيت المتطلبات..."
    pkg install -y curl jq dnsutils whois python3
elif command -v apt &> /dev/null; then
    apt update -y && apt upgrade -y
    echo "[*] جاري تثبيت المتطلبات..."
    apt install -y curl jq dnsutils whois python3
else
    echo "[!] لم يتم العثور على مدير حزم!"
    exit 1
fi

# ─── إنشاء المجلدات ───
INSTALL_DIR="$HOME/.g3d"
mkdir -p "$INSTALL_DIR"

# ─── نسخ الملفات ───
echo "[*] جاري نسخ الملفات..."
cp g3d.sh "$INSTALL_DIR/"
chmod +x "$INSTALL_DIR/g3d.sh"

# ─── إنشاء الاختصار ───
echo "[*] جاري إنشاء الاختصار..."
BIN_DIR="$HOME/.local/bin"
mkdir -p "$BIN_DIR"

cat > "$BIN_DIR/g3d" << 'EOF'
#!/bin/bash
bash "$HOME/.g3d/g3d.sh" "$@"
EOF
chmod +x "$BIN_DIR/g3d"

# ─── تحديث PATH بشكل دائم ───
echo "[*] جاري تحديث PATH..."

# للـ bash
if [ -f "$HOME/.bashrc" ]; then
    if ! grep -q "\.local/bin" "$HOME/.bashrc"; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
    fi
fi

# للـ zsh
if [ -f "$HOME/.zshrc" ]; then
    if ! grep -q "\.local/bin" "$HOME/.zshrc"; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.zshrc"
    fi
fi

# للـ Termux (profile)
if [ -f "$HOME/.profile" ]; then
    if ! grep -q "\.local/bin" "$HOME/.profile"; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.profile"
    fi
fi

# تحديث PATH في الجلسة الحالية
export PATH="$HOME/.local/bin:$PATH"

# ─── التحقق من الاختصار ───
echo "[*] جاري التحقق..."
if command -v g3d &> /dev/null; then
    echo ""
    echo "  ╔═══════════════════════════╗"
    echo "  ║    ✅ تم التثبيت بنجاح!   ║"
    echo "  ╚═══════════════════════════╝"
    echo ""
    echo "  [*] طريقة الاستخدام:"
    echo "      اكتب: g3d"
    echo ""
    echo "  [*] أو:"
    echo "      bash ~/.g3d/g3d.sh"
    echo ""
    echo "  [*] للإزالة:"
    echo "      rm -rf ~/.g3d"
    echo "      rm ~/.local/bin/g3d"
    echo ""
    echo "  ═══════════════════════════════════════"
    echo "  المطور: الجنرال"
    echo "  مفتوحة المصدر - MIT License"
    echo "  ═══════════════════════════════════════"
    echo ""

    # تشغيل الأداة مباشرة
    echo "[*] جاري تشغيل الأداة..."
    sleep 2
    g3d
else
    echo ""
    echo "  [!] حدث خطأ!"
    echo "  [*] جرب تشغيلها يدوياً:"
    echo "      bash ~/.g3d/g3d.sh"
    echo ""
fi
