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
    mods = mod,
    key = "r",
    action = act.ReloadConfiguration,
  },
  {
    mods = mod,
    key = "+",
    action = act.IncreaseFontSize,
  },
  {
    mods = mod,
    key = "_",
    action = act.DecreaseFontSize,
  },
  {
    mods = mod,
    key = "Backspace",
    action = act.ResetFontSize,
  },
  {
    mods = mod,
    key = "h",
    action = act.ActivateTabRelative(-1),
  },
  {
    mods = mod,
    key = "l",
    action = act.ActivateTabRelative(1),
  },
  {
    mods = mod,
    key = "<",
    action = act.MoveTabRelative(-1),
  },
  {
    mods = mod,
    key = ">",
    action = act.MoveTabRelative(1),
  },
  {
    mods = mod,
    key = "j",
    action = act.ScrollByLine(4),
  },
  {
    mods = mod,
    key = "k",
    action = act.ScrollByLine(-4),
  },
  {
    mods = mod,
    key = "u",
    action = act.ScrollByPage(-0.5),
  },
  {
    mods = mod,
    key = "d",
    action = act.ScrollByPage(0.5),
  },
  {
    mods = mod,
    key = "g",
    action = act.ScrollToBottom,
  },
  {
    mods = mod,
    key = "f",
    action = act.ScrollToTop,
  },
  {
    mods = mod,
    key = "t",
    action = act.SpawnTab("CurrentPaneDomain"),
  },
  {
    mods = mod,
    key = "n",
    action = act.SpawnCommandInNewTab({ cwd = wezterm.home_dir }),
  },
  {
    mods = mod,
    key = "q",
    action = act.Multiple({
      act.CloseCurrentTab({ confirm = true }),
      wezterm.action_callback(function(window, pane)
        wezterm.emit_event("format-tab-title", window, pane)
      end),
    }),
  },
  {
    mods = mod,
    key = "c",
    action = act.CopyTo("Clipboard"),
  },
  {
    mods = mod,
    key = "v",
    action = act.PasteFrom("Clipboard"),
  },
  {
    mods = mod,
    key = "z",
    action = act.ScrollToPrompt(-1),
  },
  {
    mods = mod,
    key = "x",
    action = act.ScrollToPrompt(1),
  },
  {
    mods = "CTRL",
    key = "Backspace",
    action = act.SendKey({
      mods = "CTRL",
      key = "w",
    }),
  },
  {
    mods = "CTRL",
    key = ".",
    action = act.SendKey({
      mods = "CTRL",
      key = ".",
    }),
  },
  {
    mods = "CTRL",
    key = "Space",
    action = act.SendKey({
      mods = "CTRL",
      key = "Space",
    }),
  },
  {
    key = "F11",
    action = act.ToggleFullScreen,
  },
  {
    mods = mod,
    key = "p",
    action = act.ActivateCommandPalette,
  },
}

return config
