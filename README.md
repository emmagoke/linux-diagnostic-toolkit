# Linux Diagnostic Toolkit

A Bash-based diagnostic toolkit for Linux systems. It collects system information, checks disk usage against a threshold, and performs basic network connectivity checks — all logged with timestamps for later review.

## Structure
 
```
assignment-1/
├── README.md
├── system-info.sh
├── disk-check.sh
├── network-check.sh
├── grade.sh
└── logs/
    └── .gitkeep
```

## Scripts
 
### `system-info.sh`
 
Displays live system information gathered at runtime:
 
- Hostname
- Current user
- Date / time
- Operating system
- Kernel version
- Uptime
- CPU information
- Memory information
- Current working directory
**Usage:**
```bash
./system-info.sh
```
