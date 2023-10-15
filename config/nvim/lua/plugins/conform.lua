return {
    "stevearc/conform.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                javascript = { "prettierd", "prettier" },
                typescript = { "prettierd", "prettier" },
                javascriptreact = { "prettierd", "prettier" },
                typescriptreact = { "prettierd", "prettier" },
                svelte = { "prettierd", "prettier" },
                css = { "prettierd", "prettier" },
                html = { "prettierd", "prettier" },
                json = { "prettierd", "prettier" },
                yaml = { "prettierd", "prettier" },
                markdown = { "prettierd", "prettier" },
                graphql = { "prettierd", "prettier" },
                lua = { "stylua" },
                python = { "isort", "black" },
                go = { "gofumpt", "goimports", "golines" },
                java = { "clang_format" },
            },
            format_on_save = {
                lsp_fallback = true,
                async = true,
                timeout_ms = 1000,
            },
        })

        vim.keymap.set({ "n", "v" }, "<leader>fp", function()
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 1000,
            })
        end, { desc = "Format file or range (in visual mode)" })
    end,
}
