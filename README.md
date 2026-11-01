# browser-policies

### Mozilla Firefox:

On Linux, run the command:
```bash
sudo mkdir -p /etc/firefox/policies/
sudo curl https://raw.githubusercontent.com/ayu2805/browser-policies/main/firefox_policies.json \
-o /etc/firefox/policies/policies.json
sudo curl https://raw.githubusercontent.com/ayu2805/browser-policies/main/firefox_autoconfig.js \
-o /usr/lib/firefox/defaults/pref/autoconfig.js
sudo curl https://raw.githubusercontent.com/ayu2805/browser-policies/main/firefox_preferences.cfg \
-o /usr/lib/firefox/firefox.cfg
```

### Google Chrome:

On Linux, run the command:
```bash
sudo mkdir -p /etc/opt/chrome/policies/managed
sudo curl https://raw.githubusercontent.com/ayu2805/browser-policies/main/chrome_policies.json \
-o /etc/opt/chrome/policies/managed/policies.json
```

On Windows, run the command:
```powershell
irm https://raw.githubusercontent.com/ayu2805/browser-policies/main/chrome_policies.ps1 | iex
```
