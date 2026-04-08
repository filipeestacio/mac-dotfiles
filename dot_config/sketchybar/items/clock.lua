local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

local clock = sbar.add("item", "clock", {
  position = "right",
  update_freq = settings.update_freq.clock,
  icon = {
    string = icons.clock,
    color = colors.cyan,
    padding_right = 6,
  },
  label = {
    font = {
      family = settings.font.numbers,
      style = settings.font.style.bold,
      size = settings.label.size,
    },
    color = colors.fg,
  },
  padding_right = 6,
})

clock:subscribe({ "forced", "routine" }, function(env)
  clock:set({ label = os.date("%a %d %b  %I:%M %p") })
end)
