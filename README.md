<div align="center">

<img src="https://raw.githubusercontent.com/zen66554435-max/G3D/refs/heads/main/logo.PNG" width="200" alt="G3D Logo">

<br>

<h1>G3D - Email & Phone Info Tool</h1>

<p><strong>Open Source Tool for Email and Phone Information Gathering</strong></p>

<p>
  <img src="https://img.shields.io/badge/License-MIT-green.svg" alt="License">
  <img src="https://img.shields.io/badge/Platform-Linux%20%7C%20Termux-blue.svg" alt="Platform">
  <img src="https://img.shields.io/badge/Version-1.0.0-orange.svg" alt="Version">
</p>

<p><strong>Developer: AL GENERAL</strong></p>

</div>

---

## Features

| Feature | Description |
|---------|-------------|
| Email Analysis | Full email analysis with DNS, MX, SPF, DMARC |
| Phone Analysis | Phone analysis with country detection |
| Verify Email | Email validation check |
| Verify Phone | Phone validation check |
| Email OSINT | Collect email information from open sources |
| Phone OSINT | Collect phone information from open sources |
| Temp Email | Generate temporary email |
| Breach Check | Check data breaches |
| Advanced Search | Advanced breach search with APIs |

## Requirements

- bash
- curl
- jq
- dig (dnsutils)
- whois
- python3

## Installation

### Quick Install

```bash
git clone https://github.com/zen66554435-max/G3D.git
cd G3D
bash install.sh
```

### On Termux

```bash
pkg update && pkg upgrade -y
pkg install git curl jq dnsutils whois python3 -y
git clone https://github.com/zen66554435-max/G3D.git
cd G3D
bash install.sh
```

### Instant Install (One Line)

```bash
curl -sL https://raw.githubusercontent.com/zen66554435-max/G3D/main/install.sh | bash
```

## Usage

```bash
g3d
```

Or without install:

```bash
bash g3d.sh
```

## Menu Options

```
[1]  Email Analysis
[2]  Phone Analysis
[3]  Verify Email
[4]  Verify Phone
[5]  Email OSINT
[6]  Phone OSINT
[7]  Temp Email
[8]  Breach Check
[9]  Advanced Search
[10] About
[0]  Exit
```

## Supported APIs

| Service | Function | Price |
|---------|----------|-------|
| Have I Been Pwned | Email breaches | Free (1req/1.5s) |
| LeakCheck | Email breaches | Free 100/day |
| NumVerify | Phone info | Free 100/month |
| IntelX | Full search | Free + Paid |

## Legal Warning

**This tool is for educational and security purposes only!**

- Use only on your own data or with explicit permission
- Do not use for illegal purposes
- Developer is not responsible for misuse

## License

MIT License - Copyright (c) 2026 AL GENERAL

---

<div align="center">

⭐ **Don't forget to star the project!** ⭐

</div>
