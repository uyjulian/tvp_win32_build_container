
# Setup display environment
Xvfb :2 & 1>&2
export DISPLAY=:2
while ! xdpyinfo; do sleep 1; jobs 1 || exit 1; done
openbox & 1>&2
echo "DISPLAY=:2" >> "$GITHUB_ENV"

# Setup Wine environment
mkdir -p "$RUNNER_TEMP/mypfx"
export WINEPREFIX=$RUNNER_TEMP/mypfx/wpfx
echo "WINEPREFIX=$WINEPREFIX" >> "$GITHUB_ENV"
export WINEDLLOVERRIDES=mscoree,mshtml=
echo "WINEDLLOVERRIDES=$WINEDLLOVERRIDES" >> "$GITHUB_ENV"

# Setup Wine
wineboot -e
wineserver -k
wineserver -p
ln -s $(pwd) $WINEPREFIX/dosdevices/h:
wineboot
wine reg add "HKCU\Software\Wine\WineDbg" /v ShowCrashDialog /t REG_DWORD /d 0 /f
