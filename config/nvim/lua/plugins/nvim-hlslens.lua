local kopts = { noremap = true, silent = true }

-- using nvim-ufo is fold scope
-- The lens has been adapted to the folds of nvim-ufo, still need remap n and N action if you want to peek at folded lines.
-- if Neovim is 0.8.0 before, remap yourself.
local function nN(char)
  local ok, winid = require("hlslens").nNPeekWithUFO(char)
  if ok and winid then
    -- Safe to override buffer scope keymaps remapped by ufo,
    -- ufo will restore previous buffer keymaps before closing preview window
    -- Type <CR> will switch to preview window and fire `trace` action
    vim.keymap.set("n", "<CR>", function()
      local keyCodes = vim.api.nvim_replace_termcodes("<Tab><CR>", true, false, true)
      vim.api.nvim_feedkeys(keyCodes, "im", false)
    end, { buffer = true })
  end
end

return {
  {
    "kevinhwang91/nvim-hlslens",
    event = "VeryLazy",
    keys = {
      {
        "n",
        function()
          nN("n")
        end,
        mode = { "n", "x" },
        kopts,
      },
      {
        "N",
        function()
          nN("N")
        end,
        mode = { "n", "x" },
        kopts,
      },
      {
        "*",
        [[*<Cmd>lua require('hlslens').start()<CR>]],
        kopts,
      },
      {
        "#",
        [[#<Cmd>lua require('hlslens').start()<CR>]],
        kopts,
      },
      {
        "g*",
        [[g*<Cmd>lua require('hlslens').start()<CR>]],
        kopts,
      },
      {
        "g#",
        [[g#<Cmd>lua require('hlslens').start()<CR>]],
        kopts,
      },
      {
        "<leader>sL",
        function()
          vim.schedule(function()
            if require("hlslens").exportLastSearchToQuickfix() then
              vim.cmd("cw")
            end
          end)
          return ":noh<CR>"
        end,
        mode = { "n", "x" },
        { expr = true, desc = "Last search to quickfix" },
      },
    },
    config = function()
      require("hlslens").setup()
    end,
  },
}
