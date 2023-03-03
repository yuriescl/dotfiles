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

call plug#begin(stdpath('data') . '/plugged')
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'danro/rename.vim'
  Plug 'vim-python/python-syntax'
  Plug 'yuriescl/vim-colorscheme'
  Plug 'qpkorr/vim-bufkill'
  Plug 'preservim/tagbar'
  Plug 'yuriescl/ranger.vim'
  Plug 'jremmen/vim-ripgrep'
  Plug 'drmingdrmer/vim-toggle-quickfix'
  Plug 'preservim/nerdtree'
  "Plug 'dense-analysis/ale'
  Plug 'inkarkat/vim-ingo-library'
  Plug 'inkarkat/vim-EnhancedJumps'
  Plug 'kana/vim-textobj-user'
  Plug 'dart-lang/dart-vim-plugin'
  Plug 'rhysd/vim-textobj-anyblock'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  "Plug 'mileszs/ack.vim'
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
set statusline+=%<%F\                                   "File+path
set statusline+=%=%#warningmsg#
"set statusline+=%{LinterStatus()}
set statusline+=%{coc#status()}%{get(b:,'coc_current_function','')}
set statusline+=%*
let s:statusline = 0

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    if l:counts.total == 0
        return ''
    else
        return printf(
        \   '%dW %dE',
        \   all_non_errors,
        \   all_errors
        \)
    endif
endfunction

""""""""""""
" Syntastic
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"let g:syntastic_python_checkers = ['flake8']
"let g:syntastic_python_flake8_post_args='--max-line-length=200 --ignore=E116,E302,E121,E123,E124,E126,E127,E128,E201,E202,E203,E211,E222,E225,E226,E231,E252,E261,E265,E303,E722,F401,F403,F405,F841,W291,W292,W391,W503 --exclude="**/migrations/**"'

""""""
" ALE
" In ~/.vim/vimrc, or somewhere similar.
"let g:ale_linters = {
"\   'python': ['flake8'],
"\}
"" Only run linters named in ale_linters settings.
"let g:ale_linters_explicit = 1
"let g:ale_python_flake8_options = '--max-line-length=120 --exclude="**/migrations/**"'
"let g:ale_lint_on_enter = 0
"let g:ale_lint_on_text_changed = 'never'

let dart_html_in_string=v:true

let g:textobj#anyblock#blocks=['(', '{', '[', 'f`']

let g:netrw_banner = 0

" (Plugin python-syntax) 
"let g:python_highlight_all = 1

" (Plugin fzf) Disable jumping to existing windows
let g:fzf_buffers_jump = 0
let g:fzf_preview_window = []
let $FZF_DEFAULT_COMMAND='rg -F --files --no-ignore --hidden --glob "!.git/*" --glob "!*__pycache__*" --glob "!build*" --glob "!node_modules/*" --glob "!.venv/*" --glob "!.mypy_cache/*"'

" (Plugin ranger)
let g:ranger_map_keys = 0  " disable the default key mapping

let NERDTreeWinSize = 32
let NERDTreeQuitOnOpen=1

" (Plugin python-syntax)
let g:python_highlight_all = 1

" https://github.com/neoclide/coc.nvim/issues/3930
" https://github.com/neoclide/coc.nvim/wiki/F.A.Q#cursor-disappeared-after-exit-coclist
let g:coc_disable_transparent_cursor = 1


""""""""""""""""""""""""""""""
" From plugin 'mileszs/ack.vim'
"
"let g:ackprg = 'rg --vimgrep --hidden --glob "!build*" --glob "!.git/*" --glob "!node_modules/*" --glob "!__pycache__/*" --glob "!*.min.js"'
" Auto close the Quickfix list after pressing '<enter>' on a list item
"let g:ack_autoclose = 1
" Any empty ack search will search for the work the cursor is on
"let g:ack_use_cword_for_empty_search = 1
" Don't jump to first match
"cnoreabbrev Ack Ack!

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
    set statusline+=%=%#warningmsg#
    "set statusline+=%{LinterStatus()}
    set statusline+=%{coc#status()}%{get(b:,'coc_current_function','')}
    set statusline+=%*

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
command! -bar OpenNERDTree call OpenNERDTree()

function YankToClipboard()
    call system('xclip -selection clipboard', trim(getreg('*')))
endfunction

command! ClearQuickfixList cexpr []

function! GetVisualSelection()
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfunction

function DartConfig()
    setlocal tabstop=2 shiftwidth=2
    nmap <silent> <C-y> :DartFmt<CR>
endfunction

function PythonConfig()
    setlocal tabstop=4 shiftwidth=4
    nmap <silent> <C-y> :Format<CR>
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
    setlocal tabstop=2 shiftwidth=2
    nmap <silent> <C-y> :Format<CR>
endfunction

function OpenTerminal()
    execute ':silent !source ~/.bashrc.d/colorterm.sh && vim-tmux-new-window '.expand('%:p:h').' '.v:servername
endfunction
command! -bar OpenTerminal call OpenTerminal()

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

command! -bar Black execute ":!black %"
command! -bar Isort execute ":!isort %"

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
au FileType qf au BufEnter <buffer> nmap <silent> <CR> <CR>:cclose<CR>:lclose<CR>

" coc-nvim
au CursorHold * silent call CocActionAsync('highlight')

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
nmap <silent> <C-x> :BD<CR>

nmap <silent> <C-t> :OpenNERDTree<CR>

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

nmap <C-q> <Plug>window:quickfix:loop

nmap <S-h> 2zh
nmap <S-l> 2zl

command! R Ranger

nmap <silent> <leader>t :OpenTerminal<CR>
nmap <silent> <C-t> :OpenNERDTree<CR>

nmap <space> %
vmap <space> %

nmap <C-]> g<C-]>

"""""""""""
" coc-nvim
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
nmap <silent> K :call ShowDocumentation()<CR>
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')
" Add `:OrganizeImport` command for organize imports of the current buffer.
command! -nargs=0 OrganizeImport :call CocActionAsync('runCommand', 'editor.action.organizeImport')
command! -nargs=0 CD :CocDiagnostics<CR>
command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument

