# Linux Command Line Utilities

## 1. mygrep.sh - Custom grep Implementation
A minimal grep clone with basic pattern matching functionality.

### Features
- Case-insensitive string search
- Line number display (`-n`)
- Inverted matching (`-v`)
- Combined flags support (`-nv`, `-vn`)
- Input validation

### Usage
```bash
./mygrep.sh [OPTIONS] PATTERN FILENAME
Examples
bash
./mygrep.sh hello file.txt          # Basic search
./mygrep.sh -n hello file.txt       # With line numbers
./mygrep.sh -vn hello file.txt      # Inverted match
Testing
Test file included with sample content:

Hello world
Test line
Another hello
No match here
2. DNS Troubleshooting Guide
Comprehensive steps to diagnose and resolve internal.example.com connectivity issues.

Troubleshooting Steps
DNS Verification

bash
dig internal.example.com
dig @8.8.8.8 internal.example.com
Service Reachability

bash
curl -Iv http://$(dig +short internal.example.com)
ss -tulnp | grep ':80\|:443'
Common Fixes
Issue	Verification	Solution
Wrong DNS	cat /etc/resolv.conf	nmcli con mod eth0 ipv4.dns "192.168.1.1"
Firewall	ufw status	ufw allow out 53/tcp
Bonus
bash
# Hosts file bypass
 $ echo "192.168.1.100 internal.example.com" | sudo tee -a /etc/hosts

# Persistent DNS
 $ sudo resolvectl dns eth0 192.168.1.1
Implementation Notes
mygrep.sh
Uses getopts for argument parsing

Handles combined flags intelligently

Validates input before processing

DNS Troubleshooting
Checks both DNS and service layers

Provides temporary and permanent solutions

Includes network diagnostics

Requirements
Bash shell (for mygrep.sh)

dig, curl, ss utilities (for DNS troubleshooting)

 $ sudo privileges for system changes