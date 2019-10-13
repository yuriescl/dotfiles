# Current setup

**OS**: Manjaro 18.1 (Gnome 3)  
**Terminal**: gnome-terminal / VSCode (embed terminal) + tmux + [z](https://github.com/rupa/z) + [fzf](https://github.com/junegunn/fzf) + [ripgrep](https://github.com/BurntSushi/ripgrep) + ranger (`pacman -S tmux ranger ripgrep`)  
**Text Editor**: VSCode / neovim (`pacman -S code neovim`)  
**Screenshots**: flameshot (`pacman -S flameshot`)  
**Screen Recording/Streaming**: Open Broadcaster Software (OBS) (`pacman -S obs-studio`)  
**Media**: GIMP + VLC + Audacity (`pacman -S gimp vlc audacity`)  
**Passwords**: KeePassXC (`pacman -S keepassxc`)  
**Torrents**: Qbittorrent (`pacman -S qbittorrent`)  
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
