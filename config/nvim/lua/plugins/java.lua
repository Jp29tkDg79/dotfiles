return {
  {
    "mfussenegger/nvim-jdtls",
    event = { "BufReadPre", "BufNewFile" },
    ft = "java",
    dependencies = {
      "mason.nvim", -- Using jdtls install
      "cmp-nvim-lsp",
    },
    config = function()
      require("jdtls").setup_dap()
    end,
  },
}
