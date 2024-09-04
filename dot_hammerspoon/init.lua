-- TODO: Move window to other monitor

--[[
--  Window movement
--  Uses VIM directions
--]]
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "K", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.y = f.y - 10
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "H", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.x = f.x - 10
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "L", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.x = f.x + 10
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "J", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.y = f.y + 10
  win:setFrame(f)
end)


--[[
--  Default window assignnments for monitors
--]]
local homeVerticalMonitor = "DELL U2718Q"
-- local homeHorizontalMonitor = "DELL U2718Q"
-- local laptopMonitor = ""
-- local workMonitor = ""

local windowLayout = {
    -- Slack goes in the middle
    {nil, hs.window'Google Chrome %- Shane %(Work%)', homeVerticalMonitor, hs.geometry.rect(0.01, 0.015, .98, .316), nil, nil},
    {"Slack",  nil, homeVerticalMonitor, hs.geometry.rect(0.01, 0.341, .98, .316), nil, nil},
    {nil, hs.window'Google Chrome %- Shane %(Personal%)', homeVerticalMonitor, hs.geometry.rect(0.01, 0.667, .98, .316), nil, nil},
    -- Home layout: Horizontal Monitor
    -- Work layout: External Monitor
    -- {nil, hs.window'Google Chrome %- Shane %(Work%)', homeVerticalMonitor, hs.geometry.rect(0.01, 0.02, .98, .3), nil, nil},
    -- {"Mail",    nil,          homeVerticalMonitor, hs.layout.right50,   nil, nil},
    -- {"iTunes",  "iTunes",     homeVerticalMonitor, hs.layout.maximized, nil, nil},
    -- {"iTunes",  "MiniPlayer", homeVerticalMonitor, nil, nil, hs.geometry.rect(0, -48, 400, 48)},
}
hs.layout.apply(windowLayout)


--[[
--  Move windows to different regions
--]]
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Up", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Left", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Right", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

--[[
--  Sane defaults
--]]
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
  hs.reload()
end)
-- TODO: Configure the alert style
hs.alert.show("Config reloaded")
