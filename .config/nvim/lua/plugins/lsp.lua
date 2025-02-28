return {
  {
    "tree-sitter/tree-sitter-embedded-template",
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        eruby = { "erb_format" },
      },
    },
  },
  -- {
  --   "saghen/blink.cmp",
  --   -- version = "v0.11.0",
  --   -- version = "v0.12.3",
  --   version = "*",
  --   ---@module 'blink.cmp'
  --   ---@type blink.cmp.Config
  -- },
  -- {
  --   "neovim/nvim-lspconfig",
  --   ---@class PluginLspOpts
  --   opts = {
  --     ---@type lspconfig.options
  --     servers = {
  --       clangd = {
  --         cmd = {
  --           "clang-format",
  --           "-style="{
  --         },
  --       },
  --     },
  --   },
  -- },
}
