-- Automatically load current file
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = "*",
  group = vim.api.nvim_create_augroup("AutoLoadCurrentFile", { clear = true }),
  callback = function()
    -- Does not apply to buffers whose file name cannot be determined
    if vim.api.nvim_buf_get_option(0, "filetype") then
      vim.cmd("checktime %")
    end
  end,
})

-- Restore Cursor Position
-- see: https://vim.fandom.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  pattern = "*",
  group = vim.api.nvim_create_augroup("RestoreCursorPosition", { clear = true }),
  callback = function()
    if vim.fn.line("'\"") <= vim.fn.line("$") then
      vim.cmd('normal! g`"')
    end
  end,
})

-- Show line diagnostics automatically in hover window
-- see : https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization
vim.api.nvim_create_autocmd({ "CursorHold" }, {
  buffer = bufnr,
  callback = function()
    local opts = {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = "rounded",
      source = "always",
      prefix = " ",
      scope = "cursor",
    }
    vim.diagnostic.open_float(nil, opts)
  end,
})