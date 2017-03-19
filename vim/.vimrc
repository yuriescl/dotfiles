" Note: default <leader> is usually \
let mapleader = "\\"

" #######################################
" #######################################
" Plugin management (using vim-plug)
call plug#begin()

" NERDTree
Plug 'scrooloose/nerdtree'
map <silent> <leader>N :NERDTreeToggle %:p:h<CR>
" Set focus in NERDTree when it's being displayed in screen
map <silent> <Leader>n :NERDTreeFocus<cr>
" View the current buffer in NERDTree
map <silent> <leader>e :NERDTreeFind<cr>
let g:NERDTreeWinSize   = 22
let g:NERDTreeWinPos = "right"
let g:NERDTreeChDirMode = 2
let g:NERDTreeIgnore = ['\.pyc$']
let g:NERDTreeShowHidden = 0

" Vim Misc (required by vim-session)
Plug 'xolox/vim-misc'
" Vim Session (required because NERDTree is annoying for sessions)
Plug 'xolox/vim-session'
let g:session_autosave = 'no'

call plug#end()

" #######################################
" #######################################
" General settings
set nocompatible
set autoindent " indent automatically
set number  " show line numbers
set encoding=utf-8 "sets how vim shall represent characters internally. Utf-8 is necessary for most flavors of Unicode
set showmode          " Vim default on. Vi off. Displays mode in command line.
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

" Ctrl-j/k inserts blank line below/above
nmap <c-k> m`O<esc>``
nmap <c-j> m`o<esc>``
" Also in insert mode
imap <c-j> <esc>m`o<esc>``a
imap <c-k> <esc>m`O<esc>``a

" Use ctrl+hjkl to move between window splits
noremap <C-h> <C-w>h
noremap <C-l> <C-w>l

" Toggle line number display
nmap <C-n> :set invnumber<CR>

" Keep search matches in middle of window
nmap <silent> n nzzzv
nmap <silent> N Nzzzv

" Exit insert mode with jj
imap jj <Esc>

" Better exiting and saving
nmap <C-a> :qa!<CR>
nmap <C-z> :w!<CR>:q<CR>
nmap <C-x> :w!<CR>
nmap <C-c> :q!<CR>
" Better exiting and saving when in insert mode
imap <C-a> <Esc>:qa!<CR>
imap <C-z> <Esc>:w!<CR>:q<CR>
imap <C-x> <Esc>:w!<CR>a
imap <C-c> <Esc>:q!<CR>

" Delete line without copying text
nmap dd <S-v>"_d

"""""""""
" Buffers, windows and tabs
"
" Close (delete) current buffer without changing the window |lyout
nmap <silent> <F2> :bp<CR>:bd!#<CR>
" Create a new buffer in the current window
nmap <silent> <F3> :ene!<CR>
" Switch to last buffer visited
nmap <silent> <F4> :b#<CR>
" Switch to previous buffer
nmap <silent> <F5> :bprevious<CR>
" Switch to next buffer
nmap <silent> <F6> :bnext<CR>

" Create a new tab
nmap <silent> <C-t> :tabnew<CR>
" Move to previous tab
nmap <silent> <F7> :tabprevious<CR>
" Move to next tab
nmap <silent> <F8> :tabnext<CR>

" Decrease window size
nmap <silent> <C-F9> <C-w><<CR>
" Increase window size
nmap <silent> <C-F10> <C-w>><CR>



"""""""""
" Folding
"
inoremap <F10> <C-O>za
nnoremap <F10> za
onoremap <F10> <C-C>za
vnoremap <F10> zf

""""""""
" Open saved session
"

nmap <C-F11> :SaveSession! vim_session<CR>
nmap <C-F12> :OpenSession! vim_session<CR>


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

" if exists("+undofile")
"  if isdirectory(expand('/.vim_tmp/undo')) == 0
"    :silent !mkdir -p ~/.vim_tmp/undo > /dev/null 2>&1
"  endif
"  set undodir=~/.vim_tmp/undo//
"  set undofile
"endif

" #######################################
" #######################################
" Themes

colorscheme jellybeans


" #######################################
"
" #######################################
" Cursor Line
"

set cursorline
hi CursorLine cterm=NONE ctermbg=236 ctermfg=NONE


" #######################################
"
" #######################################
" Auto commands (THE ORDER OF THE COMMANDS MATTER, A LOT)

" Auto close NERDTree if it's the last remaining window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Start NERDTree
autocmd VimEnter * NERDTree

"  Go to previous (last accessed) window.
autocmd VimEnter * wincmd p" 
" Uncomment the following to have Vim jump to the last position when
" " reopening a file
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
