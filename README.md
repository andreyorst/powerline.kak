# powerline.kak
![license][1]
[![GitHub release][2]][3]
[![GitHub Release Date][4]][5]
![GitHub commits (since latest release)][6]


Powerline plugin for Kakoune Editor.

![image][7]

This plugin aims to make Kakoune's modeline more context dependent, and
beautiful. **powerline.kak** adds coloring, separators, toggle behavior and
support for git. Some parts, like git branch and filetype, are shown only if
they are available, so there will be no filetype section while you're editing
file which filetype wasn't deduced by Kakoune. Also if you're editing file that
has no write access, **powerline.kak** will show you a lock symbol near the
filename.

## Installation
### With [plug.kak][8] (recommended)
Add this to your `kakrc`:

```kak
plug "andreyorst/powerline.kak"
```

Source your `kakrc` or restart Kakoune, and execute `:plug-install`. Or if you
don't want to source configuration file or restart Kakoune, simply run
`plug-install andreyorst/powerline.kak`. Powerline will be enabled automatically
on buffer change. Use `powerline-rebuild` to activate it manually.

### Without plugin manager
#### Autoload
Clone or place a symbolic link to the repository into your `autoload`
directory. Plugin should be loaded fine. If any errors will show up, please open
an issue.

#### By hand
Clone this repository somewhere

```bash
git clone https://github.com/andreyorst/powerline.kak.git
```

Source the main script in your `kakrc`:

```kak
source /home/andreyorst/.config/kak/plugins/powerline.kak/rc/powerline.kak
```

Source modules. You can skip those you don't want to use but it highly
recommended to source at least `bufname.kak`, and `mode_info.kak`:

```kak
source /home/andreyorst/.config/kak/plugins/powerline.kak/rc/modules/bufname.kak
source /home/andreyorst/.config/kak/plugins/powerline.kak/rc/modules/client.kak
source /home/andreyorst/.config/kak/plugins/powerline.kak/rc/modules/filetype.kak
source /home/andreyorst/.config/kak/plugins/powerline.kak/rc/modules/git.kak
source /home/andreyorst/.config/kak/plugins/powerline.kak/rc/modules/line_column.kak
source /home/andreyorst/.config/kak/plugins/powerline.kak/rc/modules/mode_info.kak
source /home/andreyorst/.config/kak/plugins/powerline.kak/rc/modules/position.kak
source /home/andreyorst/.config/kak/plugins/powerline.kak/rc/modules/session.kak
```

And source theme that you want to use:

```kak
source /home/andreyorst/.config/kak/plugins/powerline.kak/rc/themes/base16-gruvbox.kak
```

If you want to use builtin themes, you'll need to source theme scripts from
`rc/themes` folder. This is kind of tedious thing to do, and that's why I
recommend using **plug.kak**, since it does all this for you automatically, and
handles your configuration too.

After that you can use **powerline.kak**.

## Configuration
**powerline.kak** supports these commands:
- `powerline-toggle` - toggle parts of powerline on and off. Supports optional
  parameter `on` or `off`.
- `powerline-separator` - change separators of the powerline. Some of powerline
  font icons are supported by the script:
  - powerline separators: `arrow`, `curve`, `flame`, `triangle`,
    `triangle-inverted`.
  - `random` - randomly selects one from above.
  - `custom` - use your own separators.
  - `none` - no separators.
- `powerline-theme` - change powerline theme.
- `powerline-format` - change order of powerline parts.
- `powerline-rebuild` - reconstruct powerline accordingly to options. Sometimes
  needed when you modify options directly.

These options are also available for configuration:
- `powerline_separator` - set separator via option.
- `powerline_separator_thin` - set thin separator via option.
- `powerline_format` - set powerline format via option.
- `powerline_ignore_warnings` - this option makes powerline ignore warnings when
building powerline.

All **powerline.kak** settings executed with commands are applied in context of
a window, therefore you can have different powerlines for different windows.

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
- `plug` is a [plug.kak][8] command that loads **powerline.kak** plugin and
  configures it with last `%{...}` parameter.
- `hook -once global WinCreate .* %{` is needed because all **powerline.kak**
  settings are done in context of a window. So to properly load a plugin we need
  an existing window.
- `powerline-theme gruvbox` - sets the theme to `gruvbox`.
- `powerline-separator triangle` - sets the separator to powerline's
  triangle. Note that as settings are window dependent new window will use
  default separator, which is `triangle`. To prevent this either use separate
  `hook global WinCreate .* %{ powerline-separator triangle }` that will be
  applied to all new windows, or modify `powerline_separator` and
  `powerline_separator_thin` global options to your liking.
- `powerline-format git bufname filetype mode_info line_column position` - sets
  the format of powerline, by adding only git, buffer name, filetype,
  information about mode, line_column and file position in percents.
- `powerline-toggle line_column off` - disables part of powerline which shows
  current line and column. Again, you can have this disabled or enabled for
  certain filetypes or buffers via `hook`s , etc.

