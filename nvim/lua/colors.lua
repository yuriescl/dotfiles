-- Colorscheme
vim.cmd([[
colorscheme moonfly
highlight Normal guifg=#FFFFFF guibg=NONE ctermfg=15 ctermbg=NONE
]])

require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  highlight = {
    enable = true
  },
}

require'treesitter-context'.setup{
  enable = true,
}
