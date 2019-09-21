# Current setup

OS: Debian 10 + Xfce4  
Terminal: xfce4-terminal + tmux + z + fzf + rip grep + ranger (`apt install tmux ranger`)  
Text Editor: vim + ctags (`apt install vim-gtk ctags`)  
Window Manager: i3wm (`apt install i3 i3status i3lock`)  
Window Manager utils: xautolock, pasystray, rofi, dunst (`apt install xautolock pasystray rofi dunst`)  
File Manager: PCManFM (`apt install pcmanfm`)  
Screenshots: flameshot (`apt install flameshot`)  
Screen drawing: Gromit-MPX (`apt install gromit-mpx`)  
Screen Recording/Streaming: Open Broadcaster Software (OBS) (`apt install obs-studio`)  
Media: GIMP + VLC + Audacity (`apt install gimp vlc audacity`)  
Passwords: KeePassXC (`apt install keepassxc`)  
Torrents: Qbittorrent (`apt install qbittorrent`)  
VPN: ExpressVPN  
Nodejs: nvm  

# Disable Bell (beep)

See https://wiki.archlinux.org/index.php/PC_speaker#Disable_PC_Speaker

To disable all bell sounds:
```bash
echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf
echo "setterm -blength 0" > /etc/profile.d/disable-beep.sh
echo "xset -b" >> /etc/xprofile
echo "set bell-style none" >> ~/.inputrc
```

# Fonts

In Debian, font rendering is not that great by default. It can be
customized using `fontconfig` and `xrdb`.<br>

```bash
# check your current settings
xrdb -query
cp fonts/fonts.conf ~/.config/fontconfig/fonts.conf
cp fonts/Xresources-fonts ~/.Xresources
```
