local double_press = require("./ctrlDoublePress")

local open_alacritty = function()
	local appName = "Alacritty"
	local app = hs.application.get(appName)

	if app == nil or app:isHidden() then
		hs.application.launchOrFocus(appName)
	else
		app:hide()
	end
end

double_press.timeFrame = 0.5
double_press.action = open_alacritty
