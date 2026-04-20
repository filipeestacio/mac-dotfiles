local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

local media = sbar.add("item", "media", {
  position = "center",
  update_freq = settings.update_freq.media,
  icon = {
    string = icons.media.not_playing,
    color = colors.pink,
    padding_right = 4,
  },
  label = {
    font = { family = "Hack Nerd Font", style = "Regular", size = 13.0 },
    color = colors.fg,
    max_chars = 30,
  },
  scroll_texts = true,
})

local function trim(s)
  local result = (s or ""):gsub("%s+$", "")
  return result
end

local function update_media()
  sbar.exec("nowplaying-cli get title 2>/dev/null", function(title_result)
    local title = trim(title_result)
    if title == "" or title == "null" then
      media:set({
        drawing = false,
      })
      return
    end

    sbar.exec("nowplaying-cli get artist 2>/dev/null", function(artist_result)
      local artist = trim(artist_result)

      sbar.exec("nowplaying-cli get playbackRate 2>/dev/null", function(state_result)
        local rate_str = trim(state_result)
        local rate = tonumber(rate_str) or 0
        local icon_str = rate > 0 and icons.media.pause or icons.media.play

        local label_str = title
        if artist ~= "" and artist ~= "null" then
          label_str = artist .. " \u{2014} " .. title
        end

        media:set({
          drawing = true,
          icon = { string = icon_str, color = colors.pink },
          label = { string = label_str },
        })
      end)
    end)
  end)
end

media:subscribe({ "forced", "routine", "media_change" }, function(env)
  update_media()
end)

media:subscribe("mouse.clicked", function(env)
  sbar.exec("nowplaying-cli togglePlayPause")
end)
