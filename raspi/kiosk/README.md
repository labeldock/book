## STEP 1
```
sudo raspi-config
```
- 1 System option > S3 Change Password...
- 1 System option > S5 Auto login
- 1 System option > S1 Wireless lan
- 1 System option > 2 Network at boot  

## STEP 2
upgrade apt
```
sudo apt update -y && sudo apt upgrade -y
```

## STEP 3
purge (kiosk-purge-install)

## STEP 3
~/.config/lxsession/LXDE/autostart
```
@xset s off
@xset -dpms
@xset s noblank
@sed -i 's/"exited_cleanly": false/"exited_cleanly": true/' ~/.config/chromium-browser Default/Preferences
```
### last options
```
@chromium-browser --noerrdialogs --kiosk https://google.com --incognito --disable-translate
```
### chromium-browser options
```
--remote-debugging-port=9221
--window-position=0,0
--password-store=basi
```

- xset s 스크린세이버 (on, off)
- xset -dpms 절전모드 (-dpms, +dpms)
- xset s don’t blank the video device
sed -i
