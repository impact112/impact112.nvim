local util = require("formatter.util")

require("formatter").setup {
  logging = true,
  log_level = vim.log.levels.WARN,
  filetype = {
    lua = {
      require("formatter.filetypes.lua").stylua,
      function()
        if util.get_current_buffer_file_name() == "special.lua" then
          return nil
        end
        return {
          exe = "stylua",
          args = {
            "--search-parent-directories",
            "--stdin-filepath",
            util.escape_path(util.get_current_buffer_file_path()),
            "--",
            "-",
          },
          stdin = true,
        }
      end
    },
    python = {
      function()
        return {
          exe = "black",
          args = { util.escape_path(util.get_current_buffer_file_path()) },
          stdin = false,
        }
      end
    },
    html = {
      function()
        return {
          exe = "prettier",
          args = { "--parser", "html", "--write", util.escape_path(util.get_current_buffer_file_path()) },
          stdin = false,
        }
      end
    },
    javascript = {
      function()
        return {
          exe = "prettier",
          args = { "--parser", "babel", "--write", util.escape_path(util.get_current_buffer_file_path()) },
          stdin = false,
        }
      end
    },
    css = {
      function()
        return {
          exe = "prettier",
          args = { "--parser", "css", "--write", util.escape_path(util.get_current_buffer_file_path()) },
          stdin = false,
        }
      end
    },
    ["*"] = {
      require("formatter.filetypes.any").remove_trailing_whitespace
    }
  }
}
