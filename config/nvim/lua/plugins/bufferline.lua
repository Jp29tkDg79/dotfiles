return {
    {
        "akinsho/bufferline.nvim",
        event = "VeryLazy",
        opts = {
            options = {
                mode = "tabs",
                always_show_bufferline = true,
                show_buffer_close_icons = true,
                show_close_icon = false,
                color_icons = true,
                diagnostics = "nvim_lsp",
                diagnostics_indicator = function(count, level)
                    local icon = level:match("error") and " " or " "
                    return " " .. icon .. count
                end,
                diagnostics_update_in_insert = false,
                offsets = {
                    {
                        filetype = "NvimTree",
                        text = " File Explorer(NvimTree)",
                        text_align = "left",
                        separator = true,
                    },
                },
            },
        },
    },
}
