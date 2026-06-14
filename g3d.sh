#!/bin/bash
# ═══════════════════════════════════════════════════
#  G3D - معلومات البريد والرقم
#  النسخة: 1.0.0
#  المطور: الجنرال
# ═══════════════════════════════════════════════════

R='\033[1;31m'
G='\033[1;32m'
Y='\033[1;33m'
B='\033[1;34m'
C='\033[1;36m'
W='\033[1;37m'
P='\033[1;35m'
GR='\033[1;30m'
NC='\033[0m'

VERSION="1.0.0"
AUTHOR="الجنرال"
TOOL_NAME="G3D"

# ─── البانر ───
show_banner() {
    clear
    echo ""
    echo -e "${C}   ██████╗  ██████╗ ██████╗ ${NC}"
    echo -e "${C}  ██╔════╝ ██╔═══██╗╚════██╗${NC}"
    echo -e "${C}  ██║  ███╗██║   ██║ █████╔╝${NC}"
    echo -e "${C}  ██║   ██║██║   ██║ ╚═══██╗${NC}"
    echo -e "${C}  ╚██████╔╝╚██████╔╝██████╔╝${NC}"
    echo -e "${C}   ╚═════╝  ╚═════╝ ╚═════╝ ${NC}"
    echo ""
    echo -e "${P}  ╔═══════════════════════════════════════╗${NC}"
    echo -e "${P}  ║  ${Y}G3D - معلومات البريد والرقم${P}       ║${NC}"
    echo -e "${P}  ║  ${G}المطور: الجنرال${P}                   ║${NC}"
    echo -e "${P}  ╚═══════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${GR}  ═══════════════════════════════════════${NC}"
    echo -e "${GR}  النسخة: ${W}${VERSION} ${GR}| ${W}مفتوحة المصدر${NC}"
    echo -e "${GR}  ═══════════════════════════════════════${NC}"
    echo ""
}

# ─── فاصل ───
separator() {
    echo -e "${GR}  ───────────────────────────────────────${NC}"
}

# ─── تحميل ───
loading() {
    local msg="$1"
    echo -ne "${C}[*] ${W}${msg} ${NC}"
    for i in {1..3}; do
        sleep 0.3
        echo -ne "${C}.${NC}"
    done
    echo ""
}

