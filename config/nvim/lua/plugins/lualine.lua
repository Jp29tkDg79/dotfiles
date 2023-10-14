return {
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = function()
            -- local themes = require("lualine.themes.codedark")
            local higlight_colors = require("lualine.utils.utils").extract_highlight_colors
            require("lualine").setup({
                options = {
                    icons_enabled = true,
                    theme = "catppuccin",
                    section_separators = { left = "", right = "" },
                    component_separators = { left = "", right = "" },
                    lobalstatus = true,
                    disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" } },
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = {
                        "branch",
                        {
                            "diff",
                            colored = true, -- Displays a colored diff status if set to true
                            diff_color = {
                                -- Same color values as the general color option can be used here.
                                added = { fg = higlight_colors("OcGreen", "fg") }, -- Changes the diff's added color
                                modified = { fg = higlight_colors("OcBlue", "fg") }, -- Changes the diff's modified color
                                removed = { fg = higlight_colors("OcRed", "fg") }, -- Changes the diff's removed color you
                            },
                            symbols = { added = "+", modified = "~", removed = "-" }, -- Changes the symbols used by the diff.
                            source = nil, -- A function that works as a data source for diff.
                            -- It must return a table as such:
                            --   { added = add_count, modified = modified_count, removed = removed_count }
                            -- or nil on failure. count <= 0 won't be displayed.
                        },
                    },
                    lualine_c = {
                        {
                            "filename",
                            file_status = true, -- displays file status (readonly status, modified status)
                            path = 0, -- 0 = just filename, 1 = relative path, 2 = absolute path
                        },
                    },
                    lualine_x = {
                        {
                            "diagnostics",
                            sources = { "nvim_diagnostic" },
                            symbols = { error = " ", warn = " ", info = " ", hint = " " },
                        },
                        "encoding",
                        "filetype",
                    },
                    lualine_y = {
                        { "progress", separator = " ", padding = { left = 1, right = 0 } },
                        { "location", padding = { left = 0, right = 1 } },
                    },
                    lualine_z = {
                        function()
                            return " " .. os.date("%R")
                        end,
                    },
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {
                        {
                            "filename",
                            file_status = true, -- displays file status (readonly status, modified status)
                            path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
                        },
                    },
                    lualine_x = { "location" },
                    lualine_y = {},
                    lualine_z = {},
                },
                tabline = {},
                extensions = { "nvim-dap-ui", "nvim-tree" },
            })
        end,
    },
}
