return {
    "stevearc/conform.nvim",
    -- lazy = true,
    event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
    cmd = { "ConformInfo" },
    keys = {
        {
            -- Customize or remove this keymap to your liking
            "<leader>fp",
            function()
                require("conform").format({
                    lsp_fallback = true,
                    async = false,
                    timeout_ms = 1000,
                })
            end,
            mode = { "n", "v" },
            desc = "Format file or range (in visual mode)",
        },
    },
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                javascript = { { "prettierd", "prettier" } },
                typescript = { { "prettierd", "prettier" } },
                javascriptreact = { { "prettierd", "prettier" } },
                typescriptreact = { { "prettierd", "prettier" } },
                svelte = { { "prettierd", "prettier" } },
                css = { { "prettierd", "prettier" } },
                html = { { "prettierd", "prettier" } },
                json = { { "prettierd", "prettier" } },
                yaml = { { "prettierd", "prettier" } },
                markdown = { { "prettierd", "prettier" } },
                graphql = { { "prettierd", "prettier" } },
                lua = { "stylua" },
                python = { "isort", "black" },
                go = { "gofumpt", "goimports", "golines" },
                java = { "clang_format" },
            },
            log_level = vim.log.levels.DEBUG,
            format_on_save = {
                lsp_fallback = true,
                async = true,
                timeout_ms = 10000,
            },
            -- Customize formatters
            formatters = {
                shfmt = {
                    prepend_args = { "-i", "2" },
                },
            },
        })
    end,
}
