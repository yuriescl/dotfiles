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
  Plug 'yuriescl/vim-ripgrep'
  Plug 'yuriescl/vim-toggle-quickfix'
  Plug 'yuriescl/nerdtree'
  Plug 'dart-lang/dart-vim-plugin'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  "Plug 'sheerun/vim-polyglot'
  Plug 'github/copilot.vim'
  Plug 'charlespascoe/vim-go-syntax'
  Plug 'bluz71/vim-moonfly-colors', { 'as': 'moonfly' }
  Plug 'liuchengxu/vista.vim'
call plug#end()

" Settings

"" Native configs
runtime macros/matchit.vim
filetype plugin on
filetype plugin indent off
filetype indent off
syntax enable
let g:netrw_banner = 0

""" Statusline
set statusline=
set statusline+=%m%r%w\                                 "Modified? Readonly? 
set statusline+=%<%F\                                   "File+path
set statusline+=%=%#warningmsg#
set statusline+=%{coc#status()}%{get(b:,'coc_current_function','')}
set statusline+=%*
let s:statusline = 0

" bluz71/vim-moonfly-colors
colorscheme moonfly
" Override the color of Normal text (white)
highlight Normal guifg=#FFFFFF guibg=NONE ctermfg=15 ctermbg=NONE

" liuchengxu/vista.vim
let g:vista_default_executive = 'coc'

" dart-lang/dart-vim-plugin
let dart_html_in_string=v:true

" dart-lang/dart-vim-plugin
let g:textobj#anyblock#blocks=['(', '{', '[', 'f`']

" yuriescl/fzf.vim
" Disable jumping to existing windows
let g:fzf_buffers_jump = 0
let g:fzf_preview_window = []
let $FZF_DEFAULT_COMMAND='rg -F --files --no-ignore --hidden --glob "!.git/*" --glob "!*__pycache__*" --glob "!build*" --glob "!*node_modules*" --glob "!.venv/*" --glob "!*.mypy_cache*" --glob "!*.next*"'

" yuriescl/nerdtree
let NERDTreeWinSize = 32
let NERDTreeQuitOnOpen=1

" neoclide/coc.nvim
" https://github.com/neoclide/coc.nvim/issues/3930
" https://github.com/neoclide/coc.nvim/wiki/F.A.Q#cursor-disappeared-after-exit-coclist
let g:coc_disable_transparent_cursor = 1


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
command! -bar OpenNERDTree call OpenNERDTree()

function! OpenTerminal()
    call system('tmux split-window -c "'.expand('%:p:h').'"')
endfun
command! -bar OpenTerminal call OpenTerminal()

function YankToClipboard()
    call system('xclip -selection clipboard', trim(getreg('*')))
endfunction

" Toggle CoC git blame virtual text
let g:coc_git_hide_blame_virtual_text = !get(g:, 'coc_git_hide_blame_virtual_text', 0)
function CocGitBlameToggle()
  let g:coc_git_hide_blame_virtual_text = !g:coc_git_hide_blame_virtual_text
  if g:coc_git_hide_blame_virtual_text
    echo 'Blame virtual text is hidden'
  else
    echo 'Blame virtual text is shown'
  endif
endfunction
command! -nargs=0 CocGitBlameToggle :call CocGitBlameToggle()

command! ClearQuickfixList cexpr []

function DartConfig()
    setlocal tabstop=2 shiftwidth=2
    nmap <silent> <C-y> :Format<CR>
endfunction

function PythonConfig()
    setlocal tabstop=4 shiftwidth=4
    nmap <silent> <C-y> :Format<CR>
endfunction

function RustConfig()
    setlocal tabstop=4 shiftwidth=4
    nmap <silent> <C-y> :Format<CR>
endfunction

function GoConfig()
    setlocal noexpandtab tabstop=4 shiftwidth=4
    nmap <silent> <C-y> :Format<CR>
    set listchars=tab:\ \ ,extends:›,precedes:‹
endfunction

function TypescriptConfig()
    setlocal tabstop=2 shiftwidth=2
    nmap <silent> <C-y> :Prettier<CR>
    " jump to begin of tag
    nmap <silent> [g vatv`<
    " jump to end of tag
    nmap <silent> ]g vatv`>
endfunction

function JavascriptConfig()
    setlocal tabstop=2 shiftwidth=2
    nmap <silent> <C-y> :Prettier<CR>
    " jump to begin of tag
    nmap <silent> [g vatv`<
    " jump to end of tag
    nmap <silent> ]g vatv`>
endfunction

function CssConfig()
    setlocal tabstop=2 shiftwidth=2
    nmap <silent> <C-y> :Prettier<CR>
endfunction

function JsonConfig()
    setlocal tabstop=2 shiftwidth=2
    nmap <silent> <C-y> :Format<CR>
endfunction

function HtmlConfig()
    setlocal tabstop=2 shiftwidth=2
    nmap <silent> <C-y> :Prettier<CR>
endfunction

function HtmlDjangoConfig()
    setlocal tabstop=2 shiftwidth=2
    nmap <silent> <C-y> :Format<CR>
endfunction

function MarkdownConfig()
    setlocal tabstop=4 shiftwidth=4
    nmap <silent> <C-y> :Format<CR>
endfunction

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
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
au FileType qf au BufEnter <buffer> nmap <silent> <CR> <CR>:cclose<CR>:lclose<CR>

" Fix syntax highlight when there's embedded TSX/JSX inside HTML
au BufEnter,BufNew *.html :syntax sync fromstart

" coc-nvim
au CursorHold * silent call CocActionAsync('highlight')

" https://github.com/neoclide/coc.nvim/issues/2993
au User CocStatusChange redrawstatus

" Mappings

"" Simple mappings

nmap <silent> Y :call YankToClipboard()<CR>
nmap <silent> <F1> :noh<CR>

""" See https://vim.fandom.com/wiki/Move_cursor_by_display_lines_when_wrapping
nmap <silent> j gj
vmap <silent> j gj
nmap <silent> k gk
vmap <silent> k gk

