local wezterm = require("wezterm") --[[@as table]]
local config = wezterm.config_builder()

config.audible_bell = "Disabled"
config.color_scheme = "Catppuccin Mocha"

local is_os_windows = wezterm.target_triple == "x86_64-pc-windows-msvc"

local font
if is_os_windows then
  font = "JetBrainsMono Nerd Font"
else
  font = "JetBrains Mono NerdFont"
end

config.font = wezterm.font(font, {
  weight = "Medium",
})
config.font_size = 13
config.font_rules = {
  {
    intensity = "Bold",
    font = wezterm.font({
      family = font,
      weight = "ExtraBold",
    }),
  },
  {
    intensity = "Normal",
    italic = true,
    font = wezterm.font({
      family = font,
      weight = "Medium",
      italic = true,
    }),
  },
  {
    intensity = "Bold",
    italic = true,
    font = wezterm.font({
      family = font,
      weight = "ExtraBold",
      italic = true,
    }),
  },
}

config.use_fancy_tab_bar = false
config.tab_max_width = 100
wezterm.on("format-tab-title", function(tab, tabs)
  local active_tab_index
  for _, curr_tab in ipairs(tabs) do
    if curr_tab.is_active == true then
      active_tab_index = curr_tab.tab_index
      break
    end
  end

  local title = tab.tab_title

  if title == nil or #title == 0 then
    title = tab.active_pane.title
  end

  local text
  if tab.tab_index == active_tab_index - 1 then
    text = " " .. title .. " "
  elseif tab.tab_index == active_tab_index then
    if tab.tab_index == 0 then
      text = " " .. title .. " "
    else
      text = " " .. title .. " "
    end
  else
    text = " " .. title .. "  "
  end

  return {
    { Attribute = { Intensity = "Bold" } },
    { Text = text },
  }
end)

config.enable_kitty_graphics = true
config.show_new_tab_button_in_tab_bar = false
config.show_tab_index_in_tab_bar = false
config.enable_scroll_bar = true
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

wezterm.on("update-status", function(window, pane)
  local overrides = window:get_config_overrides() or {}
  overrides.enable_scroll_bar = not pane:is_alt_screen_active()
  window:set_config_overrides(overrides)
end)

if is_os_windows then
  config.default_prog = { "pwsh" }
end

local mod = "CTRL|SHIFT"
local act = wezterm.action
config.disable_default_key_bindings = true
config.keys = {
  {
    key = "r",
    mods = mod,
    action = act.ReloadConfiguration,
  },
  {
    key = "+",
    mods = mod,
    action = act.IncreaseFontSize,
  },
  {
    key = "_",
    mods = mod,
    action = act.DecreaseFontSize,
  },
  {
    key = "Backspace",
    mods = mod,
    action = act.ResetFontSize,
  },
  {
    key = "h",
    mods = mod,
    action = act.ActivateTabRelative(-1),
  },
  {
    key = "l",
    mods = mod,
    action = act.ActivateTabRelative(1),
  },
  {
    key = "<",
    mods = mod,
    action = act.MoveTabRelative(-1),
  },
  {
    key = ">",
    mods = mod,
    action = act.MoveTabRelative(1),
  },
  {
    key = "j",
    mods = mod,
    action = act.ScrollByLine(4),
  },
  {
    key = "k",
    mods = mod,
    action = act.ScrollByLine(-4),
  },
  {
    key = "u",
    mods = mod,
    action = act.ScrollByPage(-0.5),
  },
  {
    key = "d",
    mods = mod,
    action = act.ScrollByPage(0.5),
  },
  {
    key = "g",
    mods = mod,
    action = act.ScrollToBottom,
  },
  {
    key = "f",
    mods = mod,
    action = act.ScrollToTop,
  },
  {
    key = "t",
    mods = mod,
    action = act.SpawnTab("CurrentPaneDomain"),
  },
  {
    key = "n",
    mods = mod,
    action = act.SpawnCommandInNewTab({ cwd = wezterm.home_dir }),
  },
  {
    key = "q",
    mods = mod,
    action = act.Multiple({
      act.CloseCurrentTab({ confirm = true }),
      wezterm.action_callback(function(window, pane)
        wezterm.emit_event("format-tab-title", window, pane)
      end),
    }),
  },
  {
    key = "c",
    mods = mod,
    action = act.CopyTo("Clipboard"),
  },
  {
    key = "v",
    mods = mod,
    action = act.PasteFrom("Clipboard"),
  },
  {
    key = "z",
    mods = mod,
    action = act.ScrollToPrompt(-1),
  },
  {
    key = "x",
    mods = mod,
    action = act.ScrollToPrompt(1),
  },
  {
    key = "Backspace",
    mods = "CTRL",
    action = act.SendKey({
      key = "w",
      mods = "CTRL",
    }),
  },
  {
    key = ".",
    mods = "CTRL",
    action = act.SendKey({
      key = ".",
      mods = "CTRL",
    }),
  },
  {
    key = "F11",
    action = act.ToggleFullScreen,
  },
  {
    key = "p",
    mods = mod,
    action = act.ActivateCommandPalette,
  },
}

return config
