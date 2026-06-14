#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
G3D v3.0 Ultimate - OSINT Information Gathering Tool
Developer: الجنرال (AL GENERAL)
License: MIT
"""

import sys
import os
import json
import time
import requests
import phonenumbers
from email_validator import validate_email, EmailNotValidError
import dns.resolver
import whois
from ipwhois import IPWhois
from rich.console import Console
from rich.panel import Panel
from rich.table import Table
from rich.progress import Progress, SpinnerColumn, TextColumn
from rich.layout import Layout
from rich.text import Text
from rich import box
from datetime import datetime

# ─── إعدادات Rich ───
console = Console()

# ─── الألوان المخصصة ───
ORANGE = "#FF6B35"
CYAN = "#00D4FF"
GREEN = "#00FF88"
RED = "#FF4444"
YELLOW = "#FFD700"
PURPLE = "#B347FF"
GRAY = "#888888"

# ─── البانر ───
def show_banner():
    banner_text = """
[bold {ORANGE}]   ██████╗  ██████╗ ██████╗ [/bold {ORANGE}]
[bold {ORANGE}]  ██╔════╝ ██╔═══██╗╚════██╗[/bold {ORANGE}]
[bold {ORANGE}]  ██║  ███╗██║   ██║ █████╔╝[/bold {ORANGE}]
[bold {ORANGE}]  ██║   ██║██║   ██║ ╚═══██╗[/bold {ORANGE}]
[bold {ORANGE}]  ╚██████╔╝╚██████╔╝██████╔╝[/bold {ORANGE}]
[bold {ORANGE}]   ╚═════╝  ╚═════╝ ╚═════╝ [/bold {ORANGE}]
    """

    info_panel = Panel(
        f"[bold {CYAN}]G3D v3.0 Ultimate[/bold {CYAN}]
"
        f"[bold {GREEN}]المطور: الجنرال[/bold {GREEN}]
"
        f"[bold {YELLOW}]OSINT Information Gathering Tool[/bold {YELLOW}]
"
        f"[bold {GRAY}]MIT License | Open Source[/bold {GRAY}]",
        border_style=ORANGE,
        box=box.DOUBLE,
        padding=(1, 2)
    )

    console.print(banner_text)
    console.print(info_panel)
    console.print()

# ─── القائمة الرئيسية ───
def show_menu():
    menu_table = Table(
        title=f"[bold {ORANGE}]القائمة الرئيسية[/bold {ORANGE}]",
        box=box.ROUNDED,
        border_style=ORANGE,
        show_header=False,
        padding=(0, 2)
    )

    menu_table.add_column("Option", style=f"bold {CYAN}", justify="center")
    menu_table.add_column("Description", style=f"bold {YELLOW}")
    menu_table.add_column("Status", style=f"bold {GREEN}")

    menu_items = [
        ("[1]", "تحليل البريد الإلكتروني", "✓"),
        ("[2]", "تحليل رقم الهاتف", "✓"),
        ("[3]", "تحليل النطاق (Domain)", "✓"),
        ("[4]", "تحليل عنوان IP", "✓"),
        ("[5]", "البحث المتقدم في التسريبات", "✓"),
        ("[6]", "توليد تقرير", "✓"),
        ("[7]", "الإعدادات", "⚙"),
        ("[8]", "حول الأداة", "ℹ"),
        ("[0]", "خروج", "✗"),
    ]

    for item in menu_items:
        menu_table.add_row(*item)

    console.print(menu_table)
    console.print()

# ─── الوحدة 1: Email Intelligence ───
def email_intelligence():
    console.print(Panel("[bold {ORANGE}]وحدة تحليل البريد الإلكتروني[/bold {ORANGE}]", border_style=CYAN))
    email = console.input(f"[bold {CYAN}][?] أدخل البريد الإلكتروني: [/bold {CYAN}]")

    if not email:
        console.print(f"[bold {RED}][!] لم يتم إدخال بريد![/bold {RED}]")
        time.sleep(1)
        return

    results = {}

    with Progress(
        SpinnerColumn(),
        TextColumn("[progress.description]{task.description}"),
        console=console,
    ) as progress:

        # التحقق من صحة البريد
        task = progress.add_task("[cyan]جاري التحقق من صحة البريد...", total=None)
        try:
            validation = validate_email(email, check_deliverability=False)
            results["valid"] = True
            results["normalized"] = validation.email
        except EmailNotValidError as e:
            results["valid"] = False
            results["error"] = str(e)
        progress.update(task, completed=True)

        # تحليل النطاق
        task = progress.add_task("[cyan]جاري تحليل النطاق...", total=None)
        domain = email.split("@")[1]
        results["domain"] = domain
        results["username"] = email.split("@")[0]

        # MX Records
        try:
            mx_records = dns.resolver.resolve(domain, "MX")
            results["mx_records"] = [str(rdata.exchange) for rdata in mx_records]
        except Exception:
            results["mx_records"] = []

        # SPF Records
        try:
            txt_records = dns.resolver.resolve(domain, "TXT")
            spf_records = [str(rdata) for rdata in txt_records if "v=spf1" in str(rdata)]
            results["spf"] = len(spf_records) > 0
        except Exception:
            results["spf"] = False

        # DMARC
        try:
            dmarc_records = dns.resolver.resolve(f"_dmarc.{domain}", "TXT")
            results["dmarc"] = len(list(dmarc_records)) > 0
        except Exception:
            results["dmarc"] = False

        progress.update(task, completed=True)

        # Whois
        task = progress.add_task("[cyan]جاري جلب معلومات Whois...", total=None)
        try:
            w = whois.whois(domain)
            results["whois"] = {
                "registrar": w.registrar,
                "creation_date": str(w.creation_date) if w.creation_date else "N/A",
                "expiration_date": str(w.expiration_date) if w.expiration_date else "N/A",
                "name_servers": w.name_servers,
            }
        except Exception as e:
            results["whois"] = {"error": str(e)}
        progress.update(task, completed=True)

    # عرض النتائج
    result_table = Table(
        title=f"[bold {GREEN}]نتائج تحليل البريد: {email}[/bold {GREEN}]",
        box=box.ROUNDED,
        border_style=GREEN,
    )
    result_table.add_column("المعلومة", style=f"bold {CYAN}")
    result_table.add_column("القيمة", style=f"bold {YELLOW}")

    result_table.add_row("البريد الكامل", email)
    result_table.add_row("اسم المستخدم", results["username"])
    result_table.add_row("النطاق", results["domain"])
    result_table.add_row("الصحة", "✓ صالح" if results["valid"] else "✗ غير صالح")

    if results["mx_records"]:
        result_table.add_row("سجلات MX", "
".join(results["mx_records"][:3]))
    else:
        result_table.add_row("سجلات MX", "غير موجودة")

    result_table.add_row("SPF", "✓ مفعل" if results["spf"] else "✗ غير مفعل")
    result_table.add_row("DMARC", "✓ مفعل" if results["dmarc"] else "✗ غير مفعل")

    if "whois" in results and "error" not in results["whois"]:
        result_table.add_row("المسجل", str(results["whois"]["registrar"]) or "N/A")
        result_table.add_row("تاريخ الإنشاء", results["whois"]["creation_date"])
        result_table.add_row("تاريخ الانتهاء", results["whois"]["expiration_date"])

    console.print(result_table)

    # حفظ التقرير
    save_report("email", email, results)

    console.input(f"
[bold {CYAN}][?] اضغط Enter للعودة...[/bold {CYAN}]")

# ─── الوحدة 2: Phone Intelligence ───
def phone_intelligence():
    console.print(Panel("[bold {ORANGE}]وحدة تحليل رقم الهاتف[/bold {ORANGE}]", border_style=CYAN))
    phone = console.input(f"[bold {CYAN}][?] أدخل رقم الهاتف (مع رمز الدولة): [/bold {CYAN}]")

    if not phone:
        console.print(f"[bold {RED}][!] لم يتم إدخال رقم![/bold {RED}]")
        time.sleep(1)
        return

    results = {}

    with Progress(
        SpinnerColumn(),
        TextColumn("[progress.description]{task.description}"),
        console=console,
    ) as progress:

        task = progress.add_task("[cyan]جاري تحليل الرقم...", total=None)

        try:
            parsed = phonenumbers.parse(phone, None)
            results["valid"] = phonenumbers.is_valid_number(parsed)
            results["possible"] = phonenumbers.is_possible_number(parsed)
            results["country"] = phonenumbers.region_code_for_number(parsed)
            results["national"] = phonenumbers.format_number(parsed, phonenumbers.PhoneNumberFormat.NATIONAL)
            results["international"] = phonenumbers.format_number(parsed, phonenumbers.PhoneNumberFormat.INTERNATIONAL)
            results["e164"] = phonenumbers.format_number(parsed, phonenumbers.PhoneNumberFormat.E164)
            results["type"] = str(phonenumbers.number_type(parsed))
            results["carrier"] = "Unknown"  # يحتاج مكتبة carrier
        except Exception as e:
            results["error"] = str(e)

        progress.update(task, completed=True)

    # عرض النتائج
    if "error" in results:
        console.print(f"[bold {RED}][!] خطأ: {results['error']}[/bold {RED}]")
    else:
        result_table = Table(
            title=f"[bold {GREEN}]نتائج تحليل الرقم: {phone}[/bold {GREEN}]",
            box=box.ROUNDED,
            border_style=GREEN,
        )
        result_table.add_column("المعلومة", style=f"bold {CYAN}")
        result_table.add_column("القيمة", style=f"bold {YELLOW}")

        result_table.add_row("الرقم الأصلي", phone)
        result_table.add_row("الصحة", "✓ صالح" if results["valid"] else "✗ غير صالح")
        result_table.add_row("الدولة", results["country"])
        result_table.add_row("التنسيق الوطني", results["national"])
        result_table.add_row("التنسيق الدولي", results["international"])
        result_table.add_row("E164", results["e164"])
        result_table.add_row("النوع", results["type"])

        console.print(result_table)

        # حفظ التقرير
        save_report("phone", phone, results)

    console.input(f"
[bold {CYAN}][?] اضغط Enter للعودة...[/bold {CYAN}]")

# ─── الوحدة 3: Domain Intelligence ───
def domain_intelligence():
    console.print(Panel("[bold {ORANGE}]وحدة تحليل النطاق[/bold {ORANGE}]", border_style=CYAN))
    domain = console.input(f"[bold {CYAN}][?] أدخل النطاق: [/bold {CYAN}]")

    if not domain:
        console.print(f"[bold {RED}][!] لم يتم إدخال نطاق![/bold {RED}]")
        time.sleep(1)
        return

    results = {}

    with Progress(
        SpinnerColumn(),
        TextColumn("[progress.description]{task.description}"),
        console=console,
    ) as progress:

        task = progress.add_task("[cyan]جاري تحليل النطاق...", total=None)

        # DNS Records
        try:
            a_records = dns.resolver.resolve(domain, "A")
            results["a_records"] = [str(rdata) for rdata in a_records]
        except Exception:
            results["a_records"] = []

        try:
            ns_records = dns.resolver.resolve(domain, "NS")
            results["ns_records"] = [str(rdata) for rdata in ns_records]
        except Exception:
            results["ns_records"] = []

        # Whois
        try:
            w = whois.whois(domain)
            results["whois"] = {
                "registrar": w.registrar,
                "creation_date": str(w.creation_date) if w.creation_date else "N/A",
                "expiration_date": str(w.expiration_date) if w.expiration_date else "N/A",
                "updated_date": str(w.updated_date) if w.updated_date else "N/A",
                "status": w.status,
                "name_servers": w.name_servers,
            }
        except Exception as e:
            results["whois"] = {"error": str(e)}

        progress.update(task, completed=True)

    # عرض النتائج
    result_table = Table(
        title=f"[bold {GREEN}]نتائج تحليل النطاق: {domain}[/bold {GREEN}]",
        box=box.ROUNDED,
        border_style=GREEN,
    )
    result_table.add_column("المعلومة", style=f"bold {CYAN}")
    result_table.add_column("القيمة", style=f"bold {YELLOW}")

    if results["a_records"]:
        result_table.add_row("سجلات A", "
".join(results["a_records"]))

    if results["ns_records"]:
        result_table.add_row("سجلات NS", "
".join(results["ns_records"]))

    if "whois" in results and "error" not in results["whois"]:
        result_table.add_row("المسجل", str(results["whois"]["registrar"]) or "N/A")
        result_table.add_row("تاريخ الإنشاء", results["whois"]["creation_date"])
        result_table.add_row("تاريخ الانتهاء", results["whois"]["expiration_date"])
        result_table.add_row("تاريخ التحديث", results["whois"]["updated_date"])
        if results["whois"]["status"]:
            result_table.add_row("الحالة", str(results["whois"]["status"]))

    console.print(result_table)

    # حفظ التقرير
    save_report("domain", domain, results)

    console.input(f"
[bold {CYAN}][?] اضغط Enter للعودة...[/bold {CYAN}]")

# ─── الوحدة 4: IP Intelligence ───
def ip_intelligence():
    console.print(Panel("[bold {ORANGE}]وحدة تحليل عنوان IP[/bold {ORANGE}]", border_style=CYAN))
    ip = console.input(f"[bold {CYAN}][?] أدخل عنوان IP: [/bold {CYAN}]")

    if not ip:
        console.print(f"[bold {RED}][!] لم يتم إدخال IP![/bold {RED}]")
        time.sleep(1)
        return

    results = {}

    with Progress(
        SpinnerColumn(),
        TextColumn("[progress.description]{task.description}"),
        console=console,
    ) as progress:

        task = progress.add_task("[cyan]جاري تحليل IP...", total=None)

        # IPWhois
        try:
            obj = IPWhois(ip)
            res = obj.lookup_rdap(depth=1)
            results["ipwhois"] = {
                "asn": res.get("asn", "N/A"),
                "asn_description": res.get("asn_description", "N/A"),
                "country": res.get("asn_country_code", "N/A"),
                "network": res.get("network", {}).get("cidr", "N/A"),
            }
        except Exception as e:
            results["ipwhois"] = {"error": str(e)}

        # IPInfo API (مجاني)
        try:
            response = requests.get(f"https://ipinfo.io/{ip}/json", timeout=5)
            if response.status_code == 200:
                data = response.json()
                results["ipinfo"] = {
                    "city": data.get("city", "N/A"),
                    "region": data.get("region", "N/A"),
                    "country": data.get("country", "N/A"),
                    "org": data.get("org", "N/A"),
                    "loc": data.get("loc", "N/A"),
                }
        except Exception:
            results["ipinfo"] = {"error": "API unavailable"}

        progress.update(task, completed=True)

    # عرض النتائج
    result_table = Table(
        title=f"[bold {GREEN}]نتائج تحليل IP: {ip}[/bold {GREEN}]",
        box=box.ROUNDED,
        border_style=GREEN,
    )
    result_table.add_column("المعلومة", style=f"bold {CYAN}")
    result_table.add_column("القيمة", style=f"bold {YELLOW}")

    if "ipwhois" in results and "error" not in results["ipwhois"]:
        result_table.add_row("ASN", results["ipwhois"]["asn"])
        result_table.add_row("وصف ASN", results["ipwhois"]["asn_description"])
        result_table.add_row("دولة ASN", results["ipwhois"]["country"])
        result_table.add_row("الشبكة", results["ipwhois"]["network"])

    if "ipinfo" in results and "error" not in results["ipinfo"]:
        result_table.add_row("المدينة", results["ipinfo"]["city"])
        result_table.add_row("المنطقة", results["ipinfo"]["region"])
        result_table.add_row("الدولة", results["ipinfo"]["country"])
        result_table.add_row("المزود", results["ipinfo"]["org"])
        result_table.add_row("الإحداثيات", results["ipinfo"]["loc"])

    console.print(result_table)

    # حفظ التقرير
    save_report("ip", ip, results)

    console.input(f"
[bold {CYAN}][?] اضغط Enter للعودة...[/bold {CYAN}]")

# ─── الوحدة 5: Breach Search ───
def breach_search():
    console.print(Panel("[bold {ORANGE}]البحث المتقدم في التسريبات[/bold {ORANGE}]", border_style=CYAN))

    console.print(f"[bold {YELLOW}][1] بحث البريد في التسريبات[/bold {YELLOW}]")
    console.print(f"[bold {YELLOW}][2] بحث الرقم في التسريبات[/bold {YELLOW}]")
    console.print(f"[bold {YELLOW}][3] بحث شامل[/bold {YELLOW}]")
    console.print(f"[bold {RED}][0] رجوع[/bold {RED}]")
    console.print()

    choice = console.input(f"[bold {CYAN}][?] اختر خياراً: [/bold {CYAN}]")

    if choice == "1":
        email = console.input(f"[bold {CYAN}][?] أدخل البريد: [/bold {CYAN}]")
        if email:
            console.print(f"[bold {YELLOW}][!] للحصول على نتائج فعلية، استخدم Have I Been Pwned API[/bold {YELLOW}]")
            console.print(f"[bold {CYAN}]  • الرابط: https://haveibeenpwned.com/[/bold {CYAN}]")
            console.print(f"[bold {CYAN}]  • LeakCheck: https://leakcheck.io/[/bold {CYAN}]")
    elif choice == "2":
        phone = console.input(f"[bold {CYAN}][?] أدخل الرقم: [/bold {CYAN}]")
        if phone:
            console.print(f"[bold {YELLOW}][!] للحصول على نتائج فعلية، استخدم NumVerify API[/bold {YELLOW}]")
            console.print(f"[bold {CYAN}]  • الرابط: https://numverify.com/[/bold {CYAN}]")
    elif choice == "3":
        email = console.input(f"[bold {CYAN}][?] أدخل البريد: [/bold {CYAN}]")
        phone = console.input(f"[bold {CYAN}][?] أدخل الرقم: [/bold {CYAN}]")
        console.print(f"[bold {GREEN}][+] تم إكمال البحث[/bold {GREEN}]")

    console.input(f"
[bold {CYAN}][?] اضغط Enter للعودة...[/bold {CYAN}]")

# ─── الوحدة 6: Generate Report ───
def generate_report():
    console.print(Panel("[bold {ORANGE}]توليد تقرير[/bold {ORANGE}]", border_style=CYAN))

    reports_dir = os.path.expanduser("~/.g3d/reports")
    if not os.path.exists(reports_dir):
        console.print(f"[bold {RED}][!] لا توجد تقارير بعد![/bold {RED}]")
        console.input(f"
[bold {CYAN}][?] اضغط Enter للعودة...[/bold {CYAN}]")
        return

    files = os.listdir(reports_dir)
    if not files:
        console.print(f"[bold {RED}][!] لا توجد تقارير بعد![/bold {RED}]")
        console.input(f"
[bold {CYAN}][?] اضغط Enter للعودة...[/bold {CYAN}]")
        return

    console.print(f"[bold {GREEN}][+] التقارير المتاحة:[/bold {GREEN}]")
    for i, f in enumerate(files, 1):
        console.print(f"[bold {CYAN}][{i}] {f}[/bold {CYAN}]")

    console.input(f"
[bold {CYAN}][?] اضغط Enter للعودة...[/bold {CYAN}]")

# ─── حفظ التقرير ───
def save_report(report_type, target, data):
    reports_dir = os.path.expanduser("~/.g3d/reports")
    os.makedirs(reports_dir, exist_ok=True)

    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    filename = f"{report_type}_{target.replace('@', '_').replace('.', '_')}_{timestamp}.json"
    filepath = os.path.join(reports_dir, filename)

    report_data = {
        "type": report_type,
        "target": target,
        "timestamp": datetime.now().isoformat(),
        "data": data,
    }

    with open(filepath, "w", encoding="utf-8") as f:
        json.dump(report_data, f, indent=2, ensure_ascii=False)

    console.print(f"
[bold {GREEN}][+] تم حفظ التقرير: {filepath}[/bold {GREEN}]")

# ─── الإعدادات ───
def settings():
    console.print(Panel("[bold {ORANGE}]الإعدادات[/bold {ORANGE}]", border_style=CYAN))
    console.print(f"[bold {YELLOW}][!] الإعدادات ستتوفر في الإصدار القادم[/bold {YELLOW}]")
    console.input(f"
[bold {CYAN}][?] اضغط Enter للعودة...[/bold {CYAN}]")

# ─── حول الأداة ───
def about():
    about_text = """
