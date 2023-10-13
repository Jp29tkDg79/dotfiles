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
-- nodejs
---------------------
local nodejs = Terminal:new({
    cmd = "node",
    float_opts = {
        border = "double",
    },
    on_open = on_open,
    on_close = on_close,
})

---------------------
-- python
---------------------
local python = Terminal:new({
    cmd = "python",
    float_opts = {
        border = "double",
    },
    on_open = on_open,
    on_close = on_close,
})

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

M._nodejs_toggle = function()
    nodejs:toggle()
end

M._python_toggle = function()
    python:toggle()
end

M._lazygit_toggle = function()
    lazygit:toggle()
end

M._lazydocker_toggle = function()
    lazydocker:toggle()
end

return M
