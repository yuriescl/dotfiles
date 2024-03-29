-- Plugins
local Plug = vim.fn['plug#']
vim.call('plug#begin')

-- Essential
Plug('bluz71/vim-moonfly-colors', { ['as'] = 'moonfly' })
Plug('yuriescl/fzf', {['do'] = vim.fn['fzf#install']})
Plug('yuriescl/fzf.vim')
Plug('yuriescl/nerdtree')
Plug('yuriescl/vim-ripgrep')
Plug('yuriescl/vim-toggle-quickfix')
Plug('github/copilot.vim')

-- Syntax
Plug('dart-lang/dart-vim-plugin')
Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})
Plug('sbdchd/neoformat')

-- LSP
-- To find language servers, see https://microsoft.github.io/language-server-protocol/implementors/servers/
-- Also see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- Prerequisites:
--   npm install -g pyright typescript typescript-language-server
Plug('neovim/nvim-lspconfig')
Plug('j-hui/fidget.nvim')
Plug('hedyhli/outline.nvim')

-- Misc
Plug('yuriescl/git-blame.nvim')
Plug('yuriescl/nvim-web-devicons')
Plug('yuriescl/minimal-bookmarks.nvim')

vim.call('plug#end')
