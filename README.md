# powerline.kak ![license](https://img.shields.io/github/license/andreyorst/powerline.kak.svg)
<!--[![GitHub release](https://img.shields.io/github/release/andreyorst/powerline.kak.svg)](https://github.com/andreyorst/powerline.kak/releases)
[![GitHub Release Date](https://img.shields.io/github/release-date/andreyorst/powerline.kak.svg)](https://github.com/andreyorst/powerline.kak/releases)
![Github commits (since latest release)](https://img.shields.io/github/commits-since/andreyorst/powerline.kak/latest.svg) -->

Powerline plugin for Kakoune Editor

![image](https://user-images.githubusercontent.com/19470159/47937941-7d92ec00-def3-11e8-8ede-9accdef4d6f7.png)

This plugin aims to make Kakoune's powelinde more context dependent, and beautiful. **powerline.kak** adds coloring, separators, toggle behavior and support for git. Some parts, like git branch and filetype, are shown only if they are available, so there will be no filetype section while you're editing file which filetype wasnt deduced by Kakoune. Also if you're editing file that has no write access, **powerline.kak** will show you a lock symbol near the filename.0

## Installation

### With [plug.kak](https://github.com/andreyorst/plug.kak) (recommended)
Add this to your `kakrc`:
```kak
plug "andreyorst/powerline.kak"
```
Source your `kakrc` or restart Kakoune, and execute `:plug-install`. Or if you don't want to source configuration file or restart Kakoune, simply run `plug-install andreyorst/powerline.kak`. Powerline will be enabled automatically on buffer change. Use `powerline-rebuild` to activate it manually.

### Without plugin manager

Clone this repo somewhere
```bash
git clone https://github.com/andreyorst/powerline.kak.git
```

And source the `powerline.kak` script from it. It can work on its own, but if you want builtin themes to be available, source every needed theme script from `rc/themes` folder. After that you can use **powerline.kak**.

## Configuration

**powerline.kak** supports these commands:
- `powerline-toggle` - toggle parts of powerline on and off. Supports optional parameter `on` or `off`.
- `powerline-separator` - change separators of the powerline. Some of powerline font icons are supported by the script:
  - powerline separators: `arrow`, `curve`, `flame`, `triangle`, `triangle-inverted`.
  - `random` - randomly selects one from above.
  - `custom` - use your own separators.
  - `none` - no separators.
- `powerline-theme` - change powerline theme.
- `powerline-format` - change order of powerline parts.
- `powerline-rebuild` - reconstruct powerline accordingly to options. Sometimes needed when you modify options directly.

All **powerline.kak** settings are applied in context of a window, therefore you can have different powerlines for different windows.

### Example configuration using **plug.kak**

```kak
plug "andreyorst/powerline.kak" %{
    hook -once global WinCreate .* %{
        powerline-theme gruvbox
        powerline-separator triangle
        powerline-format git bufname filetype mode_info line_column position
        powerline-toggle line_column off
    }
}
```

Lets breakdown this:
- `plug` is a [plug.kak](https://github.com/andreyorst/plug.kak) command that loads **powerline.kak** plugin and configures it with last `%{...}` parameter.
- `hook -once global WinCreate .* %{` is needed because all **powerline.kak** settings are done in context of a window. So to properly load a plugin we need an existing window.
- `powerline-theme gruvbox` - sets the theme to `gruvbox`.
- `powerline-separator triangle` - sets the separator to powerline's triangle.
- `powerline-format git bufname filetype mode_info line_column position` - sets the format of powerline, by adding only git, buffer name, filetype, information about mode, line_column and file position in percents.
- `powerline-toggle line_column off` - disables part of powerline which shows current line and column.

You can add your own configurations here. Since all settings are window-dependent you can have different settings for different windows, filetypes, window types, etc.

For example this hook will make **powerline.kak** use random separator for every new buffer:
```kak
hook global BufCreate .* %{
    hook -once global WinDisplay .* %{
        powerline-separator random
    }
}
```

## Making themes

You can create your own themes for **powerline.kak**. Here's the example of good theme:

```kak
### begining of file: base16-gruvbox.kak ###

set-option -add global powerline_themes "base16-gruvbox"

define-command -hidden powerline-theme-base16-gruvbox %{
    set-option global powerline_git_fg         "rgb:d5c4a1"
    set-option global powerline_git_bg         "rgb:3c3836"
    set-option global powerline_bufname_bg     "rgb:a89984"
    set-option global powerline_bufname_fg     "rgb:282828"
    set-option global powerline_line_column_fg "rgb:bdae93"
    set-option global powerline_line_column_bg "rgb:504945"
    set-option global powerline_mode_info_fg   "rgb:3c3836"
    set-option global powerline_mode_info_bg   "rgb:3c3836"
    set-option global powerline_filetype_fg    "rgb:d5c4a1"
    set-option global powerline_filetype_bg    "rgb:504945"
    set-option global powerline_client_fg      "rgb:ebdbb2"
    set-option global powerline_client_bg      "rgb:665c54"
    set-option global powerline_session_fg     "rgb:fbf1c7"
    set-option global powerline_session_bg     "rgb:7c6f64"
    set-option global powerline_position_fg    "rgb:282828"
    set-option global powerline_position_bg    "rgb:a89984"
}
```

That is, themes for **powerline.kak** are commands, that define colors in these variables. Each module has foreground and background assests. Nothe that modifyers like **bold** are not supported yet. I'm thinking about it. When defining a theme, please make sure that text at the end of your command and string that you add to the `powerline_themes` are exactly the same:
```
set-option -add global powerline_themes "base16-gruvbox"
define-command   -hidden powerline-theme-base16-gruvbox %{...}
                                         ^^^^^^^^^^^^^^
                                        This is important
```
If they are the same **powerline.kak** will show you completion items with correct theme name and execute this command for you. No need to execute this command manually. All you need to do is `powerline-theme base16-gruvbox`.
