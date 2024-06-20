local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Example using a list of specs with the default options
vim.g.mapleader = ' ' -- Make sure to set `mapleader` before lazy so your mappings are correct

require('lazy').setup({
  {
    'folke/lazy.nvim'
  },
  {
    'nvim-tree/nvim-tree.lua',
    lazy = false
  },
  {
    'nvim-tree/nvim-web-devicons'
  },
  {
    'Mofiqul/adwaita.nvim',
    lazy = false,
    priority = 1000,

    -- configure and set on startup
    config = function()
      vim.g.adwaita_darker = true -- for darker version
      vim.g.adwaita_transparent = true
      vim.cmd('colorscheme adwaita')
    end
  },
  {
    'nvim-lualine/lualine.nvim'
  },
  {
    'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim',
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {
    },
  },
  {
    'mhartington/formatter.nvim'
  },
  {
    'hrsh7th/nvim-cmp'
  },
  {
    'hrsh7th/cmp-nvim-lsp'
  },
  {
    'saadparwaiz1/cmp_luasnip'
  },
  {
    'L3MON4D3/LuaSnip'
  },
  {
    'williamboman/mason.nvim'
  },
  {
    'williamboman/mason-lspconfig.nvim'
  },
  {
    'neovim/nvim-lspconfig'
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts) require 'lsp_signature'.setup(opts) end
  },
  {
    "onsails/lspkind.nvim"
  },
  {
    "windwp/nvim-autopairs"
  },
  {
    "RaafatTurki/hex.nvim"
  },
  {
    "elkowar/yuck.vim"
  }
})

require('hex').setup()
