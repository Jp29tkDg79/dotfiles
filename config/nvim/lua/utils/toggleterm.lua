local Terminal = require("toggleterm.terminal").Terminal

local M = {}

local on_open = function(term)
  vim.cmd("startinsert!")
  vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
end

local on_close = function(term)
  vim.cmd("startinsert!")
end

---------------------
-- lazygit
---------------------
local lazygit = Terminal:new({
  cmd = "lazygit",
  dir = "git_dir",
  direction = "float",
  float_opts = {
    border = "double",
  },
  on_open = on_open,
  on_close = on_close,
})

---------------------
-- lazydocker
---------------------
local lazydocker = Terminal:new({
  cmd = "lazydocker",
  direction = "float",
  float_opts = {
    border = "double",
  },
  on_open = on_open,
  on_close = on_close,
})

M._lazygit_toggle = function()
  lazygit:toggle()
end

M._lazydocker_toggle = function()
  lazydocker:toggle()
end

return M