""" See https://vim.fandom.com/wiki/Selecting_your_pasted_text
nmap <expr> gp "'[" . strpart(getregtype(), 0, 1) . "']"
nmap <expr> gP "`[" . strpart(getregtype(), 0, 1) . "`]"

vmap <silent> $ $h
nmap <silent> K <Nop>
vmap <silent> K <Nop>
vmap <silent> K <Nop>
vmap <silent> J <Nop>
nmap n nzz
nmap N Nzz
nmap <S-h> 2zh
nmap <S-l> 2zl
nmap <space> %
vmap <space> %


"" <leader>
nmap <silent> <leader>p :set paste<CR>"+p:set paste!<CR>
nmap <silent> <leader>P :set paste<CR>"+P:set paste!<CR>
nmap <silent> <leader>d "_d
vmap <silent> <leader>d "_d

"" Control + <key>
nmap <C-b> :Buffers<CR>
nmap <C-f> :Rg<Space>
nmap <C-g> :History<CR>
nmap <C-n> :Files<CR>
nmap <silent> <C-p> :w<CR>
nmap <silent> <C-x> :bd<CR>
nmap <silent> <C-t> :OpenTerminal<CR>
nmap <silent> <C-e> :OpenNERDTree<CR>
nmap <silent> <c-j> gj
vmap <silent> <c-j> gj
nmap <silent> <c-k> gk
vmap <silent> <c-k> gk
nmap <C-q> <Plug>window:quickfix:loop
nmap <C-]> g<C-]>

"" LSP
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gl :call CocAction('diagnosticInfo')<CR>
nmap <leader>rn <Plug>(coc-rename)
nmap <silent> K :call ShowDocumentation()<CR>
command! -nargs=0 CD :CocDiagnostics<CR>

" https://github.com/neoclide/coc.nvim/issues/64#issuecomment-662102899
try
    nmap <silent> [e <Plug>(coc-diagnostic-next-error)
    nmap <silent> ]e <Plug>(coc-diagnostic-prev-error)

    nmap <silent> [d :call CocAction('diagnosticNext')<cr>
    nmap <silent> ]d :call CocAction('diagnosticPrevious')<cr>
endtry

" Avoid UI glitch on GitHub Copilot when exiting insert mode with Ctrl+c
imap <C-c> <Esc>

" Use <c-space> to trigger completion
if has('nvim')
  imap <silent><expr> <c-space> coc#refresh()
else
  imap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
imap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

nmap <silent><nowait> <leader>s  :<C-u>CocList -I symbols<cr>
nmap <silent><nowait> <leader>t  :Vista!!<cr>
