#!/bin/bash
# ═══════════════════════════════════════════════════════════
#  G3D v3.0 Ultimate - Install Script
#  Developer: الجنرال (AL GENERAL)
# ═══════════════════════════════════════════════════════════

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
echo "  ║        G3D v3.0 Ultimate Installer                    ║"
echo "  ║        Developer: الجنرال                           ║"
echo "  ╚═══════════════════════════════════════════════════════╝"
echo ""

# ─── تحديث PATH ───
export PATH="$HOME/.local/bin:$PATH"

# ─── تحديث الحزم ───
echo "[*] Updating packages..."
if command -v pkg &> /dev/null; then
    pkg update -y && pkg upgrade -y
    echo "[*] Installing requirements..."
    pkg install -y python3 python-pip git curl
elif command -v apt &> /dev/null; then
    apt update -y && apt upgrade -y
    echo "[*] Installing requirements..."
    apt install -y python3 python3-pip git curl
else
    echo "[!] Package manager not found!"
    exit 1
fi

# ─── إنشاء المجلدات ───
INSTALL_DIR="$HOME/.g3d"
mkdir -p "$INSTALL_DIR"
mkdir -p "$INSTALL_DIR/reports"
mkdir -p "$INSTALL_DIR/config"

# ─── نسخ الملفات ───
echo "[*] Copying files..."
cp main.py "$INSTALL_DIR/"
cp -r core "$INSTALL_DIR/" 2>/dev/null || true
cp -r assets "$INSTALL_DIR/" 2>/dev/null || true

# ─── تثبيت المكتبات ───
echo "[*] Installing Python libraries..."
pip3 install --user -r requirements.txt

# ─── إنشاء الاختصار ───
echo "[*] Creating shortcut..."
BIN_DIR="$HOME/.local/bin"
mkdir -p "$BIN_DIR"

cat > "$BIN_DIR/g3d" << 'EOF'
#!/bin/bash
python3 "$HOME/.g3d/main.py" "$@"
EOF
chmod +x "$BIN_DIR/g3d"

# ─── تحديث PATH ───
echo "[*] Updating PATH..."

if [ -f "$HOME/.bashrc" ]; then
    if ! grep -q "\.local/bin" "$HOME/.bashrc"; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
    fi
fi

if [ -f "$HOME/.zshrc" ]; then
    if ! grep -q "\.local/bin" "$HOME/.zshrc"; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.zshrc"
    fi
fi

if [ -f "$HOME/.profile" ]; then
    if ! grep -q "\.local/bin" "$HOME/.profile"; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.profile"
    fi
fi

export PATH="$HOME/.local/bin:$PATH"

# ─── التحقق ───
echo "[*] Verifying installation..."
if command -v g3d &> /dev/null; then
    echo ""
    echo "  ╔═══════════════════════════════════════════════════════╗"
    echo "  ║           ✅ INSTALLATION COMPLETE!                   ║"
    echo "  ╚═══════════════════════════════════════════════════════╝"
    echo ""
    echo "  [*] Usage:"
    echo "      g3d"
    echo ""
    echo "  [*] Or:"
    echo "      python3 ~/.g3d/main.py"
    echo ""
    echo "  [*] Uninstall:"
    echo "      rm -rf ~/.g3d"
    echo "      rm ~/.local/bin/g3d"
    echo ""
    echo "  ═══════════════════════════════════════════════════════"
    echo "  Developer: الجنرال"
    echo "  Open Source - MIT License"
    echo "  ═══════════════════════════════════════════════════════"
    echo ""

    echo "[*] Launching G3D..."
    sleep 2
    g3d
else
    echo ""
    echo "  [!] Error occurred!"
    echo "  [*] Try running manually:"
    echo "      python3 ~/.g3d/main.py"
    echo ""
fi