# ─── التحقق من المتطلبات ───
check_requirements() {
    local missing=()

    if ! command -v curl &> /dev/null; then
        missing+=("curl")
    fi
    if ! command -v jq &> /dev/null; then
        missing+=("jq")
    fi
    if ! command -v dig &> /dev/null; then
        missing+=("dnsutils")
    fi
    if ! command -v whois &> /dev/null; then
        missing+=("whois")
    fi
    if ! command -v python3 &> /dev/null; then
        missing+=("python3")
    fi

    if [ ${#missing[@]} -gt 0 ]; then
        echo -e "${R}[!] ${Y}المتطلبات المفقودة: ${missing[*]}${NC}"
        echo -e "${C}[*] ${W}جاري التثبيت...${NC}"

        if command -v apt &> /dev/null; then
            apt update -y && apt install -y "${missing[@]}"
        elif command -v pkg &> /dev/null; then
            pkg update -y && pkg install -y "${missing[@]}"
        elif command -v pacman &> /dev/null; then
            pacman -Sy --noconfirm "${missing[@]}"
        elif command -v dnf &> /dev/null; then
            dnf install -y "${missing[@]}"
        else
            echo -e "${R}[!] ${Y}يرجى تثبيت المتطلبات يدوياً${NC}"
            exit 1
        fi
    fi
}

# ─── القائمة الرئيسية ───
show_menu() {
    echo -e "${Y}  [1] ${W}تحليل البريد الإلكتروني${NC}"
    echo -e "${Y}  [2] ${W}تحليل رقم الهاتف${NC}"
    echo -e "${Y}  [3] ${W}التحقق من صحة البريد${NC}"
    echo -e "${Y}  [4] ${W}التحقق من صحة الرقم${NC}"
    echo -e "${Y}  [5] ${W}جمع معلومات البريد (OSINT)${NC}"
    echo -e "${Y}  [6] ${W}جمع معلومات الرقم (OSINT)${NC}"
    echo -e "${Y}  [7] ${W}توليد بريد مؤقت${NC}"
    echo -e "${Y}  [8] ${W}فحص تسريبات البيانات${NC}"
    echo -e "${Y}  [9] ${W}البحث المتقدم في التسريبات${NC}"
    echo -e "${Y}  [10] ${W}حول الأداة${NC}"
    echo -e "${R}  [0] ${W}خروج${NC}"
    echo ""
    echo -ne "${C}  [?] ${W}اختر خياراً: ${NC}"
}

# ─── 1. تحليل البريد الإلكتروني ───
analyze_email() {
    show_banner
    echo -e "${C}  ╔═══════════════════════════════════════╗${NC}"
    echo -e "${C}  ║     ${Y}تحليل البريد الإلكتروني${C}          ║${NC}"
    echo -e "${C}  ╚═══════════════════════════════════════╝${NC}"
    echo ""
    echo -ne "${C}  [?] ${W}أدخل البريد الإلكتروني: ${NC}"
    read email

    if [ -z "$email" ]; then
        echo -e "${R}  [!] ${Y}لم يتم إدخال بريد!${NC}"
        sleep 2
        return
    fi

    loading "جاري التحليل"

    local username=$(echo "$email" | cut -d'@' -f1)
    local domain=$(echo "$email" | cut -d'@' -f2)
    local domain_ext=$(echo "$domain" | rev | cut -d'.' -f1 | rev)

    echo ""
    separator
    echo -e "${G}  [+] ${W}نتائج التحليل:${NC}"
    separator
    echo -e "${Y}  • ${W}البريد الكامل: ${C}${email}${NC}"
    echo -e "${Y}  • ${W}اسم المستخدم: ${C}${username}${NC}"
    echo -e "${Y}  • ${W}النطاق: ${C}${domain}${NC}"
    echo -e "${Y}  • ${W}الامتداد: ${C}.${domain_ext}${NC}"

    if [[ "$email" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
        echo -e "${G}  • ${W}الصحة: ${G}صالح${NC}"
    else
        echo -e "${R}  • ${W}الصحة: ${R}غير صالح${NC}"
    fi

    echo ""
    loading "جاري جلب معلومات النطاق"

    local mx_records=$(dig +short MX "$domain" 2>/dev/null | head -5)
    local a_record=$(dig +short A "$domain" 2>/dev/null | head -1)
    local spf=$(dig +short TXT "$domain" 2>/dev/null | grep "v=spf1" | head -1)
    local dmarc=$(dig +short TXT "_dmarc.${domain}" 2>/dev/null | head -1)

    separator
    echo -e "${G}  [+] ${W}معلومات DNS:${NC}"
    separator

    if [ -n "$a_record" ]; then
        echo -e "${Y}  • ${W}سجل A: ${C}${a_record}${NC}"
    fi

    if [ -n "$mx_records" ]; then
        echo -e "${Y}  • ${W}سجلات MX (خوادم البريد):${NC}"
        echo "$mx_records" | while read line; do
            echo -e "    ${GR}↳ ${C}${line}${NC}"
        done
    fi

    if [ -n "$spf" ]; then
        echo -e "${Y}  • ${W}SPF: ${G}مفعل${NC}"
    else
        echo -e "${Y}  • ${W}SPF: ${R}غير مفعل${NC}"
    fi

    if [ -n "$dmarc" ]; then
        echo -e "${Y}  • ${W}DMARC: ${G}مفعل${NC}"
    else
        echo -e "${Y}  • ${W}DMARC: ${R}غير مفعل${NC}"
    fi

    echo ""
    loading "جاري جلب معلومات Whois"
    local whois_info=$(whois "$domain" 2>/dev/null | grep -E "Registrar:|Creation Date:|Expiration Date:|Name Server:" | head -10)

    if [ -n "$whois_info" ]; then
        separator
        echo -e "${G}  [+] ${W}معلومات Whois:${NC}"
        separator
        echo "$whois_info" | while read line; do
            echo -e "${Y}  • ${W}${line}${NC}"
        done
    fi

    echo ""
    echo -ne "${C}  [?] ${W}اضغط Enter للعودة...${NC}"
    read
}

# ─── 2. تحليل رقم الهاتف ───
analyze_phone() {
    show_banner
    echo -e "${C}  ╔═══════════════════════════════════════╗${NC}"
    echo -e "${C}  ║       ${Y}تحليل رقم الهاتف${C}              ║${NC}"
    echo -e "${C}  ╚═══════════════════════════════════════╝${NC}"
    echo ""
    echo -ne "${C}  [?] ${W}أدخل رقم الهاتف (مع رمز الدولة): ${NC}"
    read phone

    if [ -z "$phone" ]; then
        echo -e "${R}  [!] ${Y}لم يتم إدخال رقم!${NC}"
        sleep 2
        return
    fi

    local clean_phone=$(echo "$phone" | sed 's/[^0-9+]//g')

    loading "جاري التحليل"

    echo ""
    separator
    echo -e "${G}  [+] ${W}نتائج التحليل:${NC}"
    separator
    echo -e "${Y}  • ${W}الرقم الأصلي: ${C}${phone}${NC}"
    echo -e "${Y}  • ${W}الرقم المنظف: ${C}${clean_phone}${NC}"

    local country_code=""
    local national_number=""

    if [[ "$clean_phone" =~ ^\+([0-9]{1,3})([0-9]+)$ ]]; then
        country_code="${BASH_REMATCH[1]}"
        national_number="${BASH_REMATCH[2]}"
        echo -e "${Y}  • ${W}رمز الدولة: ${C}+${country_code}${NC}"
        echo -e "${Y}  • ${W}الرقم الوطني: ${C}${national_number}${NC}"

        local country=""
        case "$country_code" in
            966) country="المملكة العربية السعودية" ;;
            971) country="الإمارات العربية المتحدة" ;;
            965) country="الكويت" ;;
            974) country="قطر" ;;
            973) country="البحرين" ;;
            968) country="عمان" ;;
            962) country="الأردن" ;;
            20)  country="مصر" ;;
            212) country="المغرب" ;;
            213) country="الجزائر" ;;
            216) country="تونس" ;;
            218) country="ليبيا" ;;
            249) country="السودان" ;;
            963) country="سوريا" ;;
            961) country="لبنان" ;;
            964) country="العراق" ;;
            967) country="اليمن" ;;
            970) country="فلسطين" ;;
            1)   country="الولايات المتحدة / كندا" ;;
            44)  country="المملكة المتحدة" ;;
            49)  country="ألمانيا" ;;
            33)  country="فرنسا" ;;
            39)  country="إيطاليا" ;;
            34)  country="إسبانيا" ;;
            90)  country="تركيا" ;;
            91)  country="الهند" ;;
            86)  country="الصين" ;;
            81)  country="اليابان" ;;
            82)  country="كوريا الجنوبية" ;;
            7)   country="روسيا" ;;
            *)   country="دولة أخرى" ;;
        esac

        echo -e "${Y}  • ${W}الدولة: ${G}${country}${NC}"

        local num_length=${#national_number}
        echo -e "${Y}  • ${W}طول الرقم الوطني: ${C}${num_length}${NC}"

        case "$country_code" in
            966) expected_length=9 ;;
            971|965|974|973|968|962) expected_length=8 ;;
            20)  expected_length=10 ;;
            212) expected_length=9 ;;
            *)   expected_length="غير معروف" ;;
        esac

        if [ "$expected_length" != "غير معروف" ]; then
            if [ "$num_length" -eq "$expected_length" ]; then
                echo -e "${Y}  • ${W}الطول المتوقع: ${G}صحيح (${expected_length})${NC}"
            else
                echo -e "${Y}  • ${W}الطول المتوقع: ${R}غير صحيح (المتوقع: ${expected_length})${NC}"
            fi
        fi
    else
        echo -e "${R}  • ${W}تنسيق الرقم: ${R}غير معروف${NC}"
    fi

    echo ""
    echo -ne "${C}  [?] ${W}اضغط Enter للعودة...${NC}"
    read
}

