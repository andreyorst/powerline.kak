# powerline.kak

Powerline plugin for Kakoune Editor

![image](https://user-images.githubusercontent.com/19470159/47937941-7d92ec00-def3-11e8-8ede-9accdef4d6f7.png)

This plugin aims to make Kakoune's powelinde more context dependent, and beautiful. **powerline.kak** adds coloring, separators, toggle behavior and support for git.

## Installation

### [plug.kak](https://github.com/andreyorst/plug.kak) (recommended)
Add this to your `kakrc`:
```kak
plug "andreyorst/powerline.kak"
```
Source your `kakrc` or restart Kakoune, and execute `:plug-install`

### Without plugin manager

Clone this repo somewhere
```bash
git clone https://github.com/andreyorst/powerline.kak.git
```
add links to all files in `rc` to your autoload folder, or source them from kakrc.

## Configuration

**powerline.kak** supports these commands:
- `powerline-toggle` - toggle parts of powerline on and off. Supports optional parameter `on` or `off`.
- `powerline-separator` - change separators of the powerline. Some of powerline font icons are supported by the script:
  - powerline separators: `arrow`, `curve`, `flame`, `triangle`, `triangle-inverted`.
  - `random` - randomly selects one from above.
  - `custom` - use your own separators.
  - `none` - no separators.
- `powerline-theme` - change powerline theme.
- `powerline-rebuild` - reconstruct powerline accordingly to options. Sometimes needed when you modify options directly.

### Example configuration using **plug.kak**

```kak
plug "andreyorst/powerline.kak" %{
    hook -once global WinCreate .* %{
        powerline-theme gruvbox
        powerline-separator triangle
        powerline-toggle line_column off
    }
}
```

Lets breakdown this:
- `plug` is a [plug.kak](https://github.com/andreyorst/plug.kak) command that loads **powerline.kak** plugin and configures it with last `%{...}` parameter.
- `hook -once global WinCreate .* %{` is needed because all **powerline.kak** settings are done in context of a window. So to properly load a plugin we need an existing window.
- `powerline-theme gruvbox` - sets the theme to `gruvbox`.
- `powerline-separator triangle` - sets the separator to powerline's triangle.
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

Yes. Themes are commands. These variables are used by each module of **powerline.kak**. Make sure that text at the end of your command and string that you add to the `powerline_themes` are exactly the same:
`set-option -add global powerline_themes "`**base16-gruvbox**`"`
`define-command -hidden powerline-theme-`**base16-gruvbox**` %{`

If they are the same **powerline.kak** will show you completion items with correct theme name and execute this command for you. No need to execute this command manually. All you need to do is `powerline-theme base16-gruvbox`.
