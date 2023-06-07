return {
  {
    "nvim-tree/nvim-tree.lua",
    event = "VeryLazy",
    opts = {
      -- change folder arrow i--[[ cons ]]
      renderer = {
        add_trailing = true,
        highlight_git = true,
        icons = {
          glyphs = {
            folder = {
              arrow_closed = "", -- arrow when folder is closed
              arrow_open = "", -- arrow when folder is open
            },
          },
        },
        indent_width = 2,
        indent_markers = {
          enable = true,
          inline_arrows = true,
          icons = {
            corner = "└",
            edge = "│",
            item = "│",
            bottom = "─",
            none = " ",
          },
        },
      },
      -- disable window_picker for
      -- explorer to work well with
      -- window splits
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },
      -- filters = {
      -- 	custom = { "^\\.git" },
      -- },
      git = {
        enable = true,
        ignore = true,
      },
      view = {
        number = true,
      },
    },
    config = function(_, opts)
      require("nvim-tree").setup(opts)
    end,
  }
}
