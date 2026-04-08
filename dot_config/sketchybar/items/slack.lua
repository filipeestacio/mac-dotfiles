local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

local slack = sbar.add("item", "slack", {
  position = "right",
  update_freq = 10,
  icon = {
    string = icons.slack,
    font = { family = settings.font.text, style = settings.font.style.bold, size = settings.icons.size },
    color = colors.comment,
    padding_right = 4,
  },
  label = { drawing = false },
})

local function update_slack()
  sbar.exec("lsappinfo info -only StatusLabel 'Slack' 2>/dev/null", function(result)
    local badge = (result or ""):match('"label"="(%d+)"')
    if badge then
      slack:set({
        icon = { color = colors.red },
        label = { string = badge, drawing = true },
      })
    else
      slack:set({
        icon = { color = colors.comment },
        label = { drawing = false },
      })
    end
  end)
end

slack:subscribe({ "forced", "routine", "system_woke" }, function(env)
  update_slack()
end)
