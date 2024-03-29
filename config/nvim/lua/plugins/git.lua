return {
    {
        "NeogitOrg/neogit",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "sindrets/diffview.nvim",
                lazy = true,
                keys = {
                    { "<leader>ghd", "<cmd>DiffviewOpen<cr>", desc = "Open diffview open" },
                    { "<leader>ghh", "<cmd>DiffviewFileHistory<cr>", desc = "Open diffview history" },
                },
                opts = {
                    enhanced_diff_hl = true,
                    default_args = {
                        DiffviewOpen = { "--untracked-files=no", "--imply-local" },
                        DiffviewFileHistory = { "--base=LOCAL" },
                    },
                },
            },
        },
        opts = {
            kind = "vsplit",
            integrations = {
                -- using diffview plugin
                diffview = true,
            },
        },
        keys = {
            { "<leader>gn", "<cmd>Neogit<cr>", desc = "Open neogit" },
        },
        config = function(_, opts)
            require("neogit").setup(opts)
            -- vim.cmd([[hi def NeogitDiffAddHighlight guibg=#404040 guifg=#859900]])
            -- vim.cmd([[hi def NeogitDiffDeleteHighlight guibg=#404040 guifg=#dc322f]])
            -- vim.cmd([[hi def NeogitDiffContextHighlight guibg=#333333 guifg=#b2b2b2]])
            -- vim.cmd([[hi def NeogitHunkHeader guifg=#cccccc guibg=#404040]])
            -- vim.cmd([[hi def NeogitHunkHeaderHighlight guifg=#cccccc guibg=#4d4d4d]])
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = "catppuccin",
        opts = {
            signs = {
                add = { text = "│" },
                change = { text = "│" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
                untracked = { text = "┆" },
            },
            watch_gitdir = {
                interval = 1000,
                follow_files = true,
            },
            attach_to_untracked = true,
            current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
                delay = 1000,
                ignore_whitespace = false,
            },
            current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
            on_attach = function(buffer)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, desc)
                    vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
                end
                map("n", "]h", gs.next_hunk, "Next Hunk")
                map("n", "[h", gs.prev_hunk, "Prev Hunk")
                map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
                map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
                map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
                map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
                map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
                map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
                map("n", "<leader>ghb", function()
                    gs.blame_line({ full = true })
                end, "Blame Line")
                map("n", "<leader>ghq", ":Gitsigns setqflist", "Set quickfix")
                map("n", "<leader>ghl", ":Gitsigns seqloclist", "Set loclist")
            end,
        },
        config = function(_, opts)
            require("gitsigns").setup(opts)
        end,
    },
}
