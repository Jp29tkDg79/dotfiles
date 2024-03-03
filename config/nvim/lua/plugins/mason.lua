return {
    -- mason settings
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        build = ":MasonUpdate", -- :MasonUpdate updates registry contents
        dependencies = "catppuccin",
        opts = {
            ensure_installed = {
                ---------------------
                -- Lsp
                ---------------------
                -- See below for installing only jdtls
                -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#jdtls
                -- Only install jdtls using mason. Other settings are done with nvim-jdtls
                "jdtls", -- java ------------------- formatter & linter ------------------- "prettier", -- ts/js formatter
                "stylua", -- lua formatter
                "eslint_d", -- ts/js linter
                "yamllint", -- yamllint
                "prettierd",
                -- python formatter & linter
                "flake8",
                "djlint",
                "isort",
                "black",
                -- docker
                "hadolint",
                -- golang
                "gofumpt",
                "goimports",
                "golines",
                "golangci-lint",
                "revive",
                "staticcheck",
                "templ",
                -- java
                "clang-format",
                -- shcellcheck
                "shellcheck",
                -- htmx
                "htmx-lsp",
                ---------------------
                -- dap
                ---------------------
                "debugpy", -- python
                "delve", -- Golang
                "codelldb", -- C && C++ && Rust
                "java-debug-adapter", -- java
            },
        },
        config = function(_, opts)
            require("mason").setup(opts)
            local mr = require("mason-registry")
            for _, tool in ipairs(opts.ensure_installed) do
                local p = mr.get_package(tool)
                if not p:is_installed() then
                    p:install()
                end
            end
        end,
    },
}
