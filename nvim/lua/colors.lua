-- Colorscheme
vim.cmd([[
colorscheme moonfly
highlight Normal guifg=#FFFFFF guibg=NONE ctermfg=15 ctermbg=NONE
]])

require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "go",
    "python",
    "bash",
    "markdown",
    "json",
    "css",
    "html",
    "javascript",
    "typescript",
    "tsx",
  },
  highlight = {
    enable = true,
  },
}

require'treesitter-context'.setup{
  enable = true,
  max_lines = 1,
}
