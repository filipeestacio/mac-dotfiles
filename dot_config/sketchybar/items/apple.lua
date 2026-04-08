local colors = require("colors")
local icons = require("icons")

local apple = sbar.add("item", "apple", {
  icon = {
    string = icons.apple,
    font = {
      family = "Hack Nerd Font",
      style = "Bold",
      size = 17.0,
    },
    color = colors.accent,
    padding_left = 8,
    padding_right = 8,
  },
  label = { drawing = false },
  position = "left",
  click_script = "open -a 'Activity Monitor'",
})
