# Windows DNS Resolution Error Fix

## Error Summary
```
Failed host lookup: 'istoxscgzhbovvbzgdyd.supabase.co' 
(OS Error: No such host is known, errno = 11001)
```

This error means Windows **cannot resolve the domain name** to an IP address. It's a DNS (Domain Name System) issue, not a firewall issue.

---

## Quick Fixes (Try These First)

### 1. Flush DNS Cache
Open **Command Prompt** (as Administrator) and run:
```bash
ipconfig /flushdns
```

Then try the app again.

### 2. Change DNS Server
Windows is using a DNS server that can't reach Supabase. Try Google's DNS:

**Via Command Prompt (as Administrator):**
```bash
netsh interface ipv4 set dnsservers name="Ethernet" static 8.8.8.8 primary
netsh interface ipv4 set dnsservers name="Ethernet" static 8.8.4.4 secondary
```

Replace `"Ethernet"` with your connection name if different. Check connection name:
```bash
netsh interface show interface
```

**Or manually in Windows Settings:**
1. Settings → Network & Internet → WiFi/Ethernet
2. Click your connection → Properties
3. Edit DNS settings → Manual
4. Set to:
   - IPv4: `8.8.8.8` (Primary), `8.8.4.4` (Secondary)
   - IPv6: `2001:4860:4860::8888` (optional)
5. Save and restart the app

### 3. Disable IPv6 (Windows-Specific)
Sometimes IPv6 causes issues. Disable it:

```bash
netsh interface ipv6 set state disabled
```

Restart and test.

### 4. Check Network Connectivity
Verify you can reach Supabase from Windows:

```bash
ping istoxscgzhbovvbzgdyd.supabase.co
curl -I https://istoxscgzhbovvbzgdyd.supabase.co/rest/v1/
```

If both fail, DNS is definitely the issue.

---

## Advanced Fixes

### 5. Reset Network Stack
If DNS issues persist:

```bash
ipconfig /release
ipconfig /renew
```

### 6. Restart Network Service
```bash
net stop dnscache
net start dnscache
```

### 7. Check Hosts File
Verify there's no conflicting entry in `C:\Windows\System32\drivers\etc\hosts`:

Open as Administrator and look for `istoxscgzhbovvbzgdyd.supabase.co`. If found, delete the line.

### 8. Disable Proxy
If your network uses a proxy, it might block DNS:

1. Settings → Network & Internet → Proxy
2. Disable "Automatically detect settings"
3. Disable "Use a proxy server"

---

## Router-Level Issues

### 9. Restart Router
Unplug router for 30 seconds, power back on.

### 10. Check ISP Blocking
Some ISPs block external APIs. Call your ISP or use a VPN to test:

```bash
# Using NordVPN, ProtonVPN, or Mullvad
# Connect VPN, then test the app
```

---

## Verify Fix

After any change, test with this script:

**test_connection.bat:**
```batch
@echo off
echo Testing DNS resolution...
nslookup istoxscgzhbovvbzgdyd.supabase.co
echo.
echo Testing connectivity...
curl -I https://istoxscgzhbovvbzgdyd.supabase.co/rest/v1/
echo.
echo All tests complete!
pause
```

---

## In-App Diagnostics

Now the app shows:
1. **Loading status** - "Network Error: Cannot reach Supabase..."
2. **Diagnostic button** (🐛 icon in header) - Logs connection details
3. **Retry button** - Attempts to reconnect
4. **Fallback data** - Shows offline data while troubleshooting

---

## If All Else Fails

1. **Test on another PC** - Isolates if it's your machine or Supabase
2. **Test on mobile hotspot** - Rules out your home network/ISP
3. **Contact Supabase support** - Provide the error message and your project ID
4. **Contact your ISP** - They may be blocking API connections

---

## Web Version (CORS Issue)

If web version still shows nothing (not even error), check:

**Supabase Dashboard → Project Settings → API → CORS**

Allowed Origins should include:
```
https://your-domain.com
http://localhost:3000
```

Add your exact domain/port if missing.
