local wezterm = require("wezterm") --[[@as table]]
local config = wezterm.config_builder()

config.audible_bell = "Disabled"
config.color_scheme = "Catppuccin Mocha"

config.font = wezterm.font("JetBrains Mono NerdFont", {
  weight = "Medium",
})
config.font_size = 13
config.font_rules = {
  {
    intensity = "Bold",
    font = wezterm.font({
      family = "JetBrains Mono NerdFont",
      weight = "ExtraBold",
    }),
  },
  {
    intensity = "Normal",
    italic = true,
    font = wezterm.font({
      family = "JetBrains Mono NerdFont",
      weight = "Medium",
      italic = true,
    }),
  },
  {
    intensity = "Bold",
    italic = true,
    font = wezterm.font({
      family = "JetBrains Mono NerdFont",
      weight = "ExtraBold",
      italic = true,
    }),
  },
}

config.tab_bar_at_bottom = true

wezterm.plugin.require("https://github.com/nekowinston/wezterm-bar").apply_to_config(config, {
  position = "bottom",
  max_width = 32,
  dividers = "slant_right", -- or "slant_left", "arrows", "rounded", false
  indicator = {
    leader = {
      enabled = false,
      off = " ",
      on = " ",
    },
    mode = {
      enabled = true,
      names = {
        resize_mode = "RESIZE",
        copy_mode = "VISUAL",
        search_mode = "SEARCH",
      },
    },
  },
  tabs = {
    numerals = "arabic", -- or "roman"
    pane_count = false, -- or "subscript", false
    brackets = {
      active = { "", ":" },
      inactive = { "", ":" },
    },
  },
  clock = { -- note that this overrides the whole set_right_status
    enabled = false,
    format = "%H:%M", -- use https://wezfurlong.org/wezterm/config/lua/wezterm.time/Time/format.html
  },
})
config.use_fancy_tab_bar = false
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
  wezterm.log_info("hhh")
  local overrides = window:get_config_overrides() or {}
  overrides.enable_scroll_bar = not pane:is_alt_screen_active()
  window:set_config_overrides(overrides)
end)

config.set_environment_variables = {
  COMSPEC = "pwsh.exe",
}

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
    action = act.CloseCurrentTab({ confirm = true }),
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
