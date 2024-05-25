local ftMap = {
    vim = "indent",
    python = { "indent" },
    git = "",
}

local handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = (" 󰁂 %d "):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
        else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
        end
        curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, { suffix, "MoreMsg" })
    return newVirtText
end

return {
    {
        "kevinhwang91/nvim-ufo",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            {
                "kevinhwang91/promise-async",
            },
            "nvim-treesitter",
            {
                "luukvbaal/statuscol.nvim",
                config = function()
                    local builtin = require("statuscol.builtin")
                    require("statuscol").setup({
                        relculright = true,
                        segments = {
                            { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
                            { text = { "%s" }, click = "v:lua.ScSa" },
                            { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
                        },
                    })
                end,
            },
        },
        keys = {
            { "zR", "<cmd>require('ufo').openAllFolds<cr>", desc = "Open all folds" },
            { "zM", "<cmd>require('ufo').closeAllFolds<cr>", desc = "Close all folds" },
            { "zr", "<cmd>require('ufo').openFoldsExceptKinds<cr>", desc = "Open fold except kinds" },
            { "zm", "<cmd>require('ufo').closeFoldsWith<cr>", desc = "Close fold with" },
            {
                "zp",
                function()
                    local winid = require("ufo").peekFoldedLinesUnderCursor()
                    if not winid then
                        vim.lsp.buf.hover()
                    end
                end,
                desc = "Show peek fold preview under cursor",
            },
        },
        opts = {
            open_fold_hl_timeout = 150,
            close_fold_kinds_for_ft = {
                default = { "imports", "comment" },
                json = { "array" },
                c = { "comment", "region" },
            },
            preview = {
                win_config = {
                    border = { "", "─", "", "", "", "─", "", "" },
                    winhighlight = "Normal:Folded",
                    winblend = 0,
                },
                mappings = {
                    scrollU = "<C-u>",
                    scrollD = "<C-d>",
                    jumpTop = "[z",
                    jumpBot = "]z",
                    switch = "<tab>",
                    close = "q",
                },
            },
            provider_selector = function(bufnr, filetype, buftype)
                ---@param bufnr number
                ---@return Promise
                local function customizeSelector(bufnr)
                    local function handleFallbackException(err, providerName)
                        if type(err) == "string" and err:match("UfoFallbackException") then
                            return require("ufo").getFolds(bufnr, providerName)
                        else
                            return require("promise").reject(err)
                        end
                    end

                    return require("ufo")
                        .getFolds(bufnr, "lsp")
                        :catch(function(err)
                            return handleFallbackException(err, "treesitter")
                        end)
                        :catch(function(err)
                            return handleFallbackException(err, "indent")
                        end)
                end
                return ftMap[filetype] or customizeSelector
            end,
            enable_get_fold_virt_text = true,
            fold_virt_text_handler = handler,
        },
        config = function(_, opts)
            local ufo = require("ufo")
            ufo.setup(opts)
        end,
    },
}
