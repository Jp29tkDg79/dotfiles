local hl = vim.api.nvim_set_hl
local sign = vim.fn.sign_define

-- DAP color settings
hl(0, "DapBreakpoint", { ctermbg = 0, fg = "#993939", bg = "#31353f", bold = false })
hl(0, "DapLogPoint", { ctermbg = 0, fg = "#61afef", bg = "#31353f", bold = false })
hl(0, "DapStopped", { ctermbg = 0, fg = "#98c379", bg = "#31353f", bold = false })

sign("DapBreakpoint", { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" })
sign(
    "DapBreakpointCondition",
    { text = "󰁖", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
)
sign(
    "DapBreakpointRejected",
    { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
)
sign("DapLogPoint", { text = "", texthl = "DapLogPoint", linehl = "DapLogPoint", numhl = "DapLogPoint" })
sign("DapStopped", { text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" })

return {
    -- Debug Adapter Protocol(DAP)
    {
        "mfussenegger/nvim-dap",
        event = "VeryLazy",
        dependencies = {
            "mason.nvim",
        },
        config = function()
            local dap = require("dap")
            local mcp = require("mason-core.path")

            -------------------------
            -- Python
            -------------------------
            -- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#Python
            -- TODO: what if using python in a virtual env ?
            dap.adapters.python = {
                type = "executable",
                command = mcp.package_prefix("debugpy") .. "/venv/bin/python",
                args = { "-m", "debugpy.adapter" },
                options = {
                    source_filetype = "python",
                },
            }
            dap.configurations.python = {
                {
                    -- The first three options are required by nvim-dap
                    type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
                    request = "launch",
                    name = "Launch file",
                    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

                    program = "${file}", -- This configuration will launch the current file if used.
                },
            }

            -------------------------
            -- Golang
            -------------------------
            dap.adapters.delve = {
                type = "server",
                port = "${port}",
                executable = {
                    command = "dlv",
                    args = { "dap", "-l", "127.0.0.1:${port}" },
                },
            }
            -- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
            dap.configurations.go = {
                {
                    type = "delve",
                    name = "Debug",
                    request = "launch",
                    program = "${file}",
                },
                {
                    type = "delve",
                    name = "Debug test", -- configuration for debugging test files
                    request = "launch",
                    mode = "test",
                    program = "${file}",
                },
                -- works with go.mod packages and sub packages
                {
                    type = "delve",
                    name = "Debug test (go.mod)",
                    request = "launch",
                    mode = "test",
                    program = "./${relativeFileDirname}",
                },
            }

            -------------------------
            -- C & C++ & Rust
            -------------------------
            dap.adapters.lldb = {
                type = "server",
                port = "${port}",
                executable = {
                    command = mcp.bin_prefix("codelldb"),
                    args = { "--port", "${port}" },
                },
                -- On windows you may have to uncomment this:
                -- detached = vim.fn.has("win33") == 1 or vim.fn.has("win64") == 1,
                detached = require("utils.util").isWin(),
            }
            dap.configurations.cpp = {
                {
                    name = "Launch file",
                    type = "codelldb",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                },
            }
            -- C && Rust
            dap.configurations.c = dap.configurations.cpp
            dap.configurations.rust = dap.configurations.cpp
        end,
    },
}
