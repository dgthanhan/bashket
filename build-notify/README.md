# Build Notifier

This small utility monitors and shows a small message describing active build processes at the top of the screen.

### Linux Installation
Requirement: JDK 7+
Please note that the Python version is deprecated. This installation guide is for the JAVA version.

```sh
mkdir -p ~/.local/bin
rm -f ~/.local/bin/build-notify.jar

curl  -H 'Cache-Control: no-cache' -s -L \
https://github.com/dgthanhan/bashket/raw/master/build-notify/build-notify.jar \
> ~/.local/bin/build-notify.jar

mkdir -p ~/.config/autostart

echo -e "[Desktop Entry]\n\
Type=Application\n\
Exec=java -jar $HOME/.local/bin/build-notify.jar \n\
Hidden=false\n\
NoDisplay=false\n\
X-GNOME-Autostart-enabled=true\n\
Name=Build Notify\n\
Comment=Start Build Notify on Startup" > ~/.config/autostart/build-notify.desktop

java -jar $HOME/.local/bin/build-notify.jar &
```

### Windows

Please use the [Windows installer](https://github.com/dgthanhan/bashket/raw/master/build-notify/installer/output/notifier-1.0.exe)

## Mac

Please mount the [Disk Image] (https://github.com/dgthanhan/bashket/raw/master/build-notify/installer/output/BuildNotify.dmg) and drag the application to your "Applications" folder.

### Other Platforms

The [JAVA version](https://github.com/dgthanhan/bashket/raw/master/build-notify/build-notify.jar) is cross-platform with some special handling for Mac to disable the animation. The JAVA application requires JRE 7+.

```sh
java -jar build-notify.jar
```
