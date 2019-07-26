# Build Notifier

Linux Installation

Fedora:
```sh
su -c "dnf -y install python3-wxpython4; curl -H 'Cache-Control: no-cache' -s https://raw.githubusercontent.com/dgthanhan/bashket/master/build-notify/notify.py > /usr/local/bin/build-notify.py; chmod uog+xr /usr/local/bin/build-notify.py"; mkdir -p "~/.config/autostart"; echo -e "[Desktop Entry]\nType=Application\nExec=/usr/local/bin/build-notify.py\nHidden=false\nNoDisplay=false\nX-GNOME-Autostart-enabled=true\nName=Build Notify\nComment=Start Build Notify on Startup" > ~/.config/autostart/build-notify.desktop; /usr/local/bin/build-notify.py 
```

Arch:
```sh
su -c "pacman -S python-wxpython; curl -H 'Cache-Control: no-cache' -s https://raw.githubusercontent.com/dgthanhan/bashket/master/build-notify/notify.py > /usr/local/bin/build-notify.py; chmod uog+xr /usr/local/bin/build-notify.py"; mkdir -p "~/.config/autostart"; echo -e "[Desktop Entry]\nType=Application\nExec=/usr/local/bin/build-notify.py\nHidden=false\nNoDisplay=false\nX-GNOME-Autostart-enabled=true\nName=Build Notify\nComment=Start Build Notify on Startup" > ~/.config/autostart/build-notify.desktop; /usr/local/bin/build-notify.py 
```