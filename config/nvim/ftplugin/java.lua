local status, jdtls = pcall(require, "jdtls")
if not status then
  vim.notify("jdtls not found. install with `:LspInstall jdtls`")
  return
end

-- Custom lsp on_attach function
local on_attach = require("utils.lsp").on_attach

-- Load mason registry
local mr = require("mason-registry")
-- Installation location of jdtls by mason
local JDTLS_LOCATION = mr.get_package("jdtls"):get_install_path()
-- Installation location of java-debug-adapter by mason
local JAVA_DEBUG_ADAPTER_LOCATION = mr.get_package("java-debug-adapter"):get_install_path()

-- Data directory - change it to your liking
local HOME = os.getenv("HOME")
local WORKSPACE_PATH = HOME .. "/workspace/java/"

local SYSTEM = ""
if vim.fn.has("mac") then
  SYSTEM = "mac"
elseif vim.fn.has("linux") then
  SYSTEM = "linux"
else
  SYSTEM = "win"
end

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = WORKSPACE_PATH .. project_name

local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = jdtls.setup.find_root(root_markers)
if root_dir == "" then
  return
end

local config = {
  cmd = {
    "java",
    "-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=1044",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xms1g",
    "-Xmx2G",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "-jar",
    vim.fn.glob(JDTLS_LOCATION .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
    "-configuration",
    JDTLS_LOCATION .. "/config_" .. SYSTEM,
    "-data",
    workspace_dir,
  },
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
  root_dir = root_dir,

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = "interactive",
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      -- If you want to use google-style.xml file please uncomment
      -- also please copy and use the latest xml file from the link below
      -- https://github.com/google/styleguide/blob/gh-pages/intellij-java-google-style.xml
      -- format = {
      --   enabled = true,
      --   settings = {
      --     url = vim.fn.stdpath("config") .. "/lang-servers/intellij-java-google-style.xml",
      --     profile = "GoogleStyle",
      --   },
      -- },
    },
    signatureHelp = { enabled = true },
    completion = {
      favoriteStaticMembers = {
        "org.hamcrest.MatcherAssert.assertThat",
        "org.hamcrest.Matchers.*",
        "org.hamcrest.CoreMatchers.*",
        "org.junit.jupiter.api.Assertions.*",
        "java.util.Objects.requireNonNull",
        "java.util.Objects.requireNonNullElse",
        "org.mockito.Mockito.*",
      },
    },
    contentProvider = { preferred = "fernflower" },
    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
    codeGeneration = {
      toString = {
        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
      },
      useBlocks = true,
    },
  },

  flags = {
    allow_incremental_sync = true,
  },
  -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
  init_options = {
    bundles = {
      vim.fn.glob(JAVA_DEBUG_ADAPTER_LOCATION .. "/extension/server/*.jar"),
    },
    extendedClientCapabilities = {
      -- Hide notifications
      progressReportProvider = true,
      resolveAdditionalTextEditsSupport = true,
    },
  },
  on_attach = on_attach,
}

jdtls.start_or_attach(config)
