-- Plugins
local Plug = vim.fn['plug#']
vim.call('plug#begin')

-- Essential
Plug('yuriescl/vim-moonfly-colors', { ['as'] = 'moonfly' })
Plug('yuriescl/fzf', {['do'] = vim.fn['fzf#install']})
Plug('yuriescl/fzf.vim')
Plug('yuriescl/nerdtree')
Plug('yuriescl/vim-ripgrep')
-- Plug('duane9/nvim-rg')
Plug('yuriescl/vim-toggle-quickfix')
-- Plug('yuriescl/copilot.vim')
Plug('Exafunction/windsurf.vim')

-- Syntax
--Plug('yuriescl/dart-vim-plugin')
Plug('yuriescl/nvim-treesitter', {['do'] = ':TSUpdate'})
Plug('nvim-treesitter/nvim-treesitter-context')
Plug('yuriescl/neoformat')

-- LSP
-- To find language servers, see https://microsoft.github.io/language-server-protocol/implementors/servers/
-- Also see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- Prerequisites:
--   npm install -g pyright typescript typescript-language-server
--   apt install python3-pynvim
--   pipx install ruff
Plug('yuriescl/nvim-lspconfig')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-path')
Plug('hrsh7th/cmp-cmdline')
Plug('hrsh7th/nvim-cmp')
Plug('nvim-lua/plenary.nvim')
Plug('pmizio/typescript-tools.nvim')

Plug('yuriescl/fidget.nvim')
Plug('yuriescl/outline.nvim')

-- Misc
Plug('yuriescl/git-blame.nvim')
--Plug('lewis6991/gitsigns.nvim')
--Plug('yuriescl/nvim-web-devicons')
Plug('yuriescl/minimal-bookmarks.nvim')
Plug('yuriescl/overlook.nvim')

vim.call('plug#end')