You can add your own configurations here. Since all settings are
window-dependent you can have different settings for different windows,
filetypes, window types, etc.

For example this hook will make **powerline.kak** use random separator for every
new buffer:

```kak
hook global BufCreate .* %{
    hook -once global WinDisplay .* %{
        powerline-separator random
    }
}
```

## Making themes
You can create your own themes for **powerline.kak**. Here's the example of good
theme:

```kak
# base16-gruvbox colorscheme for powerline.kak
# based on https://github.com/andreyorst/base16-gruvbox.kak

declare-option -hidden str-list powerline_themes
set-option -add global powerline_themes "base16-gruvbox"

define-command -hidden powerline-theme-base16-gruvbox %{
    declare-option -hidden str powerline_color00 "rgb:282828" # fg: bufname
    declare-option -hidden str powerline_color01 "rgb:a89984" # bg: position
    declare-option -hidden str powerline_color02 "rgb:bdae93" # fg: git
    declare-option -hidden str powerline_color03 "rgb:a89984" # bg: bufname
    declare-option -hidden str powerline_color04 "rgb:3c3836" # bg: git
    declare-option -hidden str powerline_color05 "rgb:282828" # fg: position
    declare-option -hidden str powerline_color06 "rgb:bdae93" # fg: line-column
    declare-option -hidden str powerline_color07 "rgb:d5c4a1" # fg: mode-info
    declare-option -hidden str powerline_color08 "rgb:3c3836" # base background
    declare-option -hidden str powerline_color09 "rgb:504945" # bg: line-column
    ...
    declare-option -hidden str powerline_color30 "rgb:7c6f64" # unused
    declare-option -hidden str powerline_color31 "rgb:fbf1c7" # unused
}
```

That is, themes for **powerline.kak** are commands, that define colors in these
variables. Each module has foreground and background assets. Note that modifiers
like **bold** are not supported yet. I'm thinking about it. When defining a
theme, please make sure that text at the end of your command and string that you
add to the `powerline_themes` are exactly the same:

```kak
set-option -add global powerline_themes "base16-gruvbox"
define-command   -hidden powerline-theme-base16-gruvbox %{...}
#                                        ^^^^^^^^^^^^^^
#                                       This is important
```

If they are the same **powerline.kak** will show you completion items with
correct theme name and execute this command for you. No need to execute this
command manually. All you need to do is `powerline-theme base16-gruvbox`.

Also make sure to declare empty hidden option to store themes to make it
possible to load the plugin in any order:

```kak
declare-option -hidden str-list powerline_themes
```

There are 32 default colors available for modules. 16 of them are reserved by
default **powerline.kak** modules. Each module should use only two colors - one
for foreground and one for background, and only those which are not used by
other modules, if possible. These colors are used by default modules:

| Module Name | Foreground |        Background |
|:------------|-----------:|------------------:|
| bufname     |    color00 |           color03 |
| client      |    color12 |           color13 |
| filetype    |    color10 |           color11 |
| git         |    color02 |           color04 |
| line-column |    color06 |           color09 |
| mode-info   |    color07 | base_bg (color08) |
| position    |    color05 |           color01 |
| session     |    color14 |           color15 |

Colors from `color16` to `color31` are declared by the main script, but not used
by any of default modules so you could use them in your own modules. Make sure
to add comment which module uses those colors if you want to submit your module
to **powerline.kak**.

## Writing a module
This is bit tricky part, but you can add your own modules to powerline. To
create a module you need this things:

- declare Boolean option for toggling module on and off.
- declare string option for contents of the module within the powerline.
- define an update command (if your module needs to be updated frequently).
  - create update hooks to update module when something related to it happens.
- define a module command itself.
- add module name to global list of modules.
- wrap a module into a `provide-module` and require it with `ModuleLoad` hook.

Here's an example of adding a module that shows current position within edited
file in percents. This module already exists in **powerline.kak** but still can
be a good example, because it is not existing functionality in Kakoune itself,
and needs an update function.

First, lets declare `hidden` option of `str` type, that will store our position:

```kak
declare-option -hidden str powerline_position ''
```

We're not giving it a default value, since our next command will handle it:

```kak
define-command -hidden powerline-update-position %{ set-option window powerline_position %sh{
    echo "$(($kak_cursor_line * 100 / $kak_buf_line_count))%"
}}
```

As you can see, we're using `set-option` in context of a `window` to update our
`powerline_pos_percent` variable, because we don't want to update position in
another window while scrolling the only one of them. Now we need a `hook` that
will update it only when needed.

```kak
hook -once -group powerline global KakBegin .* %{
    hook -group powerline global NormalKey (j|k) powerline-update-position
    hook -group powerline global NormalIdle .* powerline-update-position
}
```

So after `global` `KakBegin` event happens we're defining two more hooks - first
to update it frequently while we move with <kbd>j</kbd> and <kbd>k</kbd> and
second to update it via timeout, so it could show actual position after jumps
and searches.

