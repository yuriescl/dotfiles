# Disable Bell (beep)

See https://wiki.archlinux.org/index.php/PC_speaker#Disable_PC_Speaker

To disable all bell sounds:
```bash
echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf
echo "xset -b" >> /etc/xprofile
echo "set bell-style none" >> ~/.inputrc
```

# Fonts

In Debian, font rendering is not that great by default. It can be
customized using `fontconfig` and `xrdb`.<br>

```bash
xrdb -query  # check current config
mkdir -p ~/.config/fontconfig
cp fonts/fonts.conf ~/.config/fontconfig/fonts.conf
cp fonts/Xresources-fonts ~/.Xresources
```
