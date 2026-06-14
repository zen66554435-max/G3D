<div align="center">

<img src="https://raw.githubusercontent.com/zen66554435-max/G3D/refs/heads/main/logo.PNG" width="200" alt="G3D Logo">

<br>

<h1>G3D v3.0 Ultimate</h1>

<p><strong>Advanced OSINT Information Gathering Tool</strong></p>

<p>
  <img src="https://img.shields.io/badge/License-MIT-green.svg" alt="License">
  <img src="https://img.shields.io/badge/Platform-Linux%20%7C%20Termux%20%7C%20Windows-blue.svg" alt="Platform">
  <img src="https://img.shields.io/badge/Version-3.0.0-orange.svg" alt="Version">
  <img src="https://img.shields.io/badge/Python-3.13-blue.svg" alt="Python">
</p>

<p><strong>Developer: الجنرال (AL GENERAL)</strong></p>

</div>

---

## Features

| Module | Description |
|--------|-------------|
| Email Intelligence | Validation, MX, SPF, DMARC, Whois |
| Phone Intelligence | Country, Type, Format, Validation |
| Domain Intelligence | Whois, DNS, NS Records |
| IP Intelligence | ASN, Country, ISP, Geolocation |
| Breach Search | Advanced breach checking |
| Reports | JSON export with timestamps |

## Requirements

- Python 3.8+
- pip

## Libraries

```
rich>=13.0.0
requests>=2.28.0
phonenumbers>=8.13.0
email-validator>=2.0.0
dnspython>=2.3.0
python-whois>=0.8.0
ipwhois>=1.2.0
colorama>=0.4.6
typer>=0.9.0
orjson>=3.8.0
```

## Installation

### Quick Install

```bash
git clone https://github.com/zen66554435-max/G3D-v3.git
cd G3D-v3
bash install.sh
```

### On Termux

```bash
pkg update && pkg upgrade -y
pkg install python3 python-pip git -y
git clone https://github.com/zen66554435-max/G3D-v3.git
cd G3D-v3
bash install.sh
```

### Instant Install (One Line)

```bash
curl -sL https://raw.githubusercontent.com/zen66554435-max/G3D-v3/main/install.sh | bash
```

## Usage

```bash
g3d
```

Or directly:

```bash
python3 main.py
```

## Menu

```
[1] Email Intelligence
[2] Phone Intelligence
[3] Domain Intelligence
[4] IP Intelligence
[5] Breach Search
[6] Generate Report
[7] Settings
[8] About
[0] Exit
```

## UI Features

- Rich TUI with colors
- Progress bars with spinners
- Tables with borders
- Panels with info
- Arabic interface support

## Project Structure

```
G3D/
├── main.py              # Main entry point
├── requirements.txt     # Python dependencies
├── install.sh           # Install script
├── termux-install.sh    # Termux quick install
├── README.md            # Documentation
├── LICENSE              # MIT License
│
├── core/                # Core modules
│   ├── email_lookup.py
│   ├── phone_lookup.py
│   ├── domain_lookup.py
│   ├── ip_lookup.py
│   ├── report_manager.py
│   └── api_manager.py
│
├── assets/              # Assets
│   ├── banner.py
│   └── logo.png
│
├── reports/             # Generated reports
│
└── config/              # Configuration
    ├── settings.json
    └── api_keys.json
```

## API Support (Optional)

| Service | Function | Link |
|---------|----------|------|
| Have I Been Pwned | Email breaches | https://haveibeenpwned.com/ |
| LeakCheck | Breach search | https://leakcheck.io/ |
| NumVerify | Phone validation | https://numverify.com/ |
| IPInfo | IP geolocation | https://ipinfo.io/ |
| VirusTotal | Domain/IP scan | https://virustotal.com/ |

## Legal Warning

**This tool is for educational and security testing purposes only!**

- Use only on your own data or with explicit permission
- Any illegal use is your own responsibility
- Developer is not responsible for misuse

## License

MIT License - Copyright (c) 2026 الجنرال (AL GENERAL)

---

<div align="center">

⭐ **Don't forget to star the project!** ⭐

</div>
