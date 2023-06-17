local on_attach = require("utils.lsp").on_attach

local hl = vim.api.nvim_set_hl
local sign = vim.fn.sign_define

-- DAP color settings
hl(0, "DapBreakpoint", { ctermbg = 0, fg = "#993939", bg = "#31353f", bold = false })
hl(0, "DapLogPoint", { ctermbg = 0, fg = "#61afef", bg = "#31353f", bold = false })
hl(0, "DapStopped", { ctermbg = 0, fg = "#98c379", bg = "#31353f", bold = false })

sign("DapBreakpoint", { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" })
sign(
  "DapBreakpointCondition",
  { text = "ﳁ", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
)
sign(
  "DapBreakpointRejected",
  { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
)
sign("DapLogPoint", { text = "", texthl = "DapLogPoint", linehl = "DapLogPoint", numhl = "DapLogPoint" })
sign("DapStopped", { text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" })

return {
  -- Lspconfig settings
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason.nvim",
      "ray-x/lsp_signature.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      {
        "glepnir/lspsaga.nvim",
        config = function()
          require("lspsaga").setup()
        end,
      },
    },
    opts = {
      -- options for vim.diagnostic.config()
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = { spacing = 4, prefix = "●" },
        severity_sort = true,
      },
      -- LSP Server settings
      servers = {
        ---------------------
        -- Lua
        ---------------------
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
              },
              workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },
        ---------------------
        -- JSON
        ---------------------
        jsonls = {},
        ---------------------
        -- YAML & k8s
        ---------------------
        yamlls = {},
        ---------------------
        -- HTML
        ---------------------
        html = {},
        ---------------------
        -- emmet_ls
        ---------------------
        emmet_ls = {},
        ---------------------
        -- Js & ts
        ---------------------
        tsserver = {
          filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
          cmd = { "typescript-language-server", "--stdio" },
        },
        ---------------------
        -- Tailwind CSS
        ---------------------
        tailwindcss = {},
        ---------------------
        -- CSS
        ---------------------
        cssls = {},
        ---------------------
        -- Website build tool
        ---------------------
        astro = {},
        ---------------------
        -- Golang
        ---------------------
        gopls = {
          settings = {
            gopls = {
              analyses = {
                unusedparams = true,
              },
              staticcheck = true,
            },
          },
        },
        ---------------------
        -- Python
        ---------------------
        pyright = {
          settings = {
            python = {
              -- using vertual python
              venvPath = "./.venv/bin/python",
              venv = "env",
              analysis = {
                extraPaths = { "." },
              },
            },
          },
        },
        ---------------------
        -- Rust
        ---------------------
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              imports = {
                granularity = {
                  group = "module",
                },
                prefix = "self",
              },
              cargo = {
                buildScripts = {
                  enable = true,
                },
              },
              procMacro = {
                enable = true,
              },
            },
          },
        },
      },
    },
    config = function(_, opts)
      -- diagnostics
      for name, icon in pairs({ Error = " ", Warn = " ", Hint = " ", Info = " " }) do
        name = "DiagnosticSign" .. name
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
      end
      vim.diagnostic.config(opts.diagnostics)
      local servers = opts.servers
      local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
      -- Lsp fold settings
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }

      local function setup(server)
        local server_opts = vim.tbl_deep_extend("force", {
          on_attach = on_attach,
          capabilities = vim.deepcopy(capabilities),
        }, servers[server] or {})
        require("lspconfig")[server].setup(server_opts)
      end

      local mlsp = require("mason-lspconfig")
      local available = mlsp.get_available_servers()
      local ensure_installed = {} ---@type string[]
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
          if server_opts.mason == false or not vim.tbl_contains(available, server) then
            setup(server)
          else
            ensure_installed[#ensure_installed + 1] = server
          end
        end
      end

      mlsp.setup({ ensure_installed = ensure_installed })
      mlsp.setup_handlers({ setup })
    end,
  },
  -- mason settings
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate", -- :MasonUpdate updates registry contents
    opts = {
      ensure_installed = {
        ---------------------
        -- Lsp
        ---------------------
        -- See below for installing only jdtls
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#jdtls
        -- Only install jdtls using mason. Other settings are done with nvim-jdtls
        "jdtls", -- java
        ---------------------
        -- formatter & linter
        ---------------------
        "prettier", -- ts/js formatter
        "stylua", -- lua formatter
        "eslint_d", -- ts/js linter
        "yamllint", -- yamllint
        -- python formatter & linter
        "autopep8",
        "flake8",
        "djlint",
        -- golang
        "gofumpt",
        "goimports",
        "goimports-reviser",
        "golangci-lint",
        "golines",
        "revive",
        "staticcheck",
        -- java
        "clang-format",
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
  -- null-ls: formatters & linter
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason.nvim",
    },
    opts = function()
      local nls = require("null-ls")
      local formatting = nls.builtins.formatting -- to setup formatters
      local diagnostics = nls.builtins.diagnostics -- to setup linters
      -- to setup format on save
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      return {
        sources = {
          -- See the link below to install other formatter and linter
          -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
          -- formatting.prettier, -- js/ts formatter
          formatting.prettier.with({
            condition = function(utils)
              return utils.has_file(".prettierrc", ".prettier.js", ".prettier.json")
            end,
          }),
          formatting.stylua, -- lua formatter
          diagnostics.yamllint, -- yamllint
          diagnostics.eslint_d.with({ -- js/ts linter
            -- only enable eslint if root has .eslintrc.js (not in youtube nvim video)
            condition = function(utils)
              return utils.root_has_file(".eslintrc.js", ".eslint.json", ".eslint.yml", ".eslint.yaml") -- change file extension if you use something else
            end,
          }),
          -- python formatter & linter
          formatting.autopep8,
          diagnostics.flake8,
          -- django html
          formatting.djlint,
          diagnostics.djlint,
          -- golang formatter & linter
          formatting.gofumpt,
          formatting.goimports,
          formatting.goimports_reviser,
          formatting.golines,
          diagnostics.golangci_lint,
          diagnostics.revive,
          diagnostics.staticcheck,
          -- java
          formatting.clang_format,
        },
        -- configure format on save
        on_attach = function(current_client, bufnr)
          if current_client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({
                  filter = function(client)
                    --  only use null-ls for formatting instead of lsp server
                    return client.name == "null-ls"
                  end,
                  bufnr = bufnr,
                })
              end,
            })
          end
        end,
      }
    end,
  },
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
      -- If you want to add settings, please refer to the path below
      -- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#Python
      local venv = os.getenv("VIRTUAL_ENV") or ""
      local cmd = "/usr/bin/python3" -- default using local python3
      if venv ~= "" then
        cmd = venv .. "/bin/python"
      end

      dap.adapters.python = {

        type = "executable",
        command = cmd,
        args = { "-m", "debugpy.adapter" },
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
          command = mcp.bin_prefix("delve"),
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
        detached = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1,
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
