# My config files

## 1) Vim

I prefer to not use Vim plugins because Vim is not my text editor for most programming tasks (for that I use Sublime Text with a few plugins).
I use Vim mainly for fast terminal file viewing or remote server programming (along with Tmux).


### 1.1) Simple config (does not change keybindings, use this if you share the same vim config with other people who are used to the defaults)

```bash
cp vim/vimrc ~/.vimrc
```

### 1.2) Full config, with a lot of customization and keybindings (careful with overriding your current config files)
(config based on https://github.com/phil303/dotfiles/blob/master/vimrc)

```bash
cp vim/vimrc-full ~/.vimrc && cp -r vim/vim ~/.vim
```
List of vim shortcuts in `vim/vim-shortcuts`.

Screenshot:

![vim screenshot](https://raw.githubusercontent.com/yuriescl/config-files/master/images/vim.jpg)

## 2) Tmux

(config based on http://www.hamvocke.com/blog/a-guide-to-customizing-your-tmux-conf/)

### 2.1) Simple config (does not change keybindings)

```bash
cp tmux/tmux.conf ~/.tmux.conf
```

### 2.2) Full config (changes a few default keybindings)

```bash
cp tmux/tmux-full.conf ~/.tmux.conf
```

List of tmux shortcuts in `tmux/tmux-shortcuts`

Screenshot:

![vim screenshot](https://raw.githubusercontent.com/yuriescl/config-files/master/images/tmux.jpg)
