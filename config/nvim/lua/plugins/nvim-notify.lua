return {
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    lazy = true,
    opts = {
      stages = "fade_in_slide_out",
      background_colour = "FloatShadow",
      timeout = 3000,
    },
    init = function()
      vim.schedule(function()
        vim.notify = require("notify")
        -- Install custom notify function(LSP & DAP)
        for _, v in pairs(require("utils.util").get_lua_files("config")) do
          require(v)
        end
      end, 500)
    end,
  },
}
