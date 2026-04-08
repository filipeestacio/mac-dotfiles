local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

local network = sbar.add("item", "network", {
  position = "right",
  update_freq = settings.update_freq.network,
  icon = { drawing = false },
  label = {
    font = { family = "Hack Nerd Font", style = "Regular", size = 12.0 },
    color = colors.fg,
  },
})

local prev_bytes_in = 0
local prev_bytes_out = 0

local function human_readable(bytes_per_sec)
  if bytes_per_sec < 1024 then
    return string.format("%.0f B/s", bytes_per_sec)
  elseif bytes_per_sec < 1024 * 1024 then
    return string.format("%.1f KB/s", bytes_per_sec / 1024)
  else
    return string.format("%.1f MB/s", bytes_per_sec / (1024 * 1024))
  end
end

local function update_network()
  sbar.exec("netstat -ibn | grep -e en0 -m 1", function(result)
    if not result or result == "" then
      network:set({ label = { string = icons.network.down .. " -- " .. icons.network.up .. " --" } })
      return
    end

    -- netstat -ibn columns: Name Mtu Network Address Ipkts Ierrs Ibytes Opkts Oerrs Obytes
    local fields = {}
    for field in result:gmatch("%S+") do
      table.insert(fields, field)
    end

    local bytes_in = tonumber(fields[7]) or 0
    local bytes_out = tonumber(fields[10]) or 0

    if prev_bytes_in > 0 then
      local interval = settings.update_freq.network
      local down = (bytes_in - prev_bytes_in) / interval
      local up = (bytes_out - prev_bytes_out) / interval

      if down < 0 then down = 0 end
      if up < 0 then up = 0 end

      network:set({
        label = {
          string = icons.network.down .. " " .. human_readable(down) .. "  " .. icons.network.up .. " " .. human_readable(up),
        },
      })
    end

    prev_bytes_in = bytes_in
    prev_bytes_out = bytes_out
  end)
end

network:subscribe({ "forced", "routine" }, function(env)
  update_network()
end)
