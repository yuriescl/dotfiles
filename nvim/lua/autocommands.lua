-- Configure filetype-specific settings
vim.cmd([[
autocmd FileType javascript,javascriptreact lua require "functions".javascript_config()
autocmd FileType typescript,typescriptreact lua require "functions".typescript_config()
autocmd FileType css lua require "functions".css_config()
autocmd FileType json lua require "functions".json_config()
autocmd FileType html,xml lua require "functions".html_config()
autocmd FileType htmldjango lua require "functions".html_django_config()
autocmd FileType python lua require "functions".python_config()
autocmd FileType dart lua require "functions".dart_config()
autocmd FileType markdown lua require "functions".markdown_config()
autocmd FileType rust lua require "functions".rust_config()
autocmd FileType go lua require "functions".go_config()
autocmd FileType qf lua vim.api.nvim_buf_set_keymap(0, 'n', '<CR>', '<CR>:cclose<CR>:lclose<CR>', {silent = true})
autocmd FileType qf lua vim.opt_local.wrap = false
]])

-- Fix syntax highlight when there's embedded TSX/JSX inside HTML
vim.cmd([[
autocmd BufEnter,BufNew *.html syntax sync fromstart
]])

-- Restore cursor position
vim.cmd([[
if has("autocmd")
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
  \| exe "normal! g'\"" | endif
endif
]])

-- https://stackoverflow.com/a/77999918
--vim.api.nvim_create_autocmd({ "FileType" }, {
--  callback = function()
--    if require("nvim-treesitter.parsers").has_parser() then
--      vim.opt.foldmethod = "expr"
--      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
--    else
--      vim.opt.foldmethod = "syntax"
--    end
--  end,
--})
