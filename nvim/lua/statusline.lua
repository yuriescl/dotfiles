local statusline = {
    "%m%r%w",                -- Modified? Readonly?
    "%<%F",                  -- File+path
    "%*"
}
vim.o.statusline = table.concat(statusline, " ")
