" Note: default <leader> is usually \
let mapleader = "\\"

set tabstop=4
set shiftwidth=4
set softtabstop=0
set laststatus=2
set keywordprg=rg
set nocompatible
set colorcolumn=80
set mouse=
set expandtab
set hidden
set number
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
set listchars=extends:›,precedes:‹
set list
set ignorecase
set smartcase
set foldmethod=manual
set foldnestmax=2
set foldcolumn=0
set signcolumn=number
set nomodeline
set vb t_vb=     " no visual bell & flash
set tags=./tags,tags  " look for the tags file in current directory, then globally
set updatetime=500
set wildmode=longest,list
set scrolloff=999
set clipboard=unnamed
set undofile
set noswapfile

runtime macros/matchit.vim

filetype plugin on
filetype plugin indent off
filetype indent off

syntax enable

colorscheme desert

function CwdName()
    return fnamemodify(getcwd(), ':t')
endfunction

set statusline=
set statusline+=%m%r%w\                                 "Modified? Readonly? 
set statusline+=%<%F\                                   "File+path
set statusline+=%*
let s:statusline = 0

let g:netrw_banner = 0

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
    set statusline+=%*

    let s:statusline = 0
  endif
endfunction
command! -bar ToggleStatusLine call ToggleStatusLine()

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

command! ClearQuickfixList cexpr []

function DartConfig()
    setlocal tabstop=2 shiftwidth=2
endfunction

function PythonConfig()
    setlocal tabstop=4 shiftwidth=4
endfunction

function TypescriptConfig()
    setlocal tabstop=2 shiftwidth=2
    " jump to begin of tag
    nmap <silent> [g vatv`<
    " jump to end of tag
    nmap <silent> ]g vatv`>
endfunction

function JavascriptConfig()
    setlocal tabstop=2 shiftwidth=2
    " jump to begin of tag
    nmap <silent> [g vatv`<
    " jump to end of tag
    nmap <silent> ]g vatv`>
endfunction

function CssConfig()
    setlocal tabstop=2 shiftwidth=2
endfunction

function JsonConfig()
    setlocal tabstop=2 shiftwidth=2
endfunction

function HtmlConfig()
    setlocal tabstop=2 shiftwidth=2
endfunction

function HtmlDjangoConfig()
    setlocal tabstop=2 shiftwidth=2
endfunction

function MarkdownConfig()
    setlocal tabstop=2 shiftwidth=2
endfunction

au FileType javascript,javascriptreact au BufEnter <buffer> call JavascriptConfig()
au FileType typescript,typescriptreact au BufEnter <buffer> call TypescriptConfig()
au FileType css au BufEnter <buffer> call CssConfig()
au FileType json au BufEnter <buffer> call JsonConfig()
au FileType html,xml au BufEnter <buffer> call HtmlConfig()
au FileType htmldjango au BufEnter <buffer> call HtmlDjangoConfig()
au FileType python au BufEnter <buffer> call PythonConfig()
au FileType dart au BufEnter <buffer> call DartConfig()
au FileType markdown au BufEnter <buffer> call MarkdownConfig()
au FileType qf au BufEnter <buffer> nmap <silent> <CR> <CR>:cclose<CR>:lclose<CR>

nmap <silent> <F1> :noh<CR>
nmap <silent> <C-x> :bd<CR>

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

nmap n nzz
nmap N Nzz

nmap <S-h> 2zh
nmap <S-l> 2zl

nmap <space> %
vmap <space> %

nmap <C-]> g<C-]>

