return {
  -- dashboard
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    opts = function()
      local dashboard = require("alpha.themes.dashboard")

      -- settings seed
      math.randomseed(os.time())
      local function pick_color()
        local colors = { "Keyword", "Constant", "Number", "Type", "String", "Special", "Function" }
        return colors[math.random(#colors)]
      end

      -- I have copied from below. thank you.
      -- https://github.com/goolord/alpha-nvim/discussions/16#discussioncomment-3099041
      local logo = [[
      　　　 　　/＾>》, -―‐‐＜＾},
      　　　 　./:::/,≠´::::::ヽ.,
      　　　　/::::〃::::／}::丿ハ,  ＿＿＿＿＿＿＿
      　　　./:::::i{l|／　ﾉ／ }::},/ %s \
      　　 /:::::::瓜イ＞　´＜ ,:ﾉ, \ Hello world! /
      　 ./::::::|ﾉﾍ.{､　(_ﾌ_ノﾉイ＿,|/‾‾‾‾‾‾‾‾‾‾‾
      　 |:::::::|／}｀ｽ /          /
      .　|::::::|(_:::つ/         /　Neovim!,
      .￣￣￣￣￣￣￣＼/＿＿＿＿＿/￣￣￣￣￣,
      ]]

      dashboard.section.header.val = vim.split(string.format(logo, os.date(" %Y/%m/%d")), "\n")
      dashboard.section.buttons.val = {
        dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
        dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
        dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
        dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
        dashboard.button("s", " " .. " Restore Session", [[:lua require("persistence").load() <cr>]]),
        dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
        dashboard.button("q", " " .. " Quit", ":qa<CR>"),
      }
      dashboard.section.footer.opts.hl = pick_color()
      dashboard.section.header.opts.hl = pick_color()
      dashboard.opts.layout[1].val = 8
      return dashboard
    end,
    config = function(_, dashboard)
      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "AlphaReady",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      require("alpha").setup(dashboard.opts)

      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },
}
