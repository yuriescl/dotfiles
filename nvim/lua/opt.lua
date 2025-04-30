-- General settings
vim.opt.colorcolumn = "80"
vim.opt.cursorline = true
vim.opt.scrolloff = 999
vim.opt.clipboard = "unnamed"
vim.api.nvim_set_var("mapleader", "\\")
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 0
vim.opt.laststatus = 2
vim.opt.keywordprg = "rg"
vim.opt.compatible = false
vim.opt.mouse = ""
vim.opt.expandtab = true
vim.opt.hidden = true
vim.opt.number = true
vim.opt.autoindent = true
vim.opt.smartindent = false
vim.opt.cindent = false
vim.opt.showmode = true
vim.opt.showcmd = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ruler = true
vim.opt.wrap = true
vim.opt.listchars = { tab = '> ', extends = '›', precedes = '‹', nbsp = '+', trail = '-' }
vim.opt.list = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.foldmethod = 'manual'
vim.opt.foldnestmax = 2
vim.opt.foldcolumn = '0'
vim.opt.foldenable = false
vim.opt.signcolumn = 'number'
vim.opt.modeline = false
vim.opt.visualbell = false
vim.opt.errorbells = false
vim.opt.tags:append("./tags") -- look for the tags file in current directory
vim.opt.tags:append("tags") -- then globally
vim.opt.updatetime = 500
vim.opt.wildmode = "longest,list"
vim.opt.undofile = true
vim.opt.swapfile = false
--vim.opt.completeopt = { "menu", "noinsert" }
--