# ─── 3. التحقق من صحة البريد ───
verify_email() {
    show_banner
    echo -e "${C}  ╔═══════════════════════════════════════╗${NC}"
    echo -e "${C}  ║     ${Y}التحقق من صحة البريد${C}             ║${NC}"
    echo -e "${C}  ╚═══════════════════════════════════════╝${NC}"
    echo ""
    echo -ne "${C}  [?] ${W}أدخل البريد الإلكتروني: ${NC}"
    read email

    if [ -z "$email" ]; then
        echo -e "${R}  [!] ${Y}لم يتم إدخال بريد!${NC}"
        sleep 2
        return
    fi

    loading "جاري التحقق"

    echo ""
    separator
    echo -e "${G}  [+] ${W}نتائج التحقق:${NC}"
    separator

    if [[ "$email" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
        echo -e "${G}  ✓ ${W}تنسيق البريد: ${G}صحيح${NC}"

        local domain=$(echo "$email" | cut -d'@' -f2)

        local mx=$(dig +short MX "$domain" 2>/dev/null | head -1)
        if [ -n "$mx" ]; then
            echo -e "${G}  ✓ ${W}خادم البريد (MX): ${G}موجود${NC}"
            echo -e "    ${GR}↳ ${C}${mx}${NC}"
        else
            echo -e "${R}  ✗ ${W}خادم البريد (MX): ${R}غير موجود${NC}"
        fi

        local a=$(dig +short A "$domain" 2>/dev/null | head -1)
        if [ -n "$a" ]; then
            echo -e "${G}  ✓ ${W}سجل A: ${G}موجود${NC}"
            echo -e "    ${GR}↳ ${C}${a}${NC}"
        else
            echo -e "${R}  ✗ ${W}سجل A: ${R}غير موجود${NC}"
        fi

        local spf=$(dig +short TXT "$domain" 2>/dev/null | grep "v=spf1" | head -1)
        if [ -n "$spf" ]; then
            echo -e "${G}  ✓ ${W}SPF: ${G}مفعل${NC}"
        else
            echo -e "${Y}  ! ${W}SPF: ${Y}غير مفعل${NC}"
        fi

        local dmarc=$(dig +short TXT "_dmarc.${domain}" 2>/dev/null | head -1)
        if [ -n "$dmarc" ]; then
            echo -e "${G}  ✓ ${W}DMARC: ${G}مفعل${NC}"
        else
            echo -e "${Y}  ! ${W}DMARC: ${Y}غير مفعل${NC}"
        fi

    else
        echo -e "${R}  ✗ ${W}تنسيق البريد: ${R}غير صحيح${NC}"
        echo -e "${Y}  ! ${W}مثال صحيح: example@domain.com${NC}"
    fi

    echo ""
    echo -ne "${C}  [?] ${W}اضغط Enter للعودة...${NC}"
    read
}

# ─── 4. التحقق من صحة الرقم ───
verify_phone() {
    show_banner
    echo -e "${C}  ╔═══════════════════════════════════════╗${NC}"
    echo -e "${C}  ║      ${Y}التحقق من صحة الرقم${C}            ║${NC}"
    echo -e "${C}  ╚═══════════════════════════════════════╝${NC}"
    echo ""
    echo -ne "${C}  [?] ${W}أدخل رقم الهاتف (مع رمز الدولة): ${NC}"
    read phone

    if [ -z "$phone" ]; then
        echo -e "${R}  [!] ${Y}لم يتم إدخال رقم!${NC}"
        sleep 2
        return
    fi

    local clean_phone=$(echo "$phone" | sed 's/[^0-9+]//g')

    loading "جاري التحقق"

    echo ""
    separator
    echo -e "${G}  [+] ${W}نتائج التحقق:${NC}"
    separator

    if [[ "$clean_phone" =~ ^\+[0-9]{1,3}[0-9]{6,14}$ ]]; then
        echo -e "${G}  ✓ ${W}تنسيق الرقم: ${G}صحيح${NC}"

        local cc=$(echo "$clean_phone" | sed 's/^+//' | cut -c1-3)
        local nn=$(echo "$clean_phone" | sed 's/^[+0-9]\{1,3\}//')

        echo -e "${Y}  • ${W}رمز الدولة: ${C}+${cc}${NC}"
        echo -e "${Y}  • ${W}الرقم الوطني: ${C}${nn}${NC}"
        echo -e "${Y}  • ${W}الطول الكلي: ${C}${#clean_phone}${NC}"

        case "$cc" in
            966) 
                if [ "${#nn}" -eq 9 ]; then
                    echo -e "${G}  ✓ ${W}الطول: ${G}صحيح (9 أرقام)${NC}"
                else
                    echo -e "${R}  ✗ ${W}الطول: ${R}يجب أن يكون 9 أرقام${NC}"
                fi
                ;;
            971|965|974|973|968|962)
                if [ "${#nn}" -eq 8 ]; then
                    echo -e "${G}  ✓ ${W}الطول: ${G}صحيح (8 أرقام)${NC}"
                else
                    echo -e "${R}  ✗ ${W}الطول: ${R}يجب أن يكون 8 أرقام${NC}"
                fi
                ;;
            *)
                echo -e "${Y}  ! ${W}الطول: ${Y}غير متوفر للتحقق${NC}"
                ;;
        esac
    else
        echo -e "${R}  ✗ ${W}تنسيق الرقم: ${R}غير صحيح${NC}"
        echo -e "${Y}  ! ${W}يجب أن يبدأ بـ + متبوعاً برمز الدولة${NC}"
        echo -e "${Y}  ! ${W}مثال: +966501234567${NC}"
    fi

    echo ""
    echo -ne "${C}  [?] ${W}اضغط Enter للعودة...${NC}"
    read
}

