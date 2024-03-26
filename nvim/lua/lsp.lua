local lspconfig = require('lspconfig')
local util = require('lspconfig.util')
require("fidget").setup {}
require("outline").setup({
    outline_window = {
        width = 60,
        relative_width = true,
    }
})

local function dir_has_file(dir, file)
  return util.search_ancestors(dir, function(path)
    local abs_path = util.path.join(path, file)
    if util.path.is_file(abs_path) then
      return true
    end
  end)
end

-- Python
lspconfig.pyright.setup {
  on_new_config = function(new_config, dir)
    if dir_has_file(dir, "poetry.lock") then
      new_config.cmd = { "poetry", "run", "pyright-langserver", "--stdio" }
    elseif dir_has_file(dir, "Pipfile") then
      new_config.cmd = { "pipenv", "run", "pyright-langserver", "--stdio" }
    else
      vim.notify_once("Running pyright without a virtualenv")
    end
  end
}

-- TypeScript
local function typescript_organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = {vim.api.nvim_buf_get_name(0)},
    title = ""
  }
  vim.lsp.buf.execute_command(params)
end

lspconfig.tsserver.setup {
  commands = {
    OrganizeImports = {
      typescript_organize_imports,
      description = "Organize Imports"
    }
  }
}

-- Go
lspconfig.gopls.setup {}

-- Dart
lspconfig.dartls.setup {}

require'lspconfig'.lua_ls.setup {
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
      return
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT'
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME
          -- Depending on the usage, you might want to add additional paths here.
          -- "${3rd}/luv/library"
          -- "${3rd}/busted/library",
        }
        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
        -- library = vim.api.nvim_get_runtime_file("", true)
      }
    })
  end,
  settings = {
    Lua = {}
  }
}

----------
-- Global

-- A helper function to wrap a function with arguments, useful for keymaps
local wrap = function(func, ...)
  local args = {...}
  return function()
    func(unpack(args))
  end
end

vim.keymap.set('n', 'gl', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '[e', wrap(vim.diagnostic.goto_prev, { severity = vim.diagnostic.severity.ERROR }))
vim.keymap.set('n', ']e', wrap(vim.diagnostic.goto_next, { severity = vim.diagnostic.severity.ERROR }))
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Default autocomplete to search current and included files.
    -- This fixes CTRL-N triggering keyword completion when LSP is enabled
    vim.cmd([[
    imap <C-n> <C-x><C-i>
    ]])

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<leader>k', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  end,
})

-- Populate loclist with the current buffer diagnostics
-- See https://gist.github.com/phelipetls/0aeb9f4aca9af25d9f45ee56e0c5a340?permalink_comment_id=4397599#gistcomment-4397599
vim.api.nvim_create_autocmd('DiagnosticChanged', {
  callback = function(args)
    vim.diagnostic.setloclist({open = false})
  end,
})
