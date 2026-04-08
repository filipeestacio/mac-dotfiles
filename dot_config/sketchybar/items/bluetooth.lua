local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

local bluetooth = sbar.add("item", "bluetooth", {
  position = "right",
  update_freq = settings.update_freq.bluetooth,
  icon = {
    string = icons.bluetooth.on,
    color = colors.comment,
    padding_right = 4,
  },
  label = {
    font = { family = "Hack Nerd Font", style = "Regular", size = 14.0 },
    string = "0",
  },
})

local function update_bluetooth()
  -- Use system_profiler which doesn't hang like blueutil can
  sbar.exec("system_profiler SPBluetoothDataType 2>/dev/null | grep -c 'Connected: Yes'", function(result)
    local count = tonumber((result or ""):gsub("%s+", "")) or 0
    local icon_color = count > 0 and colors.cyan or colors.comment
    bluetooth:set({
      icon = { string = icons.bluetooth.on, color = icon_color },
      label = { string = tostring(count) },
    })
  end)
end

bluetooth:subscribe({ "forced", "routine" }, function(env)
  update_bluetooth()
end)
