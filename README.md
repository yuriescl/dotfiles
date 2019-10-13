# Current setup

**OS**: Manjaro 18.1 (Gnome 3)  
**Terminal**: gnome-terminal / VSCode (embed terminal) + tmux + [z](https://github.com/rupa/z) + [fzf](https://github.com/junegunn/fzf) + [ripgrep](https://github.com/BurntSushi/ripgrep) + ranger (`apt install tmux ranger`)  
**Text Editor**: VSCode / neovim  
**Screenshots**: flameshot (`apt install flameshot`)  
**Screen drawing**: Gromit-MPX (`apt install gromit-mpx`)  
**Screen Recording/Streaming**: Open Broadcaster Software (OBS) (`apt install obs-studio`)  
**Media**: GIMP + VLC + Audacity (`apt install gimp vlc audacity`)  
**Passwords**: KeePassXC (`apt install keepassxc`)  
**Torrents**: Qbittorrent (`apt install qbittorrent`)  
**VPN**: ExpressVPN  
**Nodejs**: [nvm](https://github.com/nvm-sh/nvm)  

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
