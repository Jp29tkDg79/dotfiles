local list = {
  mapleader = " ", -- set leader key to space
  -- nvim tree settings
  loaded = 1,
  loaded_netrwPlugin = 1,
  mkdp_filetypes = { "markdown" },
}

for k, v in pairs(list) do
  vim.g[k] = v
end
