local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

local memory = sbar.add("item", "memory", {
  position = "right",
  update_freq = settings.update_freq.memory,
  icon = {
    string = icons.memory,
    color = colors.cyan,
    padding_right = 4,
  },
  label = {
    font = { family = "Hack Nerd Font", style = "Regular", size = 14.0 },
  },
})

local function update_memory()
  sbar.exec("memory_pressure | grep 'free percentage'", function(result)
    -- Output: "System-wide memory free percentage: NN%"
    local found, _, pct_free = (result or ""):find("(%d+)%%")
    if found then
      local used = 100 - tonumber(pct_free)
      local label_color = colors.fg
      if used > 80 then
        label_color = colors.red
      elseif used > 60 then
        label_color = colors.yellow
      end
      memory:set({
        label = { string = used .. "%", color = label_color },
      })
    end
  end)
end

memory:subscribe({ "forced", "routine" }, function(env)
  update_memory()
end)
