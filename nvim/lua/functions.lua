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
        vim.wo.foldmethod = 'indent'
        vim.wo.foldlevel = 0
    else
        vim.wo.foldmethod = 'manual'
        vim.cmd([[normal! zE]])
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
    return functions.rg_with_args(search_str, '-g "!**/gen/**"')
end

function functions.rg_code(search_str)
    return functions.rg_with_args(search_str, '-g "!**/gen/**" -g "!**/vendor/**"')
end

function functions.rg_service_func(search_str)
    if not search_str then
        search_str = vim.fn.expand('<cword>')
    end
    return functions.rg_with_args('func.*' .. search_str, '-g "*service.go"')
end

function functions.rg_only_go(search_str)
    local rg_args_str = '-g "!**/gen/**" -g "!*_test.go" -g "!**/mocks/**" -g "!**/fixtures/**" -g "!*.ipynb" -g "!*.py" -g "!*.ts" -g "!*.sql" -g "!*.md" -g "!*.proto" -g "!*.js" -g "!*.json" -g "!*/vendor/*" -g "!*.lock" -g "!*.map"'
    return functions.rg_with_args(search_str, rg_args_str)
end

function functions.dart_config()
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    vim.api.nvim_set_keymap('n', '<C-y>', ':lua vim.lsp.buf.format()<CR>', {})
end

function functions.python_config()
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
    --vim.api.nvim_set_keymap('n', '<C-y>', [[:lua RunNeoformat()<CR>]], {})
    ---- Define the RunNeoformat function to handle remapping Ctrl-C
    --function RunNeoformat()
    --    -- Disable Ctrl-C temporarily
    --    vim.api.nvim_set_keymap('n', '<C-c>', '<Nop>', { noremap = true, silent = true })

    --    -- Run Neoformat and then restore Ctrl-C functionality
    --    vim.cmd([[Neoformat! python black]])

    --    -- Re-enable Ctrl-C
    --    vim.api.nvim_del_keymap('n', '<C-c>')
    --end
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

    vim.api.nvim_set_keymap('n', '<C-y>', '<cmd>lua vim.lsp.buf.format({ async = false, timeout_ms = 500 })<CR>', { noremap = true, silent = true })
end

function functions.typescript_config()
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    vim.api.nvim_set_keymap('n', '[g', 'vatv`<', { silent = true })
    vim.api.nvim_set_keymap('n', ']g', 'vatv`>', { silent = true })

    vim.api.nvim_set_keymap('n', '<C-y>', [[:lua RunNeoformat()<CR>]], {})
    -- Define the RunNeoformat function to handle remapping Ctrl-C
    function RunNeoformat()
        -- Disable Ctrl-C temporarily
        vim.api.nvim_set_keymap('n', '<C-c>', '<Nop>', { noremap = true, silent = true })

        -- Run Neoformat and then restore Ctrl-C functionality
        vim.cmd([[Neoformat! typescript prettier]])

        -- Re-enable Ctrl-C
        vim.api.nvim_del_keymap('n', '<C-c>')
    end
end

function functions.javascript_config()
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    vim.api.nvim_set_keymap('n', '[g', 'vatv`<', { silent = true })
    vim.api.nvim_set_keymap('n', ']g', 'vatv`>', { silent = true })

    vim.api.nvim_set_keymap('n', '<C-y>', [[:lua RunNeoformat()<CR>]], {})
    -- Define the RunNeoformat function to handle remapping Ctrl-C
    function RunNeoformat()
        -- Disable Ctrl-C temporarily
        vim.api.nvim_set_keymap('n', '<C-c>', '<Nop>', { noremap = true, silent = true })

        -- Run Neoformat and then restore Ctrl-C functionality
        vim.cmd([[Neoformat! javascript prettier]])

        -- Re-enable Ctrl-C
        vim.api.nvim_del_keymap('n', '<C-c>')
    end
end

function functions.css_config()
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    vim.api.nvim_set_keymap('n', '<C-y>', [[:lua RunNeoformat()<CR>]], {})
    -- Define the RunNeoformat function to handle remapping Ctrl-C
    function RunNeoformat()
        -- Disable Ctrl-C temporarily
        vim.api.nvim_set_keymap('n', '<C-c>', '<Nop>', { noremap = true, silent = true })

        -- Run Neoformat and then restore Ctrl-C functionality
        vim.cmd([[Neoformat! css prettier]])

        -- Re-enable Ctrl-C
        vim.api.nvim_del_keymap('n', '<C-c>')
    end
end

function functions.json_config()
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    vim.api.nvim_set_keymap('n', '<C-y>', [[:lua RunNeoformat()<CR>]], {})
    -- Define the RunNeoformat function to handle remapping Ctrl-C
    function RunNeoformat()
        -- Disable Ctrl-C temporarily
        vim.api.nvim_set_keymap('n', '<C-c>', '<Nop>', { noremap = true, silent = true })

        -- Run Neoformat and then restore Ctrl-C functionality
        vim.cmd([[Neoformat! json prettier]])

        -- Re-enable Ctrl-C
        vim.api.nvim_del_keymap('n', '<C-c>')
    end
end

function functions.html_config()
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    vim.api.nvim_set_keymap('n', '<C-y>', [[:lua RunNeoformat()<CR>]], {})
    -- Define the RunNeoformat function to handle remapping Ctrl-C
    function RunNeoformat()
        -- Disable Ctrl-C temporarily
        vim.api.nvim_set_keymap('n', '<C-c>', '<Nop>', { noremap = true, silent = true })

        -- Run Neoformat and then restore Ctrl-C functionality
        vim.cmd([[Neoformat! html prettier]])

        -- Re-enable Ctrl-C
        vim.api.nvim_del_keymap('n', '<C-c>')
    end
end

function functions.html_django_config()
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
end

function functions.markdown_config()
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
end

function functions.check_lsp()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if next(clients) == nil then
    vim.api.nvim_echo({{"No active LSP attached to this buffer", "ErrorMsg"}}, true, {})
  else
    vim.lsp.buf.references()
  end
end

return functions
