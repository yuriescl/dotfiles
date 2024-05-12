require("opt")
require("plug")
require("colors")
require("statusline")
require("functions")
require("commands")
require("autocommands")
require("keybindings")
require("lsp")
require("fzf")

-- Load built-in plugins
vim.cmd([[
runtime macros/matchit.vim
filetype plugin on
filetype plugin indent off
filetype indent off
syntax enable
]])

vim.g.netrw_banner = 0

vim.g.dart_html_in_string = true

vim.g.fzf_buffers_jump = 0
vim.g.fzf_preview_window = {}

vim.env.FZF_DEFAULT_COMMAND = 'rg -F --files --no-ignore --hidden --glob "!.git/*" --glob "!*__pycache__*" --glob "!build*" --glob "!*node_modules*" --glob "!.venv/*" --glob "!*.mypy_cache*" --glob "!*.next*"'

vim.g.NERDTreeWinSize = 32
vim.g.NERDTreeQuitOnOpen = 1
vim.g.NERDTreeShowBookmarks = 1

vim.g.gitblame_enabled = 0 -- use :GitBlameToggle to toggle

vim.cmd([[
augroup quickfix
    autocmd!
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost l* lwindow
augroup END
]])
