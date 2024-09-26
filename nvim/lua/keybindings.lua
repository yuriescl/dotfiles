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
nmap <silent> Y :lua require "functions".yank_to_clipboard()<CR>
nmap <silent> <Esc> :noh<CR>

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
nmap <silent> <leader>bb :MinimalBookmarksToggle<CR>
nmap <silent> <leader>be :MinimalBookmarksEdit<CR>
nmap <silent> <leader>ba :MinimalBookmarksAdd<CR>
nmap <silent> <leader>bi :MinimalBookmarksInsert<CR>
nmap <silent> <leader>o :topleft Outline<CR>
nmap <silent> <leader>l <C-w>10>
nmap <silent> <leader>h <C-w>10<
nmap <leader>c :let b:copilot_enabled = !get(b:, 'copilot_enabled', v:false)<CR>

"" Control + <key>
nmap <C-b> :Buffers<CR>
"nmap <C-f> :Rg<Space>
nmap <C-f> :RgCode<Space>
nmap <C-g> :History<CR>
nmap <C-n> :Files<CR>
nmap <silent> <C-p> :w<CR>
nmap <silent> <C-x> :bd<CR>
"nmap <silent> <C-t> :lua require "functions".open_terminal()<CR>
nmap <silent> <C-e> :lua require "functions".open_nerdtree()<CR>
nmap <silent> <c-j> gj
vmap <silent> <c-j> gj
nmap <silent> <c-k> zA
vmap <silent> <c-k> gk
nmap <C-q> <Plug>window:quickfix:loop
nmap <C-]> g<C-]>
nmap <C-[> za

nmap <silent> gr :lua require "functions".check_lsp()<CR>
]])


