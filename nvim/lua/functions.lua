local functions = {}

function functions.toggle_fold_column()
    if vim.wo.foldcolumn ~= 0 then
        vim.wo.foldcolumn = 0
    else
        vim.wo.foldcolumn = 1
    end
end

function functions.toggle_set_list()
    if not vim.b.setlist or vim.b.setlist == 0 then
        vim.opt.listchars = {
            space = '·', tab = '» ', extends = '›', precedes = '‹',
            nbsp = '·', trail = '·', eol = '$'
        }
        vim.b.setlist = 1
    else
        vim.opt.listchars = {
            tab = '> ', extends = '›', precedes = '‹',
            nbsp = '+', trail = '-'
        }
        vim.b.setlist = 0
    end
end

function functions.toggle_fold_method()
    if vim.wo.foldmethod == 'manual' then
        vim.wo.foldmethod = 'syntax'
        vim.cmd('echo "foldmethod=syntax"')
    else
        vim.wo.foldmethod = 'manual'
        vim.cmd('echo "foldmethod=manual"')
    end
end

function functions.fzf_files()
    local is_git_repo = vim.fn.system('git rev-parse --is-inside-work-tree 2>/dev/null 1>/dev/null && echo -n "true" || echo -n "false"')
    if is_git_repo == 'true' then
        vim.cmd(':GFiles')
    else
        vim.cmd(':Files')
    end
end

function functions.open_nerdtree()
    if vim.fn.expand('%') == "" then
        vim.cmd('NERDTreeFocus')
    else
        vim.cmd('NERDTreeFind')
    end
end

function functions.open_terminal()
    vim.fn.system('tmux split-window -c "'..vim.fn.expand('%:p:h')..'"')
end

function functions.yank_to_clipboard()
    vim.fn.system('xclip -selection clipboard', vim.fn.trim(vim.fn.getreg('*')))
end

-- made by ChatGPT
function concatenate_args(...)
    local args = {...} -- Convert ... to a table
    local result = ""
    for i, arg in ipairs(args) do
        result = result .. tostring(arg) -- Convert each argument to string and concatenate
        if i < #args then
            result = result .. " " -- Add comma and space between arguments
        end
    end
    return result
end

-- Use :Rg to search for a string in the current working directory
-- rg_args_str is a string of arguments to pass to :Rg
function functions.rg_with_args(search_str, rg_args_str)
    if search_str then
        local cmd = 'Rg ' .. rg_args_str .. ' ' .. search_str
        vim.cmd('echom ' .. vim.fn.string(cmd))
        vim.api.nvim_feedkeys(':' .. cmd .. '\n', 'n', true)
    else
        local word = vim.fn.expand('<cword>')
        local cmd = 'Rg ' .. rg_args_str .. ' ' .. word
        vim.cmd('echom ' .. vim.fn.string(cmd))
        vim.api.nvim_feedkeys(':' .. cmd .. '\n', 'n', true)
    end
end

function functions.rg_proto(search_str)
    return functions.rg_with_args(search_str, '-g "*.proto"')
end

function functions.rg_not_gen(search_str)
    return functions.rg_with_args(search_str, '-g "!*/gen/*"')
end

function functions.rg_only_go(search_str)
    local rg_args_str = '-g "!**/gen/**" -g "!*_test.go" -g "!**/mocks/**" -g "!**/fixtures/**" -g "!*.ipynb" -g "!*.py" -g "!*.ts" -g "!*.sql" -g "!*.md" -g "!*.proto" -g "!*.js" -g "!*.json" -g "!*/vendor/*" -g "!*.lock" -g "!*.map"'
    return functions.rg_with_args(search_str, rg_args_str)
end

function functions.dart_config()
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    vim.api.nvim_set_keymap('n', '<C-y>', ':Neoformat! dart<CR>', {})
end

function functions.python_config()
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
    vim.api.nvim_set_keymap('n', '<C-y>', ':Neoformat! python black<CR>', {})
end

function functions.rust_config()
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
end

function functions.go_config()
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.expandtab = false
    vim.opt_local.listchars = { tab = '  ', extends = '›', precedes = '‹' }
    vim.api.nvim_set_keymap('n', '<C-y>', ':Neoformat! go<CR>', {})
end

function functions.typescript_config()
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    vim.api.nvim_set_keymap('n', '[g', 'vatv`<', { silent = true })
    vim.api.nvim_set_keymap('n', ']g', 'vatv`>', { silent = true })
    vim.api.nvim_set_keymap('n', '<C-y>', ':Neoformat! typescript prettier<CR>', {})
end

function functions.javascript_config()
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    vim.api.nvim_set_keymap('n', '[g', 'vatv`<', { silent = true })
    vim.api.nvim_set_keymap('n', ']g', 'vatv`>', { silent = true })
    vim.api.nvim_set_keymap('n', '<C-y>', ':Neoformat! javascript prettier<CR>', {})
end

function functions.css_config()
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    vim.api.nvim_set_keymap('n', '<C-y>', ':Neoformat! css prettier<CR>', {})
end

function functions.json_config()
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    vim.api.nvim_set_keymap('n', '<C-y>', ':Neoformat! json prettier<CR>', {})
end

function functions.html_config()
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    vim.api.nvim_set_keymap('n', '<C-y>', ':Neoformat! html prettier<CR>', {})
end

function functions.html_django_config()
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
end

function functions.markdown_config()
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
end

return functions