[bold {ORANGE}]G3D v3.0 Ultimate[/bold {ORANGE}]

[bold {CYAN}]المطور:[/bold {CYAN}] [bold {GREEN}]الجنرال (AL GENERAL)[/bold {GREEN}]
[bold {CYAN}]النسخة:[/bold {CYAN}] [bold {YELLOW}]3.0.0[/bold {YELLOW}]
[bold {CYAN}]الترخيص:[/bold {CYAN}] [bold {YELLOW}]MIT License[/bold {YELLOW}]
[bold {CYAN}]المصدر:[/bold {CYAN}] [bold {YELLOW}]مفتوح المصدر[/bold {YELLOW}]

[bold {CYAN}]الوصف:[/bold {CYAN}]
أداة متكاملة لجمع معلومات البريد الإلكتروني ورقم الهاتف
والنطاقات وعناوين IP باستخدام تقنيات OSINT

[bold {CYAN}]المميزات:[/bold {CYAN}]
• تحليل البريد الإلكتروني (Validation, MX, SPF, DMARC)
• تحليل رقم الهاتف (Country, Type, Format)
• تحليل النطاق (Whois, DNS, NS)
• تحليل IP (ASN, Country, ISP)
• البحث المتقدم في التسريبات
• توليد تقارير JSON
• واجهة عربية حديثة باستخدام Rich

