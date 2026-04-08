local colors = require("colors")
local settings = require("settings")

-- Set default item properties
sbar.default({
  updates = "when_shown",
  icon = {
    font = {
      family = settings.font.text,
      style = settings.font.style.bold,
      size = settings.icons.size,
    },
    color = colors.fg,
    padding_left = settings.paddings,
    padding_right = settings.paddings,
  },
  label = {
    font = {
      family = settings.font.text,
      style = settings.font.style.regular,
      size = settings.label.size,
    },
    color = colors.fg,
    padding_left = settings.paddings,
    padding_right = settings.paddings,
  },
  background = {
    height = 28,
    corner_radius = 5,
    border_width = 0,
  },
  padding_left = settings.paddings,
  padding_right = settings.paddings,
})

-- Load bar appearance
require("bar")

-- Load all items
require("items")