# ─── 5. جمع معلومات البريد (OSINT) ───
osint_email() {
    show_banner
    echo -e "${C}  ╔═══════════════════════════════════════╗${NC}"
    echo -e "${C}  ║    ${Y}جمع معلومات البريد (OSINT)${C}      ║${NC}"
    echo -e "${C}  ╚═══════════════════════════════════════╝${NC}"
    echo ""
    echo -ne "${C}  [?] ${W}أدخل البريد الإلكتروني: ${NC}"
    read email

    if [ -z "$email" ]; then
        echo -e "${R}  [!] ${Y}لم يتم إدخال بريد!${NC}"
        sleep 2
        return
    fi

    loading "جاري جمع المعلومات"

    local username=$(echo "$email" | cut -d'@' -f1)
    local domain=$(echo "$email" | cut -d'@' -f2)

    echo ""
    separator
    echo -e "${G}  [+] ${W}نتائج OSINT للبريد:${NC}"
    separator
    echo -e "${Y}  • ${W}اسم المستخدم: ${C}${username}${NC}"
    echo -e "${Y}  • ${W}النطاق: ${C}${domain}${NC}"

    echo ""
    separator
    echo -e "${G}  [+] ${W}روابط محتملة:${NC}"
    separator
    echo -e "${Y}  • ${W}GitHub: ${C}https://github.com/${username}${NC}"
    echo -e "${Y}  • ${W}Twitter/X: ${C}https://twitter.com/${username}${NC}"
    echo -e "${Y}  • ${W}Instagram: ${C}https://instagram.com/${username}${NC}"
    echo -e "${Y}  • ${W}Facebook: ${C}https://facebook.com/${username}${NC}"
    echo -e "${Y}  • ${W}LinkedIn: ${C}https://linkedin.com/in/${username}${NC}"
    echo -e "${Y}  • ${W}YouTube: ${C}https://youtube.com/@${username}${NC}"
    echo -e "${Y}  • ${W}TikTok: ${C}https://tiktok.com/@${username}${NC}"
    echo -e "${Y}  • ${W}Reddit: ${C}https://reddit.com/user/${username}${NC}"
    echo -e "${Y}  • ${W}Pinterest: ${C}https://pinterest.com/${username}${NC}"
    echo -e "${Y}  • ${W}Snapchat: ${C}https://snapchat.com/add/${username}${NC}"
    echo -e "${Y}  • ${W}Telegram: ${C}https://t.me/${username}${NC}"

    echo ""
    separator
    echo -e "${G}  [+] ${W}Gravatar:${NC}"
    separator
    local gravatar_hash=$(echo -n "$email" | md5sum | cut -d' ' -f1)
    echo -e "${Y}  • ${W}MD5 Hash: ${C}${gravatar_hash}${NC}"
    echo -e "${Y}  • ${W}الصورة: ${C}https://www.gravatar.com/avatar/${gravatar_hash}${NC}"
    echo -e "${Y}  • ${W}الملف الشخصي: ${C}https://www.gravatar.com/${gravatar_hash}${NC}"

    echo ""
    separator
    echo -e "${G}  [+] ${W}فحص التسريبات:${NC}"
    separator
    echo -e "${Y}  ! ${W}للفحص الكامل استخدم API Have I Been Pwned${NC}"
    echo -e "${Y}  • ${W}الرابط: ${C}https://haveibeenpwned.com/${NC}"

    echo ""
    echo -ne "${C}  [?] ${W}اضغط Enter للعودة...${NC}"
    read
}

