# 🎯 G3D - معلومات البريد والرقم

<div align="center">

```
   ██████╗  ██████╗ ██████╗ 
  ██╔════╝ ██╔═══██╗╚════██╗
  ██║  ███╗██║   ██║ █████╔╝
  ██║   ██║██║   ██║ ╚═══██╗
  ╚██████╔╝╚██████╔╝██████╔╝
   ╚═════╝  ╚═════╝ ╚═════╝ 
```

**أداة مفتوحة المصدر لجمع معلومات البريد الإلكتروني ورقم الهاتف**

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-Linux%20%7C%20Termux-blue.svg)]()
[![Version](https://img.shields.io/badge/Version-1.0.0-orange.svg)]()

**المطور: الجنرال**

</div>

---

## 📋 المحتويات

- [الوصف](#-الوصف)
- [المميزات](#-المميزات)
- [المتطلبات](#-المتطلبات)
- [التثبيت](#-التثبيت)
- [الاستخدام](#-الاستخدام)
- [الخيارات](#-الخيارات)
- [الترخيص](#-الترخيص)

---

## 📝 الوصف

**G3D** هي أداة متكاملة ومفتوحة المصدر مصممة لجمع معلومات عن البريد الإلكتروني ورقم الهاتف باستخدام تقنيات **OSINT** (الاستخبارات المفتوحة المصدر). تدعم الأداة منصتي **Linux** و **Termux** وتتميز بواجهة عربية أنيقة مع بانر ثلاثي الأبعاد.

---

## ✨ المميزات

| الميزة | الوصف |
|--------|-------|
| 📧 **تحليل البريد** | تحليل شامل للبريد الإلكتروني |
| 📱 **تحليل الرقم** | تحليل رقم الهاتف مع تحديد الدولة |
| ✅ **التحقق من الصحة** | التحقق من صحة البريد والرقم |
| 🔍 **OSINT** | جمع معلومات من مصادر مفتوحة |
| 📨 **بريد مؤقت** | توليد بريد إلكتروني مؤقت |
| 🔐 **فحص التسريبات** | فحص تسريبات البيانات |
| 🎨 **واجهة عربية** | واجهة مستخدم باللغة العربية |
|
---

## 🔧 المتطلبات

- `bash`
- `curl`
- `jq`
- `dig` (dnsutils)
- `whois`
- `python3`

---

## 📥 التثبيت

### الطريقة السريعة

```bash
git clone https://github.com/yourusername/G3D-Info.git
cd G3D-Info
bash install.sh
```

### التثبيت اليدوي

```bash
# 1. استنساخ المستودع
git clone https://github.com/yourusername/G3D-Info.git
cd G3D-Info

# 2. جعل الملف قابل للتنفيذ
chmod +x g3d.sh

# 3. تشغيل الأداة
bash g3d.sh
```

### على Termux

```bash
pkg update && pkg upgrade -y
pkg install git curl jq dnsutils whois python3 -y
git clone https://github.com/yourusername/G3D-Info.git
cd G3D-Info
bash install.sh
```

---

## 🚀 الاستخدام

بعد التثبيت، اكتب في الطرفية:

```bash
g3d
```

أو بدون تثبيت:

```bash
bash g3d.sh
```

---

## 🔑 APIs المدعومة

| الخدمة | الوظيفة | السعر |
|--------|---------|-------|
| **Have I Been Pwned** | تسريبات البريد | مجاني (1req/1.5s) |
| **LeakCheck** | تسريبات البريد | مجاني 100/يوم |
| **NumVerify** | معلومات الرقم | مجاني 100/شهر |
| **IntelX** | بحث شامل | مجاني + مدفوع |

## 📋 الخيارات

```
╔═══════════════════════════════════════╗
║     G3D - معلومات البريد والرقم      ║
╚═══════════════════════════════════════╝

  [1] تحليل البريد الإلكتروني
  [2] تحليل رقم الهاتف
  [3] التحقق من صحة البريد
  [4] التحقق من صحة الرقم
  [5] جمع معلومات البريد (OSINT)
  [6] جمع معلومات الرقم (OSINT)
  [7] توليد بريد مؤقت
  [8] فحص تسريبات البيانات
  [9] حول الأداة
  [0] خروج
```

---

## 📸 لقطة شاشة

```
   ██████╗  ██████╗ ██████╗ 
  ██╔════╝ ██╔═══██╗╚════██╗
  ██║  ███╗██║   ██║ █████╔╝
  ██║   ██║██║   ██║ ╚═══██╗
  ╚██████╔╝╚██████╔╝██████╔╝
   ╚═════╝  ╚═════╝ ╚═════╝ 
  ╔═══════════════════════════╗
  ║  معلومات البريد والرقم   ║
  ║  المطور: الجنرال         ║
  ╚═══════════════════════════╝
```

---

## ⚠️ تحذير قانوني

**هذه الأداة مخصصة للأغراض التعليمية والأمنية فقط.**

- استخدمها فقط على بياناتك الخاصة أو بإذن صريح
- لا تستخدمها لأغراض غير قانونية
- المطور غير مسؤول عن أي استخدام خاطئ

---

## 📄 الترخيص

هذا المشروع مرخص بموجب **MIT License** - انظر ملف [LICENSE](LICENSE) للتفاصيل.

```
MIT License

Copyright (c) 2026 الجنرال

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
```

---

## 👤 المطور

<div align="center">

**الجنرال**

مفتوحة المصدر | للأغراض التعليمية

</div>

---

<div align="center">

⭐ **لا تنسَ دعم المشروع بنجمة!** ⭐

</div>


## 🔑 إعداد API Keys

```bash
# 1. اختر خدمة من القائمة [10]
# 2. اختر "إعداد API Keys"
# 3. أدخل مفاتيحك

# أو يدوياً:
nano ~/.g3d/config.sh
```

### الحصول على API Keys:

| الخدمة | الرابط |
|--------|--------|
| Have I Been Pwned | https://haveibeenpwned.com/API/Key |
| LeakCheck | https://leakcheck.io/ |
| NumVerify | https://numverify.com/ |
| IntelX | https://intelx.io/ |

---

## ⚡ مثال استخدام البحث المتقدم

```
[10] البحث المتقدم في التسريبات
  [1] بحث البريد في التسريبات

  أدخل البريد: example@email.com

  ═══ Have I Been Pwned ═══
  ⚠ عدد التسريبات: 3
    • LinkedIn (2012) - 164,611,595 ضحية
      بيانات مسربة: Email addresses, Passwords
    • Adobe (2013) - 152,445,165 ضحية
      بيانات مسربة: Email addresses, Passwords, Password hints
    • MySpace (2008) - 359,420,698 ضحية
      بيانات مسربة: Email addresses, Passwords, Usernames

  ═══ LeakCheck ═══
  ⚠ عدد التسريبات: 5
    • Collection #1
    • AntiPublic
    • Exploit.in
```
