<div align="center">

# VICIdial Hyper-V Lab

<img src="https://readme-typing-svg.demolab.com?font=Inter&weight=700&size=28&duration=2800&pause=700&color=64748B&center=true&vCenter=true&width=900&lines=VICIdial+on+Windows+11+Hyper-V;PowerShell+Deploy+Scripts;ViciBox+12+Lab+Setup;Call-center+lab+in+a+box" alt="Typing SVG" />

<p>
  <img src="https://komarev.com/ghpvc/?username=mafzalkalwardev&label=Project%20Views&color=64748b&style=for-the-badge" alt="Project views" />
  <img src="https://img.shields.io/github/stars/mafzalkalwardev/vicidial-hyperv-lab?style=for-the-badge&color=22c55e" alt="GitHub stars" />
  <img src="https://img.shields.io/github/forks/mafzalkalwardev/vicidial-hyperv-lab?style=for-the-badge&color=f59e0b" alt="GitHub forks" />
  <img src="https://img.shields.io/github/license/mafzalkalwardev/vicidial-hyperv-lab?style=for-the-badge&color=64748b" alt="License" />
</p>

<p>
  <img src="https://skillicons.dev/icons?i=powershell,windows" alt="Skill icons" />
</p>

<p>
  <strong>PowerShell scripts to deploy VICIdial call center on Windows 11 using Hyper-V and ViciBox 12.</strong>
</p>

</div>

---

## Trophy Cards

<div align="center">
  <img src="https://github-profile-trophy.vercel.app/?username=mafzalkalwardev&theme=algolia&no-frame=true&no-bg=true&margin-w=12&margin-h=12&column=4" alt="GitHub trophy cards" />
</div>

---

## Stats Cards

<div align="center">
  <img height="165" src="https://github-readme-stats-sigma-five.vercel.app/api?username=mafzalkalwardev&show_icons=true&theme=tokyonight&hide_border=true&rank_icon=github" alt="GitHub stats" />
  <img height="165" src="https://github-readme-stats-sigma-five.vercel.app/api/top-langs/?username=mafzalkalwardev&layout=compact&theme=tokyonight&hide_border=true" alt="Top languages" />
</div>

---

## Activity Graph

<div align="center">
  <img src="https://github-readme-activity-graph.vercel.app/graph?username=mafzalkalwardev&theme=react-dark&hide_border=true&area=true" alt="GitHub activity graph" />
</div>

---

## Contribution Snake

<div align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/mafzalkalwardev/google-voice-dispatch-agent/output/github-contribution-grid-snake-dark.svg">
    <source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/mafzalkalwardev/google-voice-dispatch-agent/output/github-contribution-grid-snake.svg">
    <img alt="Contribution snake" src="https://raw.githubusercontent.com/mafzalkalwardev/google-voice-dispatch-agent/output/github-contribution-grid-snake.svg">
  </picture>
</div>

---

## SEO Keywords

`VICIdial` `Hyper-V` `ViciBox` `call center lab`

---

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