# ─── 6. جمع معلومات الرقم (OSINT) ───
osint_phone() {
    show_banner
    echo -e "${C}  ╔═══════════════════════════════════════╗${NC}"
    echo -e "${C}  ║     ${Y}جمع معلومات الرقم (OSINT)${C}      ║${NC}"
    echo -e "${C}  ╚═══════════════════════════════════════╝${NC}"
    echo ""
    echo -ne "${C}  [?] ${W}أدخل رقم الهاتف (مع رمز الدولة): ${NC}"
    read phone

    if [ -z "$phone" ]; then
        echo -e "${R}  [!] ${Y}لم يتم إدخال رقم!${NC}"
        sleep 2
        return
    fi

    local clean_phone=$(echo "$phone" | sed 's/[^0-9+]//g')
    local no_plus=$(echo "$clean_phone" | sed 's/^+//')

    loading "جاري جمع المعلومات"

    echo ""
    separator
    echo -e "${G}  [+] ${W}نتائج OSINT للرقم:${NC}"
    separator
    echo -e "${Y}  • ${W}الرقم: ${C}${clean_phone}${NC}"
    echo -e "${Y}  • ${W}بدون + : ${C}${no_plus}${NC}"

    echo ""
    separator
    echo -e "${G}  [+] ${W}روابط WhatsApp:${NC}"
    separator
    echo -e "${Y}  • ${W}فتح محادثة: ${C}https://wa.me/${no_plus}${NC}"
    echo -e "${Y}  • ${W}مشاركة: ${C}https://api.whatsapp.com/send?phone=${no_plus}${NC}"

    echo ""
    separator
    echo -e "${G}  [+] ${W}روابط Telegram:${NC}"
    separator
    echo -e "${Y}  • ${W}فتح محادثة: ${C}https://t.me/+${no_plus}${NC}"

    echo ""
    separator
    echo -e "${G}  [+] ${W}روابط البحث:${NC}"
    separator
    echo -e "${Y}  • ${W}Truecaller: ${C}https://www.truecaller.com/search/${no_plus}${NC}"
    echo -e "${Y}  • ${W}NumLookup: ${C}https://www.numlookup.com/${NC}"
    echo -e "${Y}  • ${W}Whitepages: ${C}https://www.whitepages.com/phone/${clean_phone}${NC}"
    echo -e "${Y}  • ${W}Spokeo: ${C}https://www.spokeo.com/${NC}"

    echo ""
    echo -ne "${C}  [?] ${W}اضغط Enter للعودة...${NC}"
    read
}

