local colors = require("colors")
local settings = require("settings")

local front_app = sbar.add("item", "front_app", {
  position = "left",
  icon = { drawing = false },
  label = {
    font = {
      family = settings.font.text,
      style = settings.font.style.bold,
      size = settings.label.size,
    },
    color = colors.fg,
    padding_left = 6,
  },
  padding_left = 4,
})

front_app:subscribe("front_app_switched", function(env)
  front_app:set({ label = { string = env.INFO } })
end)

-- Get initial front app
sbar.exec("osascript -e 'tell application \"System Events\" to get name of first application process whose frontmost is true'", function(result)
  local app = (result or ""):gsub("%s+$", "")
  if app ~= "" then
    front_app:set({ label = { string = app } })
  end
end)
