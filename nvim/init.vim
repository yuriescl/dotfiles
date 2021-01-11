" Note: default <leader> is usually \
let mapleader = "\\"

set tabstop=4
set shiftwidth=4
set softtabstop=0
set laststatus=2
set keywordprg=rg
set backupdir=/tmp//
set directory=/tmp//
set undodir=/tmp//
set nocompatible
set colorcolumn=80
set mouse=
set expandtab
set hidden
set nonumber
set autoindent
set nosmartindent
set nocindent
set showmode
set showcmd
set hlsearch
set incsearch
set ruler
set cursorline
set nowrap
set lcs=extends:›,precedes:‹
set list
set ignorecase
set smartcase
set foldmethod=indent
set foldnestmax=2
set foldcolumn=0
set nofoldenable
set nomodeline
set vb t_vb=     " no visual bell & flash
set tags=./tags,tags  " look for the tags file in current directory, then globally
set updatetime=500
set wildmode=longest,list
set scrolloff=999
set clipboard=unnamed

call plug#begin(stdpath('data') . '/plugged')
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'danro/rename.vim'
  Plug 'vim-python/python-syntax'
  Plug 'yuriescl/vim-colorscheme'
  Plug 'qpkorr/vim-bufkill'
  Plug 'preservim/tagbar'
  Plug 'rbgrouleff/bclose.vim'
  Plug 'francoiscabrol/ranger.vim'
  Plug 'jremmen/vim-ripgrep'
  Plug 'drmingdrmer/vim-toggle-quickfix'
  Plug 'preservim/nerdtree'
  Plug 'mgedmin/taghelper.vim'
call plug#end()

runtime macros/matchit.vim

filetype plugin on
filetype plugin indent off
filetype indent off

syntax enable

colorscheme mixedmono

" Status line colors
hi StatusLine ctermbg=147 ctermfg=232
hi StatusLineNC ctermbg=18 ctermfg=15

function CwdName()
    return fnamemodify(getcwd(), ':t')
endfunction

set statusline=
set statusline+=%m%r%w\                                 "Modified? Readonly? 
set statusline+=%<%F                                    "File+path
let s:statusline = 0

let g:netrw_banner = 0

" (Plugin python-syntax) 
let g:python_highlight_all = 1

" (Plugin fzf) Disable jumping to existing windows
let g:fzf_buffers_jump = 0
let g:fzf_preview_window = []
let $FZF_DEFAULT_COMMAND='rg -F --files --no-ignore --hidden --glob "!.git/*" --glob "!*__pycache__*"'

" (Plugin tagbar)
let g:tagbar_width = 25
let g:tagbar_compact = 1
let g:tagbar_indent = 1
let g:tagbar_sort = 0
let g:tagbar_autoclose = 1
let g:tagbar_show_balloon = 0
let g:tagbar_show_visibility = 0
let g:tagbar_show_linenumbers = 0
let g:tagbar_silent = 1

" (Plugin ranger)
let g:ranger_map_keys = 0  " disable the default key mapping

let NERDTreeWinSize = 27
let NERDTreeQuitOnOpen=1