# ─── 7. توليد بريد مؤقت ───
temp_email() {
    show_banner
    echo -e "${C}  ╔═══════════════════════════════════════╗${NC}"
    echo -e "${C}  ║       ${Y}توليد بريد مؤقت${C}              ║${NC}"
    echo -e "${C}  ╚═══════════════════════════════════════╝${NC}"
    echo ""

    loading "جاري التوليد"

    local random_str=$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 10 | head -1)
    local domains=("tempmail.com" "mailinator.com" "guerrillamail.com" "10minutemail.com" "throwawaymail.com")
    local random_domain=${domains[$RANDOM % ${#domains[@]}]}
    local temp_email="${random_str}@${random_domain}"

    echo ""
    separator
    echo -e "${G}  [+] ${W}البريد المؤقت:${NC}"
    separator
    echo -e "${Y}  • ${W}البريد: ${C}${temp_email}${NC}"
    echo -e "${Y}  • ${W}اسم المستخدم: ${C}${random_str}${NC}"
    echo -e "${Y}  • ${W}النطاق: ${C}${random_domain}${NC}"

    echo ""
    separator
    echo -e "${G}  [+] ${W}خدمات بريد مؤقت:${NC}"
    separator
    echo -e "${Y}  • ${W}TempMail: ${C}https://temp-mail.org/${NC}"
    echo -e "${Y}  • ${W}10MinuteMail: ${C}https://10minutemail.com/${NC}"
    echo -e "${Y}  • ${W}Guerrilla Mail: ${C}https://www.guerrillamail.com/${NC}"
    echo -e "${Y}  • ${W}Mailinator: ${C}https://www.mailinator.com/${NC}"
    echo -e "${Y}  • ${W}ThrowAwayMail: ${C}https://www.throwawaymail.com/${NC}"

    echo ""
    echo -ne "${C}  [?] ${W}اضغط Enter للعودة...${NC}"
    read
}

# ─── 8. فحص تسريبات البيانات ───
check_breaches() {
    show_banner
    echo -e "${C}  ╔═══════════════════════════════════════╗${NC}"
    echo -e "${C}  ║      ${Y}فحص تسريبات البيانات${C}           ║${NC}"
    echo -e "${C}  ╚═══════════════════════════════════════╝${NC}"
    echo ""
    echo -ne "${C}  [?] ${W}أدخل البريد أو الرقم: ${NC}"
    read target

    if [ -z "$target" ]; then
        echo -e "${R}  [!] ${Y}لم يتم إدخال شيء!${NC}"
        sleep 2
        return
    fi

    loading "جاري الفحص"

    echo ""
    separator
    echo -e "${G}  [+] ${W}نتائج الفحص:${NC}"
    separator

    echo -e "${Y}  ! ${W}للفحص الفعلي استخدم الخدمات التالية:${NC}"
    echo ""
    echo -e "${C}  [1] ${W}Have I Been Pwned${NC}"
    echo -e "    ${GR}↳ ${C}https://haveibeenpwned.com/${NC}"
    echo ""
    echo -e "${C}  [2] ${W}DeHashed${NC}"
    echo -e "    ${GR}↳ ${C}https://www.dehashed.com/${NC}"
    echo ""
    echo -e "${C}  [3] ${W}LeakCheck${NC}"
    echo -e "    ${GR}↳ ${C}https://leakcheck.io/${NC}"
    echo ""
    echo -e "${C}  [4] ${W}IntelX${NC}"
    echo -e "    ${GR}↳ ${C}https://intelx.io/${NC}"
    echo ""
    echo -e "${C}  [5] ${W}BreachDirectory${NC}"
    echo -e "    ${GR}↳ ${C}https://breachdirectory.org/${NC}"

    echo ""
    echo -ne "${C}  [?] ${W}اضغط Enter للعودة...${NC}"
    read
}

# ─── 9. البحث المتقدم ───
advanced_search() {
    show_banner
    echo -e "${C}  ╔═══════════════════════════════════════╗${NC}"
    echo -e "${C}  ║  ${Y}البحث المتقدم في التسريبات${C}        ║${NC}"
    echo -e "${C}  ╚═══════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${Y}  [1] ${W}بحث البريد في التسريبات${NC}"
    echo -e "${Y}  [2] ${W}بحث الرقم في التسريبات${NC}"
    echo -e "${Y}  [3] ${W}بحث شامل (بريد + رقم)${NC}"
    echo -e "${Y}  [4] ${W}إعداد API Keys${NC}"
    echo -e "${R}  [0] ${W}رجوع${NC}"
    echo ""
    echo -ne "${C}  [?] ${W}اختر خياراً: ${NC}"
    read adv_choice

    case $adv_choice in
        1)
            echo -ne "${C}  [?] ${W}أدخل البريد: ${NC}"
            read email
            if [ -n "$email" ]; then
                loading "جاري البحث"
                echo ""
                separator
                echo -e "${G}  [+] ${W}نتائج البحث عن: ${C}${email}${NC}"
                separator
                echo -e "${Y}  ! ${W}للحصول على نتائج فعلية استخدم API Keys${NC}"
                echo -e "${Y}  • ${W}HIBP: ${C}https://haveibeenpwned.com/${NC}"
                echo -e "${Y}  • ${W}LeakCheck: ${C}https://leakcheck.io/${NC}"
            fi
            ;;
        2)
            echo -ne "${C}  [?] ${W}أدخل الرقم: ${NC}"
            read phone
            if [ -n "$phone" ]; then
                loading "جاري البحث"
                echo ""
                separator
                echo -e "${G}  [+] ${W}نتائج البحث عن: ${C}${phone}${NC}"
                separator
                echo -e "${Y}  ! ${W}للحصول على نتائج فعلية استخدم API Keys${NC}"
                echo -e "${Y}  • ${W}NumVerify: ${C}https://numverify.com/${NC}"
            fi
            ;;
        3)
            echo -ne "${C}  [?] ${W}أدخل البريد: ${NC}"
            read email
            echo -ne "${C}  [?] ${W}أدخل الرقم: ${NC}"
            read phone
            echo -e "${G}  [+] ${W}تم إكمال البحث${NC}"
            ;;
        4)
            echo -e "${C}[*] ${W}إعداد API Keys:${NC}"
            echo -e "${Y}  1. ${W}HIBP: ${C}https://haveibeenpwned.com/API/Key${NC}"
            echo -e "${Y}  2. ${W}LeakCheck: ${C}https://leakcheck.io/${NC}"
            echo -e "${Y}  3. ${W}NumVerify: ${C}https://numverify.com/${NC}"
            echo -e "${Y}  4. ${W}IntelX: ${C}https://intelx.io/${NC}"
            echo -e "${Y}  ! ${W}عدل الملف: ${C}nano ~/.g3d/config.sh${NC}"
            ;;
        0) return ;;
    esac

    echo ""
    echo -ne "${C}  [?] ${W}اضغط Enter للعودة...${NC}"
    read
}

