local list = {
    -- global options
    opt = {
        -- encodings
        encoding = "utf-8",
        fileencoding = "utf-8",
        autowrite = true, -- Enable auto write
        clipboard = "unnamedplus", -- Sync with system clipboard
        completeopt = "menu,menuone,noselect",
        conceallevel = 3, -- Hide * markup for bold and italic
        confirm = true, -- Confirm to save changes before exiting modified buffer
        cursorline = true, -- Enable highlighting of the current line
        formatoptions = "jcroqlnt", -- tcqj
        grepformat = "%f:%l:%c:%m",
        grepprg = "rg --vimgrep",
        ignorecase = true, -- Ignore case
        inccommand = "nosplit", -- preview incremental substitute
        laststatus = 0,
        mouse = "a", -- Enable mouse mode
        number = true, -- Print line number
        pumblend = 10, -- Popup blend
        pumheight = 10, -- Maximum number of entries in a popup
        relativenumber = true, -- Relative line numbers
        scrolloff = 4, -- Lines of context
        sessionoptions = { "buffers", "curdir", "tabpages", "winsize" },
        shiftround = true, -- Round indent
        autoindent = true, -- Auto indent
        expandtab = true, -- Use spaces instead of tabs
        shiftwidth = 2, -- Size of an indent
        tabstop = 2, -- Number of spaces tabs count for
        shortmess = { W = true, I = true, c = true },
        showmode = false, -- Dont show mode since we have a statusline
        sidescrolloff = 8, -- Columns of context
        signcolumn = "yes", -- Always show the signcolumn, otherwise it would shift the text each time
        smartcase = true, -- Don't ignore case with capitals
        smartindent = true, -- Insert indents automatically
        spelllang = { "ja" },
        splitbelow = true, -- Put new windows below current
        splitright = true, -- Put new windows right of current
        termguicolors = true, -- True color support
        timeoutlen = 300,
        undofile = true,
        undolevels = 10000,
        updatetime = 200, -- Save swap file and trigger CursorHold
        wildmode = "longest:full,full", -- Command-line completion mode
        winminwidth = 5, -- Minimum window width
        wrap = false, -- Disable line wrap

        -- fold options
        foldcolumn = "1", -- '0'(false) is not bad
        foldlevel = 99, -- Using ufo provider need a large value, feel free to decrease the value
        foldlevelstart = 99,
        foldenable = true,
        fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]],

        -- others
        title = true,
        backup = false,
        backupskip = { "/tmp/*", "/private/tmp/*" },
    },
    -- filetype
    -- TODO: 無理やり追加しているので、別の方法考えた方がいいかも...
    filetype = {
        templ = "templ",
    },
}

for opt, tbl in pairs(list) do
    if opt == "filetype" then
        vim[opt].add({ extension = tbl })
    else
        local o = vim[opt]
        for k, v in pairs(tbl) do
            o[k] = v
        end
    end
end
