return {
  {
    "mrjones2014/smart-splits.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-notify",
    },
    opts = {
      -- Ignored buffer types (only while resizing)
      ignored_buftypes = { "NvimTree" },
      -- resize mode options
      resize_mode = {
        -- key to exit persistent resize mode
        quit_key = "q",
        -- keys to use for moving in resize mode
        -- in order of left, down, up' right
        resize_keys = { "h", "j", "k", "l" },
        -- set to true to silence the notifications
        -- when entering/exiting persistent resize mode
        silent = true,
        -- must be functions, they will be executed when
        -- entering or exiting the resize mode
        hooks = {
          on_enter = function()
            vim.notify("Entering resize mode")
          end,
          on_leave = function()
            vim.notify("Exiting resize mode, bye")
          end,
        },
      },
      -- enable or disable the tmux integration
      tmux_integration = false,
    },
  },
}
