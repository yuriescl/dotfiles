# My config files

## Setup Vim

Get vim-plug

```bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```
Put .vimrc in your home dir

```bash
cp .vimrc ~/.vimrc
```

Open vim and enter these commands:

```
:PluginInstall nerdtree
:NERDTreeToogle
```

Done.
