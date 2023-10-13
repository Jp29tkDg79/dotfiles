return {
    {
        "mfussenegger/nvim-jdtls",
        event = { "BufReadPre", "BufNewFile" },
        ft = "java",
        dependencies = {
            "mason.nvim", -- Using jdtls install
            "cmp-nvim-lsp",
            "mfussenegger/nvim-dap",
            "neovim/nvim-lspconfig",
        },
        config = function()
            require("jdtls").setup_dap()
        end,
    },
}
