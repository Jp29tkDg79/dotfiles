local levels = vim.log.levels

---------------------
-- custom plugins
---------------------
local notify = require("utils.notify")

-- LSP integration
-- Make sure to also have the snippet with the common helper functions in your config!
vim.lsp.handlers["$/progress"] = function(_, result, ctx)
  local client_id = ctx.client_id

  local val = result.value

  if not val.kind then
    return
  end

  local notif_data = notify.get_notif_data(client_id, result.token)

  if val.kind == "begin" then
    local message = notify.format_message(val.message, val.percentage)

    notif_data.notification = vim.notify(message, levels.INFO, {
      title = notify.format_title(val.title, vim.lsp.get_client_by_id(client_id).name),
      icon = notify.spinner_frames[1],
      timeout = false,
      hide_from_history = false,
    })

    notif_data.spinner = 1
    notify.update_spinner(client_id, result.token)
  elseif val.kind == "report" and notif_data then
    notif_data.notification = vim.notify(notify.format_message(val.message, val.percentage), levels.INFO, {
      replace = notif_data.notification,
      hide_from_history = false,
    })
  elseif val.kind == "end" and notif_data then
    notif_data.notification =
      vim.notify(val.message and notify.format_message(val.message) or "Complete", levels.INFO, {
        icon = "",
        replace = notif_data.notification,
        timeout = 3000,
      })

    notif_data.spinner = nil
  end
end

-- table from lsp severity to vim severity.
local severity = {
  "error",
  "warn",
  "info",
  "info", -- map both hint and info to info?
}

vim.lsp.handlers["window/shownotifyessage"] = function(err, method, params, client_id)
  vim.notify(method.message, severity[params.type])
end
