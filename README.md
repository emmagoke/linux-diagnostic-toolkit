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

### `disk-check.sh`
 
Checks disk usage for a given path against a threshold and reports whether it's within bounds.
 
**Usage:**
```bash
./disk-check.sh <threshold> [path]
```
 
- `threshold` — required, integer from 1–100
- `path` — optional, defaults to `/`

**Exit codes:**
| Code | Meaning |
|------|---------|
| `0`  | Disk usage is below the threshold |
| non-zero | Disk usage is at or above the threshold |
| `2`  | Invalid input (e.g. bad threshold value) |
 
**Example:**
```bash
./disk-check.sh 80 /home
```

### `network-check.sh`
 
Performs basic network diagnostics for a given host, with an optional port check.
 
**Usage:**
```bash
./network-check.sh <hostname-or-ip> [port]
```
 
- Validates the host argument
- Resolves the host and displays the resolved address
- Performs a basic connectivity check (e.g. ping)
- Displays network interface information
- If a port is supplied, checks TCP connectivity to it (valid range: 1–65535)
- Invalid input returns a non-zero exit code without crashing the script
**Example:**
```bash
./network-check.sh google.com 443
```
