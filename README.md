# My config files

*Note: do not just copy/paste commands without understanding them first, they can potentially override your current configs.*

## Bell (beep)

See https://wiki.archlinux.org/index.php/PC_speaker#Disable_PC_Speaker

To disable all bell sounds:
```bash
echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf
echo "setterm -blength 0" > /etc/profile.d/disable-beep.sh
echo "xset -b" >> /etc/xprofile
echo "set bell-style none" >> ~/.inputrc
```

## i3

####  i3 config
*There are hardcoded paths in i3 config.*
```bash
cp i3/i3.conf ~/.config/i3/config
```

####  i3 status
```bash
cp i3/i3-status.conf ~/.config/i3status/config
```

## Vim

###  Simple config
*With default keybindings.*
```bash
cp vim/vimrc ~/.vimrc
```

###  Full config
*Changes keybindings.*
Config based on https://github.com/phil303/dotfiles/blob/master/vimrc
```bash
cp vim/vimrc-full ~/.vimrc && cp -r vim/vim ~/.vim
```
List of vim shortcuts in `vim/vim-shortcuts`.

Screenshot using full config:

![vim screenshot](https://raw.githubusercontent.com/yuriescl/config-files/master/images/vim.jpg)

## Tmux

Config based on http://www.hamvocke.com/blog/a-guide-to-customizing-your-tmux-conf/

###  Simple config
*With default keybindings.*
```bash
cp tmux/tmux.conf ~/.tmux.conf
```

###  Full config
*Changes keybindings.*
```bash
cp tmux/tmux-full.conf ~/.tmux.conf
```

List of tmux shortcuts in `tmux/tmux-shortcuts`

Screenshot:

![tmux screenshot](https://raw.githubusercontent.com/yuriescl/config-files/master/images/tmux.jpg)

## Fonts

In Debian 9, font rendering is not that great by default. It can be customized using `fontconfig` and `xrdb`.<br>
*Also check the font configuration settings in your Desktop Environment.*

### fontconfig

```bash
cp fonts/fonts.conf ~/.config/fontconfig/fonts.conf
```

### xrdb

```bash
# check your current settings
xrdb -query

cp fonts/Xresources-fonts ~/.Xresources
```