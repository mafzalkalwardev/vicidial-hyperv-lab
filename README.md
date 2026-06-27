<div align="center">

# VICIdial Hyper-V Lab

<img src="https://readme-typing-svg.demolab.com?font=Inter&weight=700&size=24&duration=2800&pause=700&color=0EA5E9&center=true&vCenter=true&width=900&lines=VICIdial+Call+Center+on+Windows+11;Hyper-V+%2B+ViciBox+12+Automation;PowerShell+Lab+Setup+Scripts" alt="Typing SVG" />

<p>
  <img src="https://img.shields.io/badge/PowerShell-5391FE?style=for-the-badge&logo=powershell&logoColor=white" alt="PowerShell" />
  <img src="https://img.shields.io/badge/Hyper--V-0078D4?style=for-the-badge&logo=windows&logoColor=white" alt="Hyper-V" />
  <img src="https://img.shields.io/badge/VICIdial-OpenSource-green?style=for-the-badge" alt="VICIdial" />
</p>

</div>

---

## Project Showcase

PowerShell automation to deploy **VICIdial** (open-source call center) on **Windows 11** via **Hyper-V** and **ViciBox 12** ISO. Includes ISO download script, VM creation, and VM control utilities — ideal for lab/testing dialer infrastructure on a Windows host.

**Repository:** [github.com/mafzalkalwardev/vicidial-hyperv-lab](https://github.com/mafzalkalwardev/vicidial-hyperv-lab)

Built by **Muhammad Afzal Kalwar**.

## Architecture

```mermaid
flowchart TB
  host[Windows11_Host] --> hyperv[Hyper-V_Manager]
  hyperv --> vm[VICIdial-Lab_VM]
  vm --> vicibox[ViciBox12_OpenSuSE]
  vicibox --> asterisk[Asterisk_MariaDB]
  asterisk --> webui[VICIdial_Web_UI]
```

## Key Scripts

| Script | Purpose |
|--------|---------|
| `01-download-vicibox.ps1` | Download ViciBox ISO |
| `02-create-hyperv-vm.ps1` | Create Hyper-V VM on D: drive |
| `03-vm-control.ps1` | Start/stop VM, get IP |

---

# VICIdial Setup on Windows 11 (Hyper-V)

VICIdial is a Linux call-center stack (OpenSuSE + Asterisk + MariaDB). It does **not** run natively on Windows. This folder contains scripts to install it in a **Hyper-V virtual machine** using the official **ViciBox 12** ISO.

## Quick start

### Step 1 — Download ViciBox ISO (no admin)

```powershell
cd D:\Vicidail
.\scripts\01-download-vicibox.ps1
```

### Step 2 — Create the Hyper-V VM (admin required)

```powershell
D:\Vicidail\scripts\02-create-hyperv-vm-admin.bat
```

### Step 3 — Install ViciBox inside the VM

1. Hyper-V Manager → start **VICIdial-Lab**
2. Boot menu → **Install ViciBox**
3. Login: `root` / `vicidial` (change on first login)
4. Run `vicibox-express` as root

### Step 4 — Access VICIdial

- Admin: `http://<VM-IP>/vicidial/admin.php`
- Agent: `http://<VM-IP>/agc/vicidial.php`

## VM Management

```powershell
.\scripts\03-vm-control.ps1 -Action start
.\scripts\03-vm-control.ps1 -Action stop
.\scripts\03-vm-control.ps1 -Action ip
```

## References

- [ViciBox 12 docs](https://docs.vicibox.com/en/latest/)
- [ViciBox ISO download](https://download.vicidial.com/vicibox/server/)

---

## About the Developer

**Muhammad Afzal Kalwar** — [@mafzalkalwardev](https://github.com/mafzalkalwardev) · [mafzalkalwardev.github.io](https://mafzalkalwardev.github.io)

<details>
<summary>SEO Keywords</summary>
Muhammad Afzal Kalwar, mafzalkalwardev, VICIdial Windows setup, Hyper-V call center lab, PowerShell automation Pakistan
</details>

---

<div align="center"><sub>Built by Muhammad Afzal Kalwar · FT Solutions</sub></div>
