---------------------
-- Custom settings
---------------------
local toggleterm = require("utils.toggleterm")
-- utils
local utl = require("utils.util")

-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

local M = {}

-- cancel insert mode
map("i", "jk", "<ESC>")

-- better up/down
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Resize window using <ctrl> arrow keys (alt + A)
map("n", "å", "<cmd>lua require('smart-splits').start_resize_mode()<cr>", { desc = "Start resize mode" })

-- Move Lines
if utl.isWin() then
  -- Using windows Alt key + j(down)/k(up)
  map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
  map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
  map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
  map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
  map("v", "<A-j>", "<cmd>m '>+1<cr>gv=gv", { desc = "Block move down" })
  map("v", "<A-k>", "<cmd>m '<-2<cr>gv=gv", { desc = "Block move up" })
elseif utl.isMac() or utl.isLinux() then
  -- Option + J/K
  -- ∆ == J
  -- ˚ == K
  -- see: https://stackoverflow.com/questions/7501092/can-i-map-alt-key-in-vim
  map("n", "∆", "<cmd>m .+1<cr>==", { desc = "Move down" })
  map("n", "˚", "<cmd>m .-2<cr>==", { desc = "Move up" })
  map("i", "∆", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
  map("i", "˚", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
  map("v", "∆", "<cmd>m '>+1<cr>gv=gv", { desc = "Block move down" })
  map("v", "˚", "<cmd>m '<-2<cr>gv=gv", { desc = "Block move up" })
end

-- window management
map("n", "<leader>wv", "<C-w>v", { desc = "Split window vertical" }) -- split window vertically
map("n", "<leader>wh", "<C-w>s", { desc = "Split window horizontal" }) -- split window horizontally
map("n", "<leader>we", "<C-w>=", { desc = "Make split window width & height" }) -- make split windows equal width & height
map("n", "<leader>wx", ":close<CR>", { desc = "Close window" }) -- close current split window

-- buffer
map("n", "<leader>to", "<cmd>tabnew | Alpha<cr>", { desc = "New buffer" }) -- open new tab
map("n", "<leader>tx", "<cmd>tabclose<cr>", { desc = "Close buffer" }) -- close current tab
map("n", "<leader>tn", "<cmd>tabn<cr>", { desc = "Next buffer" }) --  go to next tab
map("n", "<leader>tp", "<cmd>tabp<cr>", { desc = "Prev buffer" }) --  go to previous tab

-- nvim-tree
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>") -- toggle file explorer

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
map(
  "n",
  "<leader>ur",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / clear hlsearch / diff update" }
)

-- save file
map({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })
-- quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

---------------------
-- lspsaga
---------------------
map("n", "K", "<cmd>Lspsaga hover_doc<cr>", { desc = "Hover doc" })
map("n", "gf", "<cmd>Lspsaga lsp_finder<cr>", { desc = "Lsp finder" })
map("n", "gd", "<cmd>Lspsaga peek_definition<cr>", { desc = "Peek definition" })
map("n", "gd", "<cmd>Lspsaga goto_definition<cr>", { desc = "Goto definition" })
map("n", "gr", "<cmd>Lspsaga rename<cr>", { desc = "Saga find all rename" })
map("n", "go", "<cmd>Lspsaga outline<cr>", { desc = "Saga show outline" })
map("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<cr>", { desc = "Diagnostic jump prev" })
map("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<cr>", { desc = "Diagnostic jump next" })

---------------------
-- Toggleterm
---------------------
-- togglterm keymaping
M._set_terminal_keymaps = function()
  local opts = {}
  map("t", "<esc>", [[<C-\><C-n>]], opts)
  map("t", "jk", [[<C-\><C-n>]], opts)
  map("t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
  map("t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
  map("t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
  map("t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
end

-- general
map(
  "n",
  "<leader>tf",
  "<cmd>ToggleTerm direction=float<cr>",
  { noremap = true, silent = true, desc = "Show term float" }
)
map(
  "n",
  "<leader>th",
  "<cmd>ToggleTerm size=15 direction=horizontal<cr>",
  { noremap = true, silent = true, desc = "Show term horizontal" }
)
map(
  "n",
  "<leader>tv",
  "<cmd>ToggleTerm size=80 direction=vertical<cr>",
  { noremap = true, silent = true, desc = "Show term vertical" }
)
-- custom
map(
  "n",
  "<leader>tjs",
  toggleterm._nodejs_toggle,
  { noremap = true, silent = true, desc = "Use nodejs interactive mode" }
)
map(
  "n",
  "<leader>tpy",
  toggleterm._python_toggle,
  { noremap = true, silent = true, desc = "Use python interactive mode" }
)
map("n", "<leader>tlg", toggleterm._lazygit_toggle, { noremap = true, silent = true, desc = "Show lazygit" })
map("n", "<leader>tld", toggleterm._lazydocker_toggle, { noremap = true, silent = true, desc = "Show lazydocker" })

---------------------
-- markdown preview
---------------------
map("n", "<leader>mp", "<cmd>MarkdownPreview<cr>", { desc = "Start markdown preview" })
map("n", "<leader>mq", "<cmd>MarkdownPreviewStop<cr>", { desc = "Close markdown preview" })

---------------------
-- debugger keymap
---------------------
map("n", "<F5>", "<cmd>DapContinue<cr>", { silent = true, desc = "Dap continue" })
map("n", "<F10>", "<cmd>DapStepOver<cr>", { silent = true, desc = "Dap step over" })
map("n", "<F11>", "<cmd>DapStepInto<cr>", { silent = true, desc = "Dap step into" })
map("n", "<F12>", "<cmd>DapStepOut<cr>", { silent = true, desc = "Dap step out" })
map("n", "<leader>b", "<cmd>DapToggleBreakpoint<cr>", { silent = true, desc = "Dap toggle breakpoint" })

return M
