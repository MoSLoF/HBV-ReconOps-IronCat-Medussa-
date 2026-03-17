# HBV-ReconOps-IronCat-Medussa

Lightweight Active Directory environment management and mission analysis framework. Includes tools for VM/environment management, domain migration operations, group membership transfers, and system monitoring.

## Components

| Script | Purpose |
|--------|---------|
| `Main.py` | Mission framework initialization with SQLite-backed mission tracking |
| `Main_Logic.ps1` | Core AD migration logic with HTML reporting for asset tracking |
| `SpaceGhost.ps1` | Mode-based sensor monitoring and system diagnostics |
| `GroupMemTransfer.ps1` | Bulk security group membership migration between AD groups |

## Requirements

- PowerShell 5.1+ with Active Directory module
- Python 3.6+ (for Main.py)
- Domain-joined Windows system with appropriate AD permissions

## Disclaimer

For authorized use only. Ensure proper authorization before performing any Active Directory modifications.


---

## HoneyBadger Vanguard

**Part of the [HoneyBadger Vanguard (HBV)](https://ihbv.io) purple team ecosystem.**

Network recon and endpoint operations toolkit — nmap orchestration, system diagnostics, VM snapshot management.

```powershell
$global:Intent = 'Purple'  # Understand offense. Build better defense.
```

| | |
|---|---|
| **Org** | [MoSLoF on GitHub](https://github.com/MoSLoF) |
| **Platform** | HoneyBadger Vanguard 2.0 |
| **Demo Target** | CyberShield 2026 - Little Rock, AR |
| **License** | See LICENSE |

> The difference between a red team tool and a purple team tool is intent.
> -- $global:Intent = 'Purple'
