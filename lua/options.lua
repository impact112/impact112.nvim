-- Line numbers
vim.opt.number = true
vim.opt.numberwidth = 3

-- Tab settings
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

-- Mouse support
vim.opt.mouse = 'a'

-- List and listchars
vim.opt.list = true
vim.opt.listchars:append({ space = '·' })

-- Autoreload modified files
vim.o.autoread = true

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Fix clipboard
vim.api.nvim_set_option("clipboard", "unnamedplus")

-- Automatic formatting
vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
