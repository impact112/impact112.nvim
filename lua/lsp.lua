local lspconfig = require('lspconfig')

local handlers = {
  ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' }),
  ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' }),
}

local on_attach = function(client, bufnr)
  local set = vim.keymap.set

  local opts = { noremap = true, silent = true, buffer = bufnr }

  if client.name == 'omnisharp' then
    set('n', 'gd', '<Cmd>OmniSharpGotoDefinition<CR>', opts)
  else
    set('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  end
  set('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  set('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  set('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  set('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  set('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  set('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  set('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  set('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  set('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  set('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  set('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  set('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

require('mason').setup()

require('mason-lspconfig').setup({
  ensure_installed = {
    'omnisharp_mono',
    'tsserver',
    'pyright',
    'gopls',
    'html',
    'emmet_ls',
    'cssls',
    'eslint',
    'clangd',
    'lua_ls',
    'cmake',
    'glsl_analyzer',
    'texlab'
  },
})

local lang_servers = {
  omnisharp_mono = {
    root_dir = lspconfig.util.root_pattern('.git'),
  },
  tsserver = {},
  pyright = {},
  gopls = {},
  html = {
    filetypes = { 'html', 'razor' }
  },
  cssls = {},
  eslint = {
    on_attach = function(_, bufnr)
      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = bufnr,
        command = 'EslintFixAll',
      })
    end,
  },
  emmet_ls = {
    filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less' },
    init_options = {
      html = {
        options = {
          ['bem.enabled'] = true,
        },
      },
    }
  },
  clangd = {},
  lua_ls = {},
  cmake = {},
  glsl_analyzer = {},
  texlab = {}
}

for name, config in pairs(lang_servers) do
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  config.capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

  config.on_attach = on_attach
  config.handlers = handlers
  lspconfig[name].setup(config)
end

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

