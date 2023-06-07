return {
  -- measure startuptime
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    event = "VeryLazy",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },
  -- -- editorconfig
  {
    "gpanders/editorconfig.nvim",
    event = "VeryLazy",
  },
  -- using tmux
  -- Enable pane move with ctrl+hjkl even when vim is running
  {
    "christoomey/vim-tmux-navigator",
    event = "VeryLazy",
  },
}
