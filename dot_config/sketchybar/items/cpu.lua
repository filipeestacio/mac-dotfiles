local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

local cpu = sbar.add("item", "cpu", {
  position = "right",
  update_freq = settings.update_freq.cpu,
  icon = {
    string = icons.cpu,
    color = colors.cyan,
    padding_right = 4,
  },
  label = {
    font = { family = "Hack Nerd Font", style = "Regular", size = 14.0 },
  },
})

local function update_cpu()
  sbar.exec("top -l 1 -n 0 2>/dev/null | grep 'CPU usage'", function(result)
    -- Parse "CPU usage: XX.XX% user, XX.XX% sys, XX.XX% idle"
    local idle = (result or ""):match("(%d+%.?%d*)%%%s*idle")
    if idle then
      local used = math.floor(100 - tonumber(idle) + 0.5)
      local label_color = colors.green
      if used > 70 then
        label_color = colors.red
      elseif used > 40 then
        label_color = colors.yellow
      end
      cpu:set({
        label = { string = used .. "%", color = label_color },
      })
    end
  end)
end

cpu:subscribe({ "forced", "routine" }, function(env)
  update_cpu()
end)
