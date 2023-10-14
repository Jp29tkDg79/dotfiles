return {
    -- catppuccin
    {
        "catppuccin/nvim",
        lazy = true, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        name = "catppuccin",
        opts = {
            transparent_background = true,
            integrations = {
                cmp = true,
                gitsigns = true,
                treesitter = true,
                notify = false,
                alpha = true,
                indent_blankline = {
                    enabled = true,
                    scope_color = "", -- catppuccin color (eg. `lavender`) Default: text
                    colored_indent_levels = true,
                },
                lsp_saga = true,
                native_lsp = {
                    enabled = true,
                    virtual_text = {
                        errors = { "italic" },
                        hints = { "italic" },
                        warnings = { "italic" },
                        information = { "italic" },
                    },
                    underlines = {
                        errors = { "underline" },
                        hints = { "underline" },
                        warnings = { "underline" },
                        information = { "underline" },
                    },
                    inlay_hints = {
                        background = true,
                    },
                },
                mason = true,
                neogit = true,
                nvimtree = true,
                ufo = true,
                lsp_trouble = true,
                telescope = {
                    enabled = true,
                    -- style = "nvchad"
                },
                which_key = true,
            },
        },
        config = function(_, opts)
            require("catppuccin").setup(opts)
            vim.cmd("colorscheme catppuccin")
        end,
    },
}