Now we need a **module** command. In **powerline.kak** every module that you see
in your modeline is actually a command, that is being called once when
**powerline.kak** builds modeline for you. In this case, percent position is
already an existing module, so here's how it is defined:

```kak
define-command -hidden powerline-position %{ evaluate-commands %sh{
    default=$kak_opt_powerline_base_bg
    next_bg=$kak_opt_powerline_next_bg
    normal=$kak_opt_powerline_separator
    thin=$kak_opt_powerline_separator_thin
    if [ "$kak_opt_powerline_module_position" = "true" ]; then
        bg=$kak_opt_powerline_position_bg
        fg=$kak_opt_powerline_position_fg
        [ "$next_bg" = "$bg" ] && separator="{$fg,$bg}$thin" || separator="{$bg,${next_bg:-$default}}$normal"
        echo "set-option -add global powerlinefmt %{$separator{$fg,$bg} ≣ %opt{powerline_position} }"
        echo "set-option global powerline_next_bg $bg"
    fi
}}

set-option -add global powerline_modules 'position'
```

There's a lot going on, so lets breakdown it.

First, we define a `hidden` command, called `powerline-position`, that will be
called by powerline, when `powerline-build` is executed.

In this command we use `evaluate-commands %sh{...}` pattern, because modules
involve some logic inside them to properly display colors and different
separators.

In this shell expansion we're declaring four variables:

- `default` - a default color for modeline if no color is specified, which must
  be set to `$kak_opt_powerline_base_bg`, since it matches default modeline
  background color for current colorscheme
- `next_bg` - a tricky variable that will tell next module what background color
  it should use for it's separator. This is very important part, since without
  it smooth transition between modules isn't possible. It must be set to
  `$kak_opt_powerline_next_bg` which will be explained later.
- `normal` - a separator with solid body.
- `thin` - a separator with thin body.

After that we have `if` statement, that ensures that module isn't toggled `off`,
and we actually need to draw our module in powerline. And if it is `on`, we do
the following:

- Declare two more variables for `$bg` is background and `$fg` is foreground
  colors, that are set to current module color. this is used to keep lines
  little more short, since variables have pretty long names.
- Define tricky `if` statement that will choose what kind of separator will be
  used depending on our surroundings: if current background color and `next_bg`
  are the same - use `$thin` separator with these `$fg` and `$bg` colors. If
  not - then use `$normal` which will be colored in reversed format with `$bg`
  as foreground and `$next_bg` is background, and if `next_bg` is empty, use
  `$default` color. This statement can be copied to your module, because it is
  the same for every module.
- Finally do two more things: add `%{$separator{$fg,$bg} ≣
  %opt{powerline_pos_percent} }` string to the end of `powerlinefmt` variable,
  which will later be passed to `modelinefmt`, and set the next background color
  to current background color.

Now, when we have our module command written we still need one more thing: a
toggle command.

A toggle command will be used to toggle our module on and off when we don't need
it, but still want it to be in modeline. For example we may not need to know ow
percent position in `*grep*` buffer. The command is defined like so:

```kak
define-command -hidden powerline-toggle-position -params ..1 %{ evaluate-commands %sh{
    [ "$kak_opt_powerline_module_position" = "true" ] && value=false || value=true
    if [ -n "$1" ]; then
        [ "$1" = "on" ] && value=true || value=false
    fi
    echo "set-option global powerline_module_position $value"
    echo "powerline-rebuild"
}}
```

This command has one optional parameter for `on` and `off` switches which are
checked inside of it.

That is. This is how you add a module to **powerline.kak**. So if you're writing
a plugin, you can have this code inside your plugin, or you can send a PR with
it and it will be included to **powerline.kak** as a separate module. But how
would **powerline.kak** know how to execute these commands?

That's a good question. Remember when we added our module name to global module
list with:

```kak
set-option -add global powerline_modules 'position'
```

This allows **powerline.kak** to reconstruct proper command for you, because it
knows base name which is `powerline-toggle-` and a module name which is
`position`. So when you call `powerline-toggle position` it combines those two
and calls `powerline-toggle-position` for you. All other commands are handled in
the same way.

[1]: https://img.shields.io/github/license/andreyorst/powerline.kak.svg
[2]: https://img.shields.io/github/release/andreyorst/powerline.kak.svg
[3]: https://github.com/andreyorst/powerline.kak/releases
[4]: https://img.shields.io/github/release-date/andreyorst/powerline.kak.svg
[5]: https://github.com/andreyorst/powerline.kak/releases
[6]: https://img.shields.io/github/commits-since/andreyorst/powerline.kak/latest.svg
[7]: https://user-images.githubusercontent.com/19470159/47966105-ae902f80-e05f-11e8-8ca4-76213449d3b8.png
[8]: https://github.com/andreyorst/plug.kak
