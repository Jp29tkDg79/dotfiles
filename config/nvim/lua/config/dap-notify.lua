local levels = vim.log.levels

-- nvim-dap
local dap = require("dap")

---------------------
-- custom plugins
---------------------
local notify = require("utils.notify")

-- DAP integration
-- Make sure to also have the snippet with the common helper functions in your config!
dap.listeners.before["event_progressStart"]["progress-notifications"] = function(session, body)
    local notif_data = notify.get_notif_data("dap", body.progressId)

    local message = notify.format_message(body.message, body.percentage)
    notif_data.notification = vim.notify(message, levels.INFO, {
        title = notify.format_title(body.title, session.config.type),
        icon = notify.spinner_frames[1],
        timeout = false,
        hide_from_history = false,
    })

    notif_data.notification.spinner = 1
    notify.update_spinner("dap", body.progressId)
end

dap.listeners.before["event_progressUpdate"]["progress-notifications"] = function(session, body)
    local notif_data = notify.get_notif_data("dap", body.progressId)
    notif_data.notification = vim.notify(notify.format_message(body.message, body.percentage), levels.INFO, {
        replace = notif_data.notification,
        hide_from_history = false,
    })
end

dap.listeners.before["event_progressEnd"]["progress-notifications"] = function(session, body)
    local notif_data = notify.get_notif_data("dap", body.progressId)
    notif_data.notification =
        vim.notify(body.message and notify.format_message(body.message) or "Complete", levels.INFO, {
            icon = "",
            replace = notif_data.notification,
            timeout = 3000,
        })
    notif_data.spinner = nil
end
