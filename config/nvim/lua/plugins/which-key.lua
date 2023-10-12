return {
    -- Which-key
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            plugins = { spelling = true },
        },
        config = function(_, opts)
            local wk = require("which-key")
            wk.setup(opts)
            local keymaps = {
                mode = { "n", "v" },
                ["g"] = { name = "+goto" },
                ["gz"] = { name = "+surround" },
                ["]"] = { name = "+next" },
                ["["] = { name = "+prev" },
                ["<leader><tab>"] = { name = "+tabs" },
                ["<leader>t"] = { name = "+buffer/term" },
                ["<leader>c"] = { name = "+code" },
                ["<leader>f"] = { name = "+file/find/format" },
                ["<leader>l"] = { name = "+lint" },
                ["<leader>g"] = { name = "+git/saga" },
                ["<leader>m"] = { name = "+markdown" },
                ["<leader>q"] = { name = "+quit/session" },
                ["<leader>s"] = { name = "+search" },
                ["<leader>u"] = { name = "+ui" },
                ["<leader>w"] = { name = "+windows" },
                ["<leader>x"] = { name = "+diagnostics/quickfix" },
                ["<leader>gh"] = { name = "+hunks" },
            }
            wk.register(keymaps)
        end,
    },
}
