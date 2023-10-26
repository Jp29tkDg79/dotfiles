return {
    -- snippets
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        build = vim.fn.has("win32") ~= 0 and "make install_jsregexp" or nil,
        event = "VeryLazy",
        dependencies = {
            "rafamadriz/friendly-snippets",
            -- lazy = true,
            -- config = function()
            --     require("luasnip.loaders.from_vscode").lazy_load()
            -- end,
        },
        opts = {
            history = true,
            delete_check_events = "TextChanged",
        },
        keys = {
            {
                "<tab>",
                function()
                    return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
                end,
                expr = true,
                silent = true,
                mode = "i",
            },
            {
                "<tab>",
                function()
                    require("luasnip").jump(1)
                end,
                mode = "s",
            },
            {
                "<s-tab>",
                function()
                    require("luasnip").jump(-1)
                end,
                mode = { "i", "s" },
            },
        },
        config = function(_, opts)
            local snip = require("luasnip")
            if opts then
                snip.config.setup(opts)
            end
            vim.tbl_map(function(type)
                require("luasnip.loaders.from_" .. type).lazy_load()
            end, { "vscode", "snipmate", "lua" })
            -- react
            snip.filetype_extend("typescript", { "javascript" })
            -- friendly-snippets - enable standardized comments snippets
            snip.filetype_extend("typescript", { "tsdoc" })
            snip.filetype_extend("javascript", { "jsdoc" })
            snip.filetype_extend("lua", { "luadoc" })
            snip.filetype_extend("python", { "pydoc" })
            snip.filetype_extend("rust", { "rustdoc" })
            snip.filetype_extend("cs", { "csharpdoc" })
            snip.filetype_extend("java", { "javadoc" })
            snip.filetype_extend("c", { "cdoc" })
            snip.filetype_extend("cpp", { "cppdoc" })
            snip.filetype_extend("php", { "phpdoc" })
            snip.filetype_extend("kotlin", { "kdoc" })
            snip.filetype_extend("ruby", { "rdoc" })
            snip.filetype_extend("sh", { "shelldoc" })
        end,
    },
    -- auto completion
    {
        "hrsh7th/nvim-cmp",
        version = false, -- last release is way too old
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            "onsails/lspkind.nvim",
            {
                "windwp/nvim-autopairs",
                lazy = true,
                opts = {
                    check_ts = true, -- enable treesitter
                    ts_config = {
                        lua = { "string" }, -- don't add pairs in lua string treesitter nodes
                        javascript = { "template_string" }, -- don't add pairs in javscript template_string treesitter nodes
                        java = false, -- don't check treesitter on java
                    },
                },
            },
        },
        opts = function()
            local cmp = require("cmp")
            return {
                completion = {
                    completeopt = "menu,menuone,noinsert",
                },
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
                    ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
                    ["<C-e>"] = cmp.mapping.abort(), -- close completion window
                    ["<CR>"] = cmp.mapping.confirm({ select = false }),
                }),
                -- sources for autocompletion
                sources = cmp.config.sources({
                    { name = "nvim_lsp" }, -- lsp
                    { name = "luasnip" }, -- snippets
                    { name = "buffer" }, -- text within current buffer
                    { name = "path" }, -- file system paths
                }),
                -- configure lspkind for vs-code like icons
                formatting = {
                    format = require("lspkind").cmp_format({
                        maxwidth = 50,
                        ellipsis_char = "...",
                    }),
                },
            }
        end,
        config = function(_, opts)
            local cmp = require("cmp")
            cmp.setup(opts)
            -- make autopairs and completion work together
            cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
        end,
    },
}