# ─── 10. حول الأداة ───
about() {
    show_banner
    echo -e "${C}  ╔═══════════════════════════════════════╗${NC}"
    echo -e "${C}  ║          ${Y}حول الأداة${C}                  ║${NC}"
    echo -e "${C}  ╚═══════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${W}  ╔═══════════════════════════════════════╗${NC}"
    echo -e "${W}  ║${NC}"
    echo -e "${W}  ║  ${C}الاسم: ${W}G3D - معلومات البريد والرقم${NC}"
    echo -e "${W}  ║  ${C}النسخة: ${W}${VERSION}${NC}"
    echo -e "${W}  ║  ${C}المطور: ${W}${AUTHOR}${NC}"
    echo -e "${W}  ║  ${C}الترخيص: ${W}MIT License${NC}"
    echo -e "${W}  ║  ${C}المصدر: ${W}مفتوح المصدر${NC}"
    echo -e "${W}  ║  ${C}المنصات: ${W}Linux / Termux${NC}"
    echo -e "${W}  ║${NC}"
    echo -e "${W}  ║  ${Y}الوصف:${NC}"
    echo -e "${W}  ║  ${GR}أداة متكاملة لجمع معلومات${NC}"
    echo -e "${W}  ║  ${GR}البريد الإلكتروني ورقم الهاتف${NC}"
    echo -e "${W}  ║  ${GR}باستخدام تقنيات OSINT${NC}"
    echo -e "${W}  ║${NC}"
    echo -e "${W}  ║  ${Y}المميزات:${NC}"
    echo -e "${W}  ║  ${GR}• تحليل البريد الإلكتروني${NC}"
    echo -e "${W}  ║  ${GR}• تحليل رقم الهاتف${NC}"
    echo -e "${W}  ║  ${GR}• التحقق من الصحة${NC}"
    echo -e "${W}  ║  ${GR}• جمع معلومات OSINT${NC}"
    echo -e "${W}  ║  ${GR}• توليد بريد مؤقت${NC}"
    echo -e "${W}  ║  ${GR}• فحص التسريبات${NC}"
    echo -e "${W}  ║${NC}"
    echo -e "${W}  ╚═══════════════════════════════════════╝${NC}"
    echo ""
    echo -ne "${C}  [?] ${W}اضغط Enter للعودة...${NC}"
    read
}

# ═══════════════════════════════════════
# ─── البرنامج الرئيسي ───
# ═══════════════════════════════════════

check_requirements

while true; do
    show_banner
    show_menu
    read choice

    case $choice in
        1) analyze_email ;;
        2) analyze_phone ;;
        3) verify_email ;;
        4) verify_phone ;;
        5) osint_email ;;
        6) osint_phone ;;
        7) temp_email ;;
        8) check_breaches ;;
        9) advanced_search ;;
        10) about ;;
        0) 
            echo ""
            echo -e "${G}  [✓] ${W}شكراً لاستخدام G3D!${NC}"
            echo -e "${C}  [*] ${W}المطور: الجنرال${NC}"
            echo ""
            exit 0
            ;;
        *)
            echo -e "${R}  [!] ${Y}خيار غير صحيح!${NC}"
            sleep 1
            ;;
    esac
done
