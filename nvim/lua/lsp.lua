local lspconfig = require('lspconfig')
local util = require('lspconfig.util')
local cmp = require('cmp')
require("fidget").setup {}
require("outline").setup({
    outline_window = {
        width = 60,
        relative_width = true,
    },
    keymaps = {
        goto_location = '<S-CR>',
        goto_and_close = '<CR>',
    },
})

cmp.setup({
  completion = {
    autocomplete = false
  },
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    --['<C-b>'] = cmp.mapping.scroll_docs(-4),
    --['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    --{ name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  })
})

local cmp_default_capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Try to get Python path from Poetry
local function get_poetry_python_path()
  local handle = io.popen("poetry env info -p 2>/dev/null")
  if not handle then return nil end
  local result = handle:read("*a")
  handle:close()
  local venv_path = vim.fn.trim(result)
  local python_path = venv_path .. "/bin/python"
  if vim.fn.filereadable(python_path) == 1 then
    return python_path
  end
  return nil
end

-- Try to get Python path from uv
local function get_uv_python_path()
  local handle = io.popen("uv venv 2>/dev/null")
  if not handle then return nil end
  local result = handle:read("*a")
  handle:close()
  local venv_path = vim.fn.trim(result)
  local python_path = venv_path .. "/bin/python"
  if vim.fn.filereadable(python_path) == 1 then
    return python_path
  end
  return nil
end

require("lspconfig").pyright.setup {
  capabilities = cmp_default_capabilities,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "openFilesOnly",
      },
    },
  },
  before_init = function(_, config)
    local python_path = nil
    local root_dir = config.root_dir
  
    if root_dir and util.path.is_file(util.path.join(root_dir, "pyproject.toml")) then
      python_path = get_poetry_python_path() or get_uv_python_path()
    end
  
    if python_path and vim.fn.filereadable(python_path) == 1 then
      config.settings.python.pythonPath = python_path
    else
      config.settings.python.pythonPath = vim.fn.exepath("python3")
    end
  end
}

-- TypeScript
--local function typescript_organize_imports()
--  local params = {
--    command = "_typescript.organizeImports",
--    arguments = {vim.api.nvim_buf_get_name(0)},
--    title = ""
--  }
--  vim.lsp.buf.execute_command(params)
--end
--
--lspconfig.ts_ls.setup {
--  capabilities = cmp_default_capabilities,
--  commands = {
--    OrganizeImports = {
--      typescript_organize_imports,
--      description = "Organize Imports"
--    }
--  }
--}
require("typescript-tools").setup {}


-- Go
lspconfig.gopls.setup {
  capabilities = cmp_default_capabilities,
}

-- Dart
lspconfig.dartls.setup {
  capabilities = cmp_default_capabilities,
}

require'lspconfig'.lua_ls.setup {
  capabilities = cmp_default_capabilities,
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
vim.keymap.set('n', '[d', vim.diagnostic.goto_next)
vim.keymap.set('n', ']d', vim.diagnostic.goto_prev)
vim.keymap.set('n', '[e', wrap(vim.diagnostic.goto_next, { severity = vim.diagnostic.severity.ERROR }))
vim.keymap.set('n', ']e', wrap(vim.diagnostic.goto_prev, { severity = vim.diagnostic.severity.ERROR }))
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

vim.api.nvim_create_autocmd('DiagnosticChanged', {
  callback = function(args)
    local bufnr = args.buf
    local diagnostics = vim.diagnostic.get(bufnr)

    -- Only set loclist if there are diagnostics to display
    if #diagnostics > 0 then
      vim.diagnostic.setloclist({open = false})
    end
  end,
})
