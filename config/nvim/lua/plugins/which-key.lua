return {
    -- Which-key
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            plugins = { spelling = true },
            spec = {
                { "g", group = "goto" },
                { "gz", group = "surround" },
                { "<leader><tab>", group = "tabs" },
                { "<leader>t", group = "buffer/term" },
                { "<leader>c", group = "code" },
                { "<leader>f", group = "file/find/format" },
                { "<leader>l", group = "lint" },
                { "<leader>g", group = "git/saga" },
                { "<leader>m", group = "markdown" },
                { "<leader>q", group = "quit/session" },
                { "<leader>s", group = "search" },
                { "<leader>u", group = "ui" },
                { "<leader>w", group = "windows" },
                { "<leader>x", group = "diagnostics/quickfix" },
                { "<leader>gh", group = "hunks" },
            },
        },
    },
}
