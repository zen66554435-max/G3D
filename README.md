<div align="center">

<img src="https://raw.githubusercontent.com/zen66554435-max/G3D/refs/heads/main/logo.PNG" width="200" alt="G3D Logo">

<br>

<h1>G3D - معلومات البريد والرقم</h1>

<p><strong>أداة مفتوحة المصدر لجمع معلومات البريد الإلكتروني ورقم الهاتف</strong></p>

<p>
  <img src="https://img.shields.io/badge/License-MIT-green.svg" alt="License: MIT">
  <img src="https://img.shields.io/badge/Platform-Linux%20%7C%20Termux-blue.svg" alt="Platform">
  <img src="https://img.shields.io/badge/Version-1.0.0-orange.svg" alt="Version">
</p>

<p><strong>المطور: الجنرال</strong></p>

</div>

---

<div align="center">

<h2>📋 المحتويات</h2>

<p>
  <a href="#-الوصف">الوصف</a> •
  <a href="#-المميزات">المميزات</a> •
  <a href="#-المتطلبات">المتطلبات</a> •
  <a href="#-التثبيت">التثبيت</a> •
  <a href="#-الاستخدام">الاستخدام</a> •
  <a href="#-الخيارات">الخيارات</a> •
  <a href="#-الترخيص">الترخيص</a>
</p>

</div>

---

<div align="center">

<h2>📝 الوصف</h2>

<p><strong>G3D</strong> هي أداة متكاملة ومفتوحة المصدر مصممة لجمع معلومات عن البريد الإلكتروني ورقم الهاتف باستخدام تقنيات <strong>OSINT</strong> (الاستخبارات المفتوحة المصدر). تدعم الأداة منصتي <strong>Linux</strong> و <strong>Termux</strong> وتتميز بواجهة عربية أنيقة مع بانر ثلاثي الأبعاد.</p>

</div>

---

<div align="center">

<h2>✨ المميزات</h2>

<table align="center">
  <tr><th>الميزة</th><th>الوصف</th></tr>
  <tr><td>📧 تحليل البريد</td><td>تحليل شامل للبريد الإلكتروني</td></tr>
  <tr><td>📱 تحليل الرقم</td><td>تحليل رقم الهاتف مع تحديد الدولة</td></tr>
  <tr><td>✅ التحقق من الصحة</td><td>التحقق من صحة البريد والرقم</td></tr>
  <tr><td>🔍 OSINT</td><td>جمع معلومات من مصادر مفتوحة</td></tr>
  <tr><td>📨 بريد مؤقت</td><td>توليد بريد إلكتروني مؤقت</td></tr>
  <tr><td>🔐 فحص التسريبات</td><td>فحص تسريبات البيانات</td></tr>
  <tr><td>🎨 واجهة عربية</td><td>واجهة مستخدم باللغة العربية</td></tr>
  <tr><td>💀 بانر 3D</td><td>بانر ASCII ثلاثي الأبعاد</td></tr>
</table>

</div>

---

<div align="center">

<h2>🔧 المتطلبات</h2>

<p>
  bash • curl • jq • dig (dnsutils) • whois • python3
</p>

</div>

---

<div align="center">

<h2>📥 التثبيت</h2>

<h3>الطريقة السريعة</h3>

<pre>
git clone https://github.com/zen66554435-max/G3D.git
cd G3D
bash install.sh
</pre>

<h3>التثبيت اليدوي</h3>

<pre>
git clone https://github.com/zen66554435-max/G3D.git
cd G3D
chmod +x g3d.sh
bash g3d.sh
</pre>

<h3>على Termux</h3>

<pre>
pkg update && pkg upgrade -y
pkg install git curl jq dnsutils whois python3 -y
git clone https://github.com/zen66554435-max/G3D.git
cd G3D
bash install.sh
</pre>

</div>

---

<div align="center">

<h2>🚀 الاستخدام</h2>

<p>بعد التثبيت، اكتب في الطرفية:</p>

<pre>
g3d
</pre>

<p>أو بدون تثبيت:</p>

<pre>
bash g3d.sh
</pre>

</div>

---

<div align="center">

<h2>📋 الخيارات</h2>

<pre>
╔═══════════════════════════════════════╗
║     G3D - معلومات البريد والرقم      ║
╚═══════════════════════════════════════╝

  [1]  تحليل البريد الإلكتروني
  [2]  تحليل رقم الهاتف
  [3]  التحقق من صحة البريد
  [4]  التحقق من صحة الرقم
  [5]  جمع معلومات البريد (OSINT)
  [6]  جمع معلومات الرقم (OSINT)
  [7]  توليد بريد مؤقت
  [8]  فحص تسريبات البيانات
  [9]  حول الأداة
  [10] البحث المتقدم في التسريبات
  [0]  خروج
</pre>

</div>

---

<div align="center">

<h2>🔑 APIs المدعومة</h2>

<table align="center">
  <tr><th>الخدمة</th><th>الوظيفة</th><th>السعر</th></tr>
  <tr><td>Have I Been Pwned</td><td>تسريبات البريد</td><td>مجاني (1req/1.5s)</td></tr>
  <tr><td>LeakCheck</td><td>تسريبات البريد</td><td>مجاني 100/يوم</td></tr>
  <tr><td>NumVerify</td><td>معلومات الرقم</td><td>مجاني 100/شهر</td></tr>
  <tr><td>IntelX</td><td>بحث شامل</td><td>مجاني + مدفوع</td></tr>
</table>

<h3>إعداد API Keys</h3>

<pre>
# 1. اختر خدمة من القائمة [10]
# 2. اختر "إعداد API Keys"
# 3. أدخل مفاتيحك

# أو يدوياً:
nano ~/.g3d/config.sh
</pre>

<h3>الحصول على API Keys</h3>

<table align="center">
  <tr><th>الخدمة</th><th>الرابط</th></tr>
  <tr><td>Have I Been Pwned</td><td>https://haveibeenpwned.com/API/Key</td></tr>
  <tr><td>LeakCheck</td><td>https://leakcheck.io/</td></tr>
  <tr><td>NumVerify</td><td>https://numverify.com/</td></tr>
  <tr><td>IntelX</td><td>https://intelx.io/</td></tr>
</table>

</div>

---

<div align="center">

<h2>⚡ مثال استخدام البحث المتقدم</h2>

<pre>
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
</pre>

</div>

---

<div align="center">

<h2>⚠️ تحذير قانوني</h2>

<p><strong>هذه الأداة مخصصة للأغراض التعليمية والأمنية فقط.</strong></p>

<p>
  استخدمها فقط على بياناتك الخاصة أو بإذن صريح<br>
  لا تستخدمها لأغراض غير قانونية<br>
  المطور غير مسؤول عن أي استخدام خاطئ
</p>

</div>

---

<div align="center">

<h2>📄 الترخيص</h2>

<p>هذا المشروع مرخص بموجب <strong>MIT License</strong></p>

<pre>
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

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
</pre>

</div>

---

<div align="center">

<h2>👤 المطور</h2>

<p><strong>الجنرال</strong></p>

<p>مفتوحة المصدر | للأغراض التعليمية</p>

<br>

<p>⭐ <strong>لا تنسَ دعم المشروع بنجمة!</strong> ⭐</p>

</div>
