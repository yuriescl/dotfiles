vim.cmd([[
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
nmap <silent> Y :lua functions.yank_to_clipboard()<CR>
nmap <silent> <F1> :noh<CR>

""" Avoid UI glitch on GitHub Copilot when exiting insert mode with Ctrl+c
imap <C-c> <Esc>

""" See https://vim.fandom.com/wiki/Move_cursor_by_display_lines_when_wrapping
nmap <silent> j gj
vmap <silent> j gj
nmap <silent> k gk
vmap <silent> k gk

""" See https://vim.fandom.com/wiki/Selecting_your_pasted_text
nmap <expr> gp "'[" . strpart(getregtype(), 0, 1) . "']"
nmap <expr> gP "`[" . strpart(getregtype(), 0, 1) . "`]"

"" <leader>
nmap <silent> <leader>p :set paste<CR>"+p:set paste!<CR>
nmap <silent> <leader>P :set paste<CR>"+P:set paste!<CR>
nmap <silent> <leader>d "_d
vmap <silent> <leader>d "_d
nmap <silent> <leader>w :set wrap!<CR>

"" Control + <key>
nmap <C-b> :Buffers<CR>
nmap <C-f> :Rg<Space>
nmap <C-g> :History<CR>
nmap <C-n> :Files<CR>
nmap <silent> <C-p> :w<CR>
nmap <silent> <C-x> :bd<CR>
nmap <silent> <C-t> :lua functions.open_terminal()<CR>
nmap <silent> <C-e> :lua functions.open_nerdtree()<CR>
nmap <silent> <c-j> gj
vmap <silent> <c-j> gj
nmap <silent> <c-k> gk
vmap <silent> <c-k> gk
nmap <C-q> <Plug>window:quickfix:loop
nmap <C-]> g<C-]>
]])


-- Default autocomplete to search current and included files.
-- This fixes CTRL-N triggering keyword completion.
vim.cmd([[
imap <C-n> <C-x><C-i>
]])