"""""""""""""""""""""""""""""""""""
"           Functions
"

" Toggle fold column
function ToggleFoldColumn()
    if (&foldcolumn != 0)
        set foldcolumn=0
    else
        set foldcolumn=1
    endif
endfunction
command! -bar ToggleFoldColumn call ToggleFoldColumn()


function ToggleSetList()
  if !exists('s:setlist') || s:setlist == 0
    set listchars=space:·,tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·,eol:$
    let s:setlist = 1
  else
    set listchars=extends:›,precedes:‹
    let s:setlist = 0
  endif
endfunction
command! -bar ToggleSetList call ToggleSetList()

function ToggleStatusLine()
  if !exists('s:statusline') || s:statusline == 0
    set statusline=
    set statusline+=%m%r%w\                                "Modified? Readonly? 
    set statusline+=%<%F\                                  "File+path
    set statusline+=%=%y\                                  "FileType
    set statusline+=%{''.(&fenc!=''?&fenc:&enc).''}        "Encoding
    set statusline+=%{(&bomb?\",BOM\":\"\")}\              "Encoding2
    set statusline+=%{&ff}\                                "FileFormat (dos/unix..) 
    set statusline+=r:%l/%L\                               "Rownumber/total (%)
    set statusline+=c:%c                                   "Colnr

    let s:statusline = 1
  else
    set statusline=
    set statusline+=%m%r%w\                                "Modified? Readonly? 
    set statusline+=%<%F                                   "File+path

    let s:statusline = 0
  endif
endfunction
command! -bar ToggleStatusLine call ToggleStatusLine()

" Toggles between manual and syntax folding
function ToggleFoldMethod()
  if (&foldmethod == 'manual')
    setlocal foldmethod=syntax
    echo 'foldmethod=syntax'
  else
    setlocal foldmethod=manual
    echo 'foldmethod=manual'
  endif
endfunction
command! -bar ToggleFoldMethod call ToggleFoldMethod()

" Echo File/dir paths
function EchoRelativeFilePath()
    echo @%
endfunction
command! -bar EchoRelativeFilePath call EchoRelativeFilePath()
function EchoFileName()
    echo expand('%:t')
endfunction
command! -bar EchoFileName call EchoFileName()
function EchoFullFilePath()
    echo expand("%:p")
endfunction
command! -bar EchoFullFilePath call EchoFullFilePath()
function EchoDirName()
    echo expand('%:p:h:t')
endfunction
command! -bar EchoDirName call EchoDirName()
function EchoFullDirPath()
    echo expand('%:p:h')
endfunction
command! -bar EchoFullDirPath call EchoFullDirPath()

function FzfFiles()
    let isgitrepo = system('git rev-parse --is-inside-work-tree 2>/dev/null 1>/dev/null && echo -n "true" || echo -n "false"')
    if isgitrepo == 'true'
        :GFiles
    else
        :Files
    endif
endfunction
command! -bar FzfFiles call FzfFiles()

function! OpenNERDTree()                   
    if @% == ""
        NERDTreeFocus
    else                                    
        NERDTreeFind
    endif                                   
endfun

function YankToClipboard()
    call system('xclip -i -selection clipboard', trim(getreg('*')))
endfunction

"""""""""""""""""""""""""""""""""""
"           Auto commands
"

" Uncomment the following to have Vim jump to the last position when                                                       
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

augroup Html
    autocmd FileType html,htmldjango setlocal tabstop=2 shiftwidth=2
augroup END

augroup ChangeDetect
    " Triger `autoread` when files changes on disk
    " https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
    " https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
    autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
      \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif

    " Notification after file change
    " https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
    autocmd FileChangedShellPost *
      \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

augroup END


augroup QuickFix
    " close quickfix window when an item is selected
    autocmd FileType qf nnoremap <buffer> <silent> <CR> <CR>:cclose<CR>
augroup END

"augroup Clipboard
"    autocmd TextYankPost * :call YankToClipboard()
"augroup END

"""""""""""""""""""""""""""""""""""
"           Mappings
"

nmap <silent> <leader>p :set paste<CR>"+p:set paste!<CR>
nmap <silent> <leader>P :set paste<CR>"+P:set paste!<CR>
nmap <silent> <leader>yy m`0v^$"+y``
vmap <silent> <leader>y "+y
nmap <silent> Y :call YankToClipboard()<CR>

nmap <silent> <F1> :noh<CR>
nmap <silent> <C-e> :TagbarToggle<CR>
nmap <C-b> :Buffers<CR>
nmap <C-f> :Rg 
nmap <C-g> :History<CR>
nmap <C-n> :Files<CR>
nmap <silent> <C-p> :w<CR>
nmap <silent> <C-x> :BD<CR>

" See https://vim.fandom.com/wiki/Move_cursor_by_display_lines_when_wrapping
nmap <silent> j gj
vmap <silent> j gj
nmap <silent> k gk
vmap <silent> k gk

" See https://vim.fandom.com/wiki/Selecting_your_pasted_text
nmap <expr> gp "'[" . strpart(getregtype(), 0, 1) . "']"
nmap <expr> gP "`[" . strpart(getregtype(), 0, 1) . "`]"

vmap <silent> $ $h

nmap <silent> K <Nop>
vmap <silent> K <Nop>
vmap <silent> K <Nop>
vmap <silent> J <Nop>

nmap <silent> <c-j> gj
vmap <silent> <c-j> gj
nmap <silent> <c-k> gk
vmap <silent> <c-k> gk

nmap <silent> <leader>d "_d
vmap <silent> <leader>d "_d

nnoremap n nzz
nnoremap N Nzz

nmap <C-q> <Plug>window:quickfix:loop

nmap <silent> <C-t> :call OpenNERDTree()<CR>

nmap <S-h> 2zh
nmap <S-l> 2zl

nnoremap <space> za
vnoremap <space> zf

"nnoremap <expr> p (v:register ==# '"' ? PasteFromVimClipboard('p') : 'p')

command! R Ranger
