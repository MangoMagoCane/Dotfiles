return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function ()
    local configs = require("nvim-treesitter.configs")
    configs.setup({
      auto_install = true,
      ensure_installed = {
        "vim", "vimdoc", "query", "cmake",
         "html", "css", "markdown", "tsx", "json", "xml", "yaml",
          "bash", "tmux", "sql",
          "javascript", "typescript", "lua", "python", "ruby",
          "c", "cpp",  "go", "zig", "odin", "rust", "java", "c_sharp"
      },
      sync_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end
}
