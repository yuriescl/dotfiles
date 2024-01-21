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
set listchars=tab:>\ ,extends:›,precedes:‹,nbsp:+,trail:-
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
set shada

call plug#begin(stdpath('data') . '/plugged')
  Plug 'yuriescl/fzf', { 'do': { -> fzf#install() } }
  Plug 'yuriescl/fzf.vim'
  Plug 'yuriescl/nerdtree'
  Plug 'dart-lang/dart-vim-plugin'
  Plug 'bluz71/vim-moonfly-colors', { 'as': 'moonfly' }
  "Plug 'yuriescl/yats.vim'
  Plug 'github/copilot.vim'
  Plug 'neovim/nvim-lspconfig'
  Plug 'j-hui/fidget.nvim'
  Plug 'duane9/nvim-rg'
call plug#end()

runtime macros/matchit.vim

filetype plugin on
filetype plugin indent off
filetype indent off

syntax enable

colorscheme moonfly
" Override the color of Normal text (white)
highlight Normal guifg=#FFFFFF guibg=NONE ctermfg=15 ctermbg=NONE

" Set the modified statusline with LSP information
set statusline=
set statusline+=%m%r%w\                                     "Modified? Readonly? 
set statusline+=%<%F                                        "File+path
set statusline+=%*
let s:statusline = 0

let g:netrw_banner = 0

" (Plugin fzf) Disable jumping to existing windows
let g:fzf_buffers_jump = 0
let g:fzf_preview_window = []
let $FZF_DEFAULT_COMMAND='rg -F --files --no-ignore --hidden --glob "!.git/*" --glob "!*__pycache__*" --glob "!build*" --glob "!*node_modules*" --glob "!.venv/*" --glob "!*.mypy_cache*" --glob "!*.next*"'

let NERDTreeWinSize = 32
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
    set listchars=tab:>\ ,extends:›,precedes:‹,nbsp:+,trail:-
    let s:setlist = 0
  endif
endfunction
command! -bar ToggleSetList call ToggleSetList()

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

function! OpenNERDTree()                   
    if @% == ""
        NERDTreeFocus
    else                                    
        NERDTreeFind
    endif                                   
endfun
command! -bar OpenNERDTree call OpenNERDTree()

function! OpenTerminal()
    call system('tmux split-window -c "'.expand('%:p:h').'"')
endfun
command! -bar OpenTerminal call OpenTerminal()

function YankToClipboard()
    call system('xclip -selection clipboard', trim(getreg('*')))
endfunction

function DartConfig()
    setlocal tabstop=2 shiftwidth=2
endfunction

function PythonConfig()
    setlocal tabstop=4 shiftwidth=4
endfunction

function RustConfig()
    setlocal tabstop=4 shiftwidth=4
endfunction

function GoConfig()
    setlocal noexpandtab tabstop=4 shiftwidth=4
    set listchars=tab:\ \ ,extends:›,precedes:‹
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

"""""""""""""""""""""""""""""""""""
"           Auto commands
"

" Uncomment the following to have Vim jump to the last position when                                                       
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

au FileType javascript,javascriptreact au BufEnter <buffer> call JavascriptConfig()
au FileType typescript,typescriptreact au BufEnter <buffer> call TypescriptConfig()
au FileType css au BufEnter <buffer> call CssConfig()
au FileType json au BufEnter <buffer> call JsonConfig()
au FileType html,xml au BufEnter <buffer> call HtmlConfig()
au FileType htmldjango au BufEnter <buffer> call HtmlDjangoConfig()
au FileType python au BufEnter <buffer> call PythonConfig()
au FileType dart au BufEnter <buffer> call DartConfig()
au FileType markdown au BufEnter <buffer> call MarkdownConfig()
au FileType rust au BufEnter <buffer> call RustConfig()
au FileType go au BufEnter <buffer> call GoConfig()
au FileType go compiler go | setlocal makeprg=go\ build
au FileType qf au BufEnter <buffer> nmap <silent> <CR> <CR>:cclose<CR>:lclose<CR>

" Fix syntax highlight when there's embedded TSX/JSX inside HTML
au BufEnter,BufNew *.html :syntax sync fromstart

"""""""""""""""""""""""""""""""""""
"           Mappings
"

nmap <silent> <leader>p :set paste<CR>"+p:set paste!<CR>
nmap <silent> <leader>P :set paste<CR>"+P:set paste!<CR>
nmap <silent> Y :call YankToClipboard()<CR>

nmap <silent> <F1> :noh<CR>
nmap <C-b> :Buffers<CR>
nmap <C-f> :Rg<Space>
nmap <C-g> :History<CR>
nmap <C-n> :Files<CR>
nmap <silent> <C-p> :w<CR>
nmap <silent> <C-x> :bdelete<CR>
nmap <silent> <C-t> :OpenTerminal<CR>
nmap <silent> <C-e> :OpenNERDTree<CR>

" Toggle quickfix. See https://stackoverflow.com/questions/11198382/how-to-create-a-key-map-to-open-and-close-the-quickfix-window-in-vim#comment122398806_63162084
nmap <expr> <C-q> empty(filter(getwininfo(), 'v:val.quickfix')) ? ':copen<CR>' : ':cclose<CR>'
nmap <expr> <S-q> empty(filter(getwininfo(), 'v:val.loclist')) ? ':lopen<CR>' : ':lclose<CR>'

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

" Avoid UI glitch on GitHub Copilot when exiting insert mode with Ctrl+c
inoremap <C-c> <Esc>

