-- Configure filetype-specific settings
vim.cmd([[
autocmd FileType javascript,javascriptreact lua functions.javascript_config()
autocmd FileType typescript,typescriptreact lua functions.typescript_config()
autocmd FileType css lua functions.css_config()
autocmd FileType json lua functions.json_config()
autocmd FileType html,xml lua functions.html_config()
autocmd FileType htmldjango lua functions.html_django_config()
autocmd FileType python lua functions.python_config()
autocmd FileType dart lua functions.dart_config()
autocmd FileType markdown lua functions.markdown_config()
autocmd FileType rust lua functions.rust_config()
autocmd FileType go lua functions.go_config()
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