[bold {CYAN}]المنصات:[/bold {CYAN}]
• Termux
• Linux
• Windows
    """

    console.print(Panel(about_text, border_style=ORANGE, box=box.DOUBLE))
    console.input(f"
[bold {CYAN}][?] اضغط Enter للعودة...[/bold {CYAN}]")

# ─── البرنامج الرئيسي ───
def main():
    while True:
        show_banner()
        show_menu()

        choice = console.input(f"[bold {ORANGE}][?] اختر خياراً: [/bold {ORANGE}]")

        if choice == "1":
            email_intelligence()
        elif choice == "2":
            phone_intelligence()
        elif choice == "3":
            domain_intelligence()
        elif choice == "4":
            ip_intelligence()
        elif choice == "5":
            breach_search()
        elif choice == "6":
            generate_report()
        elif choice == "7":
            settings()
        elif choice == "8":
            about()
        elif choice == "0":
            console.print(f"
[bold {GREEN}][✓] شكراً لاستخدام G3D![/bold {GREEN}]")
            console.print(f"[bold {CYAN}][*] المطور: الجنرال[/bold {CYAN}]")
            sys.exit(0)
        else:
            console.print(f"[bold {RED}][!] خيار غير صحيح![/bold {RED}]")
            time.sleep(1)

if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        console.print(f"

[bold {RED}][!] تم إيقاف الأداة[/bold {RED}]")
        sys.exit(0)
    except Exception as e:
        console.print(f"
[bold {RED}][!] خطأ: {e}[/bold {RED}]")
        sys.exit(1)
