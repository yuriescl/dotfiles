" Note: default <leader> is usually \
let mapleader = "\\"

" #######################################
" #######################################
" Plugin management (using vim-plug)
call plug#begin()

" NERDTree
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
nmap <silent> <leader>n :NERDTreeToggle %:p:h<CR>
" Refresh directory listing (deleted and new files, etc)
nmap <Leader>r :NERDTreeFocus<cr>R<c-w><c-p> 
let g:NERDTreeWinSize   = 22
let g:NERDTreeWinPos = "right"
let g:NERDTreeChDirMode = 2
let g:NERDTreeIgnore = ['\.pyc$']
let g:NERDTreeShowHidden = 0

call plug#end()

" #######################################
" #######################################
" General settings
set nocompatible
set autoindent " indent automatically
set number  " show line numbers
set encoding=utf-8 "sets how vim shall represent characters internally. Utf-8 is necessary for most flavors of Unicode
set showmode          " Vim default on. Vi off. Displays mode in command line.
set undofile          " Vim automatically saves undo history to an undo file
set modifiable        " make a buffer modifiable
set undoreload=10000  " Save the whole buffer for undo when reloading it.
set nolist            " Show invisible symbols as characters.
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮,trail:·  
set showbreak=↪       " When breakline is present, show argument as character
set wildmenu          " Turns command-line completion on
set wildignore=*~,*.log,*.pyc	"Matching files ignored
set wildmode=list:longest,full          "act more like bash
set wrap              " Wraps text
set linebreak         " Wrap breaks at word boundaries
set virtualedit+=block  "Don't get.  Most people recommend though
set autoread          " Externally updated files are automatically read
set autowrite         " Autosave modified buffers when switching to another
set backspace=indent,eol,start    "Backspace over indents, line breaks, etc.
set completeopt=longest,menuone   "Completion options
set history=1000      " History of ':' commands.  Vim default is 20.
set ignorecase        " Ignores case of search terms
set smartcase         " Override 'ignorecase' if search contains uppercases.
set incsearch         " matches as you type
set laststatus=2      " 2 means all windows will have a status line
set magic             " Default on. Allows for special char. in search patterns
set matchtime=3       " Argument is the tenths of a second until matching parens
set ruler             " Show the cursor position (row,column)
set shiftwidth=2      " Number of spaces used for autoindent
set shiftround        " Round indent to multiple of 'shiftwidth'
set expandtab         " Tabs are expanded as spaces
set tabstop=2         " Number of spaces tab accounts for
set softtabstop=2     " Tabs count for 2 spaces when editing
set smarttab          " sw at the start of the line, sts everywhere else
set showmatch         " When a bracket is inserted, briefly jump to matching one
set splitright        " New buffers open on the right side of current buffer
set splitbelow        " New buffers open below current buffer
set noerrorbells      " Default off. Turn off audible bell
set visualbell        " Default off.  Turn on visual bell
set number            " Row numbers

set autochdir


syntax enable " enable syntax highlighting



" #######################################
" #######################################
" Keyboard improvements

" Create empty line without leaving normal mode

" Ctrl-j/k inserts blank line below/above
nmap <c-k> m`O<esc>``
nmap <c-j> m`o<esc>``
imap <c-j> <esc>m`o<esc>``a
imap <c-k> <esc>m`O<esc>``a

" Use ctrl+hjkl to move between window splits
noremap <C-h> <C-w>h
noremap <C-l> <C-w>l

nmap <C-n> :set invnumber<CR>

" Keep search matches in middle of window
nmap <silent> n nzzzv
nmap <silent> N Nzzzv

" Exit insert mode with jj
imap jj <Esc>

" Better exiting and saving
nmap <C-z> :w!<CR>
nmap <C-x> :w!<CR>:q<CR>
nmap <C-c> :q!<CR>
" Better exiting and saving when in insert mode
imap <C-z> <Esc>:w!<CR>a
imap <C-x> :w!<CR>:q<CR>
imap <C-c> :q!<CR>


" Delete line without copying text
nmap dd <S-v>"_d

" Delete line when in insert mode
imap dd <Esc>ddi

" Paste when insert mode
imap <C-o> <Esc>Pi
imap <C-p> <Esc>pi

" Copy line when in insert mode
imap yy <Esc>yyi

" #######################################
" #######################################
" Cursor Line
"

set cursorline
hi CursorLine cterm=NONE ctermbg=240 ctermfg=NONE
augroup BgHighlight
  autocmd!
  autocmd WinEnter * set cul
  autocmd WinLeave * set nocul
augroup END
    
" #######################################
" #######################################
" Vim Files
"
" http://stackoverflow.com/questions/4331776/change-vim-swap-backup-undo-file-name
" Save your temp vim files to a less annoying place than the current directory.
if isdirectory(expand('~/.vim_tmp/backup')) == 0
  :silent !mkdir -p ~/.vim_tmp/backup >/dev/null 2>&1
endif
set backupdir=~/.vim_tmp/backup/
set backup

if isdirectory(expand('/.vim_tmp/swap')) == 0
  :silent !mkdir -p ~/.vim_tmp/swap >/dev/null 2>&1
endif
set directory=~/.vim_tmp/swap//

if exists("+undofile")
  if isdirectory(expand('/.vim_tmp/undo')) == 0
    :silent !mkdir -p ~/.vim_tmp/undo > /dev/null 2>&1
  endif
  set undodir=~/.vim_tmp/undo//
  set undofile
endif

" #######################################
" #######################################
" Themes

colorscheme jellybeans
