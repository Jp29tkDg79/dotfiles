local M = {}

M.file_exists = function(path)
    local f = io.open(path, "rb")
    if f then
        f:close()
    end
    return f ~= nil
end

M.has = function(n)
    return vim.fn.has(n) == 1
end

M.isNvm = function()
    return M.has("nvim")
end

M.isWin = function()
    return M.has("win32") or M.has("win64")
end

M.isMac = function()
    return M.has("mac")
end

M.isLinux = function()
    return M.has("linux")
end

M.path_join = function(...)
    return table.concat({ ... }, "/")
end

M.stdpath = function(n)
    return vim.fn.stdpath(n)
end

M.get_lua_files = function(dir)
    local t = {}
    for _, v in pairs(vim.fn.readdir(M.path_join(M.stdpath("config"), "lua", dir))) do
        table.insert(t, dir .. "/" .. v:gsub("%.lua$", ""))
    end
    return t
end

return M
