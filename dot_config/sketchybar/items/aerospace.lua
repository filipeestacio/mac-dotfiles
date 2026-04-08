local colors = require("colors")
local settings = require("settings")

-- All Aerospace workspaces in display order
local workspaces = {
  "1", "2", "3", "4", "5", "6", "7", "8", "9",
  "A", "B", "C", "D", "E", "F", "G", "I",
  "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z",
}

-- Register the custom event from Aerospace
sbar.add("event", "aerospace_workspace_change")

-- Create an item for each workspace
local space_items = {}
for i, ws in ipairs(workspaces) do
  -- Add a separator gap between numbers and letters
  local pad_left = 3
  if ws == "A" then
    pad_left = 10
  end

  local item = sbar.add("item", "space." .. ws, {
    position = "left",
    icon = { drawing = false },
    label = {
      string = ws,
      font = {
        family = settings.font.text,
        style = settings.font.style.bold,
        size = 13.0,
      },
      color = colors.fg,
      padding_left = 8,
      padding_right = 8,
    },
    background = {
      color = colors.workspace.empty,
      corner_radius = 5,
      height = 24,
    },
    padding_left = pad_left,
    padding_right = 0,
    drawing = false,  -- hidden by default; update_all_workspaces will show occupied/focused
  })

  -- Click to switch, right-click to move window
  item:subscribe("mouse.clicked", function(env)
    if env.BUTTON == "right" then
      sbar.exec("aerospace move-node-to-workspace " .. ws)
    else
      sbar.exec("aerospace workspace " .. ws)
    end
  end)

  space_items[ws] = item
end

-- Single function to update all workspace states
local function update_all_workspaces()
  sbar.exec("aerospace list-workspaces --focused", function(focused_output)
    local focused = (focused_output or ""):gsub("%s+", "")

    sbar.exec("aerospace list-workspaces --monitor all --empty no", function(occupied_output)
      -- Parse occupied workspaces into a set
      local occupied = {}
      for line in (occupied_output or ""):gmatch("[^\r\n]+") do
        local ws = line:gsub("%s+", "")
        if ws ~= "" then
          occupied[ws] = true
        end
      end

      -- Update each workspace item
      for _, ws in ipairs(workspaces) do
        local item = space_items[ws]
        if ws == focused then
          -- Focused workspace: always visible, accent color
          sbar.animate("tanh", 10, function()
            item:set({
              drawing = true,
              label = { color = colors.bg },
              background = { color = colors.workspace.focused },
            })
          end)
        elseif occupied[ws] then
          -- Occupied workspace: visible, dimmed
          sbar.animate("tanh", 10, function()
            item:set({
              drawing = true,
              label = { color = colors.fg },
              background = { color = colors.workspace.occupied },
            })
          end)
        else
          -- Empty workspace: hidden
          item:set({ drawing = false })
        end
      end
    end)
  end)
end

-- Hidden observer that subscribes to the workspace change event
local observer = sbar.add("item", "aerospace_observer", {
  drawing = false,
  updates = true,
})

observer:subscribe("aerospace_workspace_change", function(env)
  update_all_workspaces()
end)

-- Also refresh on space_change (covers some edge cases)
observer:subscribe("space_change", function(env)
  update_all_workspaces()
end)

-- Periodic refresh to catch window open/close events
local function periodic_refresh()
  update_all_workspaces()
  sbar.delay(5, periodic_refresh)
end
periodic_refresh()
