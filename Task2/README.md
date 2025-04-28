# DNS Troubleshooting Guide: internal.example.com

## Issue Description
Users report "host not found" errors when accessing `internal.example.com`, though the service appears running.

## Troubleshooting Steps

### 1. Verify DNS Resolution
``` 
# Check system DNS
dig internal.example.com

# Test with Google DNS
dig @8.8.8.8 internal.example.com

# Compare resolv.conf
cat /etc/resolv.conf
2. Check Service Reachability
 
# Get IP address (if DNS works)
IP=$(dig +short internal.example.com)

# Test HTTP/HTTPS connectivity
curl -Iv http://$IP
curl -Ivk https://$IP

# Check listening ports
ss -tulnp | grep ':80\|:443'
3. Potential Causes
DNS Issues:
Incorrect resolv.conf configuration

DNS server unresponsive

Missing/incorrect DNS record

DNS cache poisoning

Network Issues:
Firewall blocking DNS (port 53) or HTTP(S)

Routing problems to DNS server

VLAN misconfiguration

Service Issues:
Web service not listening on expected ports

Host firewall blocking traffic

Load balancer misconfiguration

4. Solution Matrix
Issue	Verification Command	Fix Command
Wrong DNS server	cat /etc/resolv.conf	 $ sudo nmcli con mod eth0 ipv4.dns "192.168.1.1"
Firewall blocking DNS	 $ sudo ufw status	 $ sudo ufw allow out 53/tcp
Missing DNS record	dig internal.example.com	Add record to DNS server
Service not listening	ss -tulnp	 $ sudo systemctl restart apache2
Bonus Tasks
Local Hosts Bypass
 
echo "192.168.1.100 internal.example.com" |  $ sudo tee -a /etc/hosts
Persistent DNS Configuration
 
# Using NetworkManager
 $ sudo nmcli con mod eth0 ipv4.dns "192.168.1.1"
 $ sudo nmcli con mod eth0 ipv4.ignore-auto-dns yes
 $ sudo systemctl restart NetworkManager

# Using systemd-resolved
 $ sudo resolvectl dns eth0 192.168.1.1
 $ sudo resolvectl flush-caches