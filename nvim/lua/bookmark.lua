require('bookmarks').setup {
  -- sign_priority = 8,  --set bookmark sign priority to cover other sign
  save_file = vim.fn.expand "$HOME/.bookmarks", -- bookmarks save file path
  keywords =  {
    ["@t"] = "☑️ ", -- mark annotation startswith @t ,signs this icon as `Todo`
    ["@w"] = "⚠️ ", -- mark annotation startswith @w ,signs this icon as `Warn`
    ["@f"] = "⛏ ", -- mark annotation startswith @f ,signs this icon as `Fix`
    ["@n"] = " ", -- mark annotation startswith @n ,signs this icon as `Note`
  },
  width = 1.0,                   -- bookmarks window width:  (0, 1]
  preview_ratio = 0.2,          -- bookmarks preview window ratio (0.1]
  tags_ratio = 0.1,
  keymap = {
    toggle = "<tab><tab>",     -- toggle bookmarks
    close = "q",               -- close bookmarks (buffer mapping)
    add = "<leader>ba",               -- add bookmarks
    add_global = "<leader>bg",        -- add global bookmarks
    jump = "<CR>",             -- jump from bookmarks
    delete = "dd",             -- delete bookmarks
    order = "<space><space>",  -- order bookmarks by frequency or updated_time
    delete_on_virt = "<leader>bd",   -- delete bookmark at virt text line
    show_desc = "<leader>bs",        -- show bookmark desc
    focus_tags = "<leader>bt",      -- focus tags window
    focus_bookmarks = "<leader>bb", -- focus bookmarks window
    toogle_focus = "<leader>bf",  -- toggle window focus (tags-window <-> bookmarks-window)
},
}
