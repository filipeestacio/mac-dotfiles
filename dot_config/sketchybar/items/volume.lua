local colors = require("colors")
local icons = require("icons")

local volume = sbar.add("item", "volume", {
  position = "right",
  icon = {
    padding_right = 4,
  },
  label = {
    font = { family = "Hack Nerd Font", style = "Regular", size = 14.0 },
  },
})

local function update_volume(vol)
  local vol_num = tonumber(vol) or 0
  local icon_str = icons.volume.mute
  local icon_color = colors.comment

  if vol_num == 0 then
    icon_str = icons.volume.mute
    icon_color = colors.comment
  elseif vol_num < 33 then
    icon_str = icons.volume.low
    icon_color = colors.fg
  elseif vol_num < 66 then
    icon_str = icons.volume.medium
    icon_color = colors.fg
  else
    icon_str = icons.volume.high
    icon_color = colors.fg
  end

  volume:set({
    icon = { string = icon_str, color = icon_color },
    label = { string = vol_num .. "%" },
  })
end

volume:subscribe("volume_change", function(env)
  update_volume(env.INFO)
end)

-- Get initial volume
sbar.exec("osascript -e 'output volume of (get volume settings)'", function(result)
  update_volume(result)
end)
