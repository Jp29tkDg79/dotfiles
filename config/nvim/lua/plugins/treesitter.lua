return {
    {
        "nvim-treesitter/nvim-treesitter",
        version = false, -- last release is way too old and doesn't work on Windows
        build = ":TSUpdate",
        event = "VeryLazy",
        keys = {
            { "<c-space>", desc = "Increment selection" },
            { "<bs>", desc = "Decrement selection", mode = "x" },
        },
        dependencies = {
            "windwp/nvim-ts-autotag",
            {
                "nvim-treesitter/nvim-treesitter-textobjects",
                config = function()
                    -- When in diff mode, we want to use the default
                    -- vim text objects c & C instead of the treesitter ones.
                    local move = require("nvim-treesitter.textobjects.move") ---@type table<string,fun(...)>
                    local configs = require("nvim-treesitter.configs")
                    for name, fn in pairs(move) do
                        if name:find("goto") == 1 then
                            move[name] = function(q, ...)
                                if vim.wo.diff then
                                    local config = configs.get_module("textobjects.move")[name] ---@type table<string,string>
                                    for key, query in pairs(config or {}) do
                                        if q == query and key:find("[%]%[][cC]") then
                                            vim.cmd("normal! " .. key)
                                            return
                                        end
                                    end
                                end
                                return fn(q, ...)
                            end
                        end
                    end
                end,
            },
        },
        opts = {
            -- enable syntax highlighting
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = true,
            },
            -- enable indentation
            indent = { enable = true },
            -- enable autotagging (w/ nvim-ts-autotag plugin)
            autotag = { enable = true },
            matchup = { enable = true },
            autopairs = { enable = true },
            rainbow = {
                enable = true,
                extended_mode = true, -- Highlight also non-parentheses delimiters
                max_file_lines = 1000,
            },
            -- ensure these language parsers are installed
            ensure_installed = {
                "json",
                "javascript",
                "typescript",
                "tsx",
                "yaml",
                "html",
                "css",
                "markdown",
                "markdown_inline",
                "svelte",
                "graphql",
                "bash",
                "lua",
                "vim",
                "dockerfile",
                "gitignore",
                "go",
                "gomod",
                "gosum",
                "gowork",
                "python",
                "java",
                "rust",
            },
            -- auto install above language parsers
            auto_install = true,
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },
            },
            textobjects = {
                swap = {
                    enable = true,
                    swap_next = {
                        ["<leader>na"] = "@parameter.inner", -- swap parameters/argument with next
                        ["<leader>n:"] = "@property.outer", -- swap object property with next
                        ["<leader>nm"] = "@function.outer", -- swap function with next
                    },
                    swap_previous = {
                        ["<leader>pa"] = "@parameter.inner", -- swap parameters/argument with prev
                        ["<leader>p:"] = "@property.outer", -- swap object property with prev
                        ["<leader>pm"] = "@function.outer", -- swap function with previous
                    },
                },
                move = {
                    enable = true,
                    goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
                    goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
                    goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
                    goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
                },
            },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
            local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
            parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }

            local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

            -- vim way: ; goes to the direction you were moving.
            vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
            vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

            -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
            vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
            vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
            vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
            vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)
        end,
    },
}
