local colors = require("colors")
local icons = require("icons")

local battery = sbar.add("item", "battery", {
  position = "right",
  update_freq = 120,
  icon = {
    font = { family = "Hack Nerd Font", style = "Bold", size = 17.0 },
    padding_right = 4,
  },
  label = {
    font = { family = "Hack Nerd Font", style = "Regular", size = 14.0 },
  },
})

local function update_battery()
  sbar.exec("pmset -g batt", function(result)
    local found, _, charge = (result or ""):find("(%d+)%%")
    local charging = (result or ""):find("AC Power") ~= nil

    local charge_num = tonumber(charge) or 0
    local icon_str = icons.battery._0
    local icon_color = colors.red

    if charging then
      icon_str = icons.battery.charging
      icon_color = colors.green
    elseif charge_num > 80 then
      icon_str = icons.battery._100
      icon_color = colors.green
    elseif charge_num > 60 then
      icon_str = icons.battery._75
      icon_color = colors.fg
    elseif charge_num > 40 then
      icon_str = icons.battery._50
      icon_color = colors.yellow
    elseif charge_num > 20 then
      icon_str = icons.battery._25
      icon_color = colors.orange
    else
      icon_str = icons.battery._0
      icon_color = colors.red
    end

    battery:set({
      icon = { string = icon_str, color = icon_color },
      label = { string = charge_num .. "%" },
    })
  end)
end

battery:subscribe({ "forced", "routine", "power_source_change", "system_woke" }, function(env)
  update_battery()
end)
