# Quick Troubleshooting Checklist

## What You'll See Now (After Code Improvements)

### ✅ New Features
1. **Red error banner** appears if connection fails
2. **Loading spinner** shows while connecting
3. **Retry button** to reconnect manually
4. **Bug icon** (🐛) in header to run diagnostics
5. **Console logs** showing connection details

---

## Windows: "No such host is known"

**This is a DNS issue, not firewall!**

### Try These (in order):

- [ ] **Restart computer** (clears DNS cache)
- [ ] **Flush DNS cache:**
  ```
  Command Prompt (Admin) → ipconfig /flushdns
  ```
- [ ] **Change DNS to Google:**
  - Settings → Network & Internet → WiFi/Ethernet
  - Click connection → Properties
  - Edit DNS → Manual
  - IPv4: `8.8.8.8` and `8.8.4.4`
  - Save → Restart app
  
- [ ] **Test in Command Prompt:**
  ```
  ping istoxscgzhbovvbzgdyd.supabase.co
  ```
  Should show IP address (not "request timed out")

- [ ] **Test on another network** (mobile hotspot)
  - If it works, your home network is the issue

---

## Web: Data Loads But Shows Nothing

**This is a CORS issue**

### Steps:

1. [ ] Open browser DevTools: **F12 or Ctrl+Shift+I**
2. [ ] Go to **Console** tab
3. [ ] Look for red errors mentioning "CORS"
4. [ ] Check error message for domain/origin issue

### If CORS Error:

In Supabase:
1. Dashboard → Project Settings → API
2. Find **CORS** section
3. Add your domain to **Allowed Origins:**
   ```
   https://yourdomain.com
   http://localhost:3000
   ```
4. Save
5. Refresh web app

### If No Error in Console:

1. [ ] Click **Network** tab in DevTools
2. [ ] Refresh page
3. [ ] Look for failed requests to `supabase.co`
4. [ ] Check response headers and error details
5. [ ] Take screenshot and debug further

---

## Both Platforms: Still Not Working?

### Check Supabase Database:

1. [ ] **Go to Supabase Studio** (your project dashboard)
2. [ ] Check **SQL Editor** → Run:
   ```sql
   SELECT COUNT(*) FROM booking;
   ```
   Should show number > 0

3. [ ] Check **Row Level Security:**
   - Table: booking
   - Policy for anon key should allow SELECT
   - If not, data won't load

4. [ ] Check **Table Schema:**
   - Column: `bookingid`, `datebooking`, `timebooking`, `duration`
   - Relationships: `pet`, `petowner`
   - Join table: `booking_service`
   
   If schema differs, queries fail silently.

---

## Debug Steps (All Platforms)

### Step 1: Click Debug Button
1. Find 🐛 icon in top-right header (when logged in)
2. Click it
3. Open browser console (F12 → Console)
4. Look for connection diagnostic logs

### Step 2: Check App Error Banner
1. Red error appears at top of app (if error)
2. Read the error message carefully
3. It tells you what's wrong:
   - "Cannot reach Supabase" → DNS/Network issue
   - "CORS configuration" → Web domain issue
   - "Timeout" → Server slow or unreachable

### Step 3: Check Browser Console (Web Only)
1. Press **F12** → **Console**
2. Look for messages starting with `[APP]`
3. These show initialization sequence
4. Red errors show connection failures

### Step 4: Manual Retry
1. Click **Retry** button on error banner
2. Watch console for retry attempts
3. Should retry 2-3 times with delays

---

## Network Diagnostics Commands

### Windows Command Prompt (Admin):

```batch
REM Check DNS resolution
nslookup istoxscgzhbovvbzgdyd.supabase.co

REM Test HTTP connection
curl -v https://istoxscgzhbovvbzgdyd.supabase.co/rest/v1/

REM Flush DNS
ipconfig /flushdns

REM View current DNS
ipconfig /all

REM Change to Google DNS
netsh interface ipv4 set dnsservers name="Ethernet" static 8.8.8.8 primary
```

Replace `"Ethernet"` with your network connection name from `ipconfig /all`

---

## If Everything Fails: Reset All

### Windows:
```
netsh interface ipv4 set dnsservers name="Ethernet" dhcp
ipconfig /release
ipconfig /renew
```

Then restart app.

### Web:
- Clear browser cache (Ctrl+Shift+Delete)
- Clear cookies for supabase.co
- Disable browser extensions (VPN, ad blocker, etc.)
- Try incognito mode

---

## Information to Provide Support

If you still need help, provide:

1. **Error message** from app (red banner)
2. **Console logs** (F12 → Console, copy red text)
3. **Your Supabase project URL**
4. **Verify DNS works:**
   ```
   nslookup istoxscgzhbovvbzgdyd.supabase.co
   ```
   (copy output)
5. **Platform:** Windows / Web / Both
6. **Network type:** Home WiFi / Corporate / Mobile hotspot
7. **ISP/Network provider** (if known)

---

## Common Solutions Summary

| Issue | Solution |
|-------|----------|
| "No such host" (Windows) | Flush DNS, change to Google DNS, restart |
| CORS error (Web) | Add domain to Supabase → API → CORS |
| Timeout error | Check internet speed, check server status |
| Shows offline data | Supabase unreachable, check network |
| Retry button grayed out | Still retrying, wait 2-4 seconds |
| No error, just empty | Check database has data, check RLS policies |

---

## When to Restart

- After changing DNS settings ⚠️ **REQUIRED**
- After updating firewall rules
- After changing network/WiFi
- After flushing DNS cache
- After updating the app

