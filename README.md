# powerline.kak

![license][1]
[![GitHub release][2]][3]
[![GitHub Release Date][4]][5]
![GitHub commits (since latest release)][6]

Powerline plugin for Kakoune Editor.

![image][7]

This plugin aims to make Kakoune's modeline more context dependent and beautiful.
**powerline.kak** provides coloring, separators, toggling commands, support for git, and a modular system to easily extend `powerline.kak` with new modules.
Some modules, like _git_ and _filetype_, are shown only if they're available.
For example, the _filetype_ module won't display if Kakaoune can't detect a file's type.
Also, if you're editing a file without write access, **powerline.kak** will display a lock symbol near the filename.

## Installation

### With [plug.kak][8]

Add this to your `kakrc`:

``` kak
plug "andreyorst/powerline.kak" defer powerline_gruvbox %{
    powerline-theme gruvbox
} config %{
    powerline-start
}
```

Source your `kakrc`, or restart Kakoune.
Then execute `:plug-install`.
Or, if you don't want to source the configuration file or restart Kakoune, simply run `plug-install andreyorst/powerline.kak`.
Lastly, run `powerline-start` to activate it.

### Without plugin manager

#### Autoload

Clone, or place a symbolic link to, the repository into your `autoload` directory.
In your `kakrc`, add `powerline-start`.
Then, under this, add:
```
hook global BufOpenFile .* expandtab
hook global BufNewFile  .* expandtab
```
The plugin should now load without any problems.
If any errors appear, please open an issue.

#### By hand

Clone this repository somewhere

``` bash
mkdir -p ~/.config/kak/plugins
git clone https://github.com/andreyorst/powerline.kak.git ~/.config/kak/plugins/
```

Source the main script in your `kakrc`:

``` kak
source "%val{config}/plugins/powerline.kak/rc/powerline.kak"
```

Source modules.
You can skip those you don't want,
but it's highly recommended to source at least `bufname.kak` and `mode_info.kak`:

``` kak
source "%val{config}/plugins/powerline.kak/rc/modules/bufname.kak"
source "%val{config}/plugins/powerline.kak/rc/modules/client.kak"
source "%val{config}/plugins/powerline.kak/rc/modules/filetype.kak"
source "%val{config}/plugins/powerline.kak/rc/modules/git.kak"
source "%val{config}/plugins/powerline.kak/rc/modules/line_column.kak"
source "%val{config}/plugins/powerline.kak/rc/modules/mode_info.kak"
source "%val{config}/plugins/powerline.kak/rc/modules/position.kak"
source "%val{config}/plugins/powerline.kak/rc/modules/session.kak"
source "%val{config}/plugins/powerline.kak/rc/modules/lsp.kak"
```

And source the theme you want to use:

``` kak
source "%val{config}/plugins/powerline.kak/rc/themes/base16-gruvbox.kak"
```

After that, you can enable powerline with:

``` kak
powerline-start
```

If you want to use built-in themes, you'll need to source theme from the `rc/themes` folder.
This is kind of a tedious thing to do.
That's why I recommend using a plugin manager,
since it handles all the theming and configuration for you.

After that, you can use **powerline.kak**.

## Configuration

**powerline.kak** supports these **commands**:
- `powerline-toggle` - toggle powerline on and off,
by restoring the pre-powerline value of `modelinefmt`.
- `powerline-toggle-module` - toggle a powerline module `on` and `off`.
- `powerline-separator` - change the separators for powerline.kak.
In order to use powerline icons, you need a powerline compatible font.
This is the full list of supported separators:
  - ASCII separators: `ascii-arrow`, `ascii-triangle`,
    `ascii-triangle-inverted`.
  - Extended ASCII separators: `bars`, `full-step`, `half-step`, `quarter-step`.
  - Powerline separators: `arrow`, `curve`, `flame`, `triangle`,
    `triangle-inverted`.
  - `random` - randomly selects one from above.
  - `custom` - use your own separators. Supports both normal and thin variants.
  - `none` - no separators.
- `powerline-theme` - change powerline's theme.
- `powerline-format` - change the ordering of modules.
- `powerline-rebuild` - reconstruct powerline according to options,
sometimes needed when you modify options directly.

These **options** are also available to set,
either from within a Kakoune buffer,
or else in your `kakrc`:
- `powerline_separator` - values are the same as those above.
- `powerline_separator_thin` - set thin separator via option.
- `powerline_format` - available modules are:
git, bufname, line_column, mode_info, filetype, client, session, position, lsp
- `powerline_ignore_warnings` - makes powerline ignore warnings when building itself.
- `powerline_shorten_bufname` - display `bufname` in three different ways:
`full`, `short`, and `name`.

All **powerline.kak** settings executed with commands are applied by default in the context of a buffer;
therefore, you can have different powerlines for different buffers.
However, a `scope` can be passed to these commands to set these options at the buffer, window, or global scope.
For example, `powerline-separator global triangle` runs `powerline-separator` on a _global_ scope,
which applies to all buffers, instead of just the current one.

### Example configuration using **plug.kak**

``` kak
 defer powerline %{
    powerline-format global 'git bufname filetype mode_info line_column position'
    powerline-toggle line_column off} defer powerline_bufname %{
    set-option global powerline_shorten_bufname 'short'
} defer powerline_gruvbox %{
    powerline-theme gruvbox
} config %{
    powerline-start
}
```

Lets break this down:
- `plug` is a [plug.kak][8] command that loads **powerline.kak** plugin and
  configures it with `defer powerline %{...}` expansion. Deferring means that
  all these configurations will be loaded only when the `powerline` module
  loads.
  - `powerline-format global 'git bufname filetype mode_info line_column position'` - sets
    the format of powerline, by adding only git, buffer name, filetype,
    information about mode, line_column and file position in percents.
  - `powerline-toggle line_column off` - disables part of powerline which shows
    current line and column. Again, you can have this disabled or enabled for
    certain filetypes or buffers via `hook`s , etc.
- Next, another `defer` that will be executed when theme module is loaded.
  - `powerline-theme gruvbox` - sets the theme to `gruvbox`.
- Lastly in `config` block we use `powerline-start` command that loads the
  module, and setups everything. Note that `powerline-start` should be called at
  Kakoune initialization, thus placing it in `config` block is appropriate. If
  you want to start powerline manually with some hooks you should
  `require-module powerline` and then use `powerline-enable` instead.

You can add your own configurations here. Since all settings are
buffer-dependent you can have different settings for different buffers,
filetypes, etc.

### Example configuration using **kakrc**
```
require-module powerline
set-option global powerline_format 'git bufname filetype mode_info lsp'
set-option global powerline_shorten_bufname name
powerline-start
hook global BufOpenFile .* expandtab
hook global BufNewFile  .* expandtab
```

## Making themes

You can create your own themes for **powerline.kak**. Here's an example of a good
theme:

``` kak
# base16-gruvbox colorscheme for powerline.kak
# based on https://github.com/andreyorst/base16-gruvbox.kak

hook global ModuleLoaded powerline %{ require-module powerline_base16_gruvbox }

provide-module powerline_base16_gruvbox %§
set-option -add global powerline_themes "base16-gruvbox"

define-command -hidden powerline-theme-base16-gruvbox %{
    declare-option -hidden str powerline_color00 "rgb:282828" # fg: bufname
    declare-option -hidden str powerline_color01 "rgb:a89984" # bg: position
    declare-option -hidden str powerline_color02 "rgb:bdae93" # fg: git
    declare-option -hidden str powerline_color03 "rgb:a89984" # bg: bufname
    declare-option -hidden str powerline_color04 "rgb:3c3836" # bg: git
    declare-option -hidden str powerline_color05 "rgb:282828" # fg: position
    declare-option -hidden str powerline_color06 "rgb:bdae93" # fg: line-column, lsp
    declare-option -hidden str powerline_color07 "rgb:d5c4a1" # fg: mode-info
    declare-option -hidden str powerline_color08 "rgb:3c3836" # base background
    declare-option -hidden str powerline_color09 "rgb:504945" # bg: line-column, lsp
    ...
    declare-option -hidden str powerline_color30 "rgb:7c6f64" # unused
    declare-option -hidden str powerline_color31 "rgb:fbf1c7" # unused

    declare-option -hidden str powerline_next_bg %opt{powerline_color08}
    declare-option -hidden str powerline_base_bg %opt{powerline_color08}
}

§
```

That is, themes for **powerline.kak** are commands, that define colors in these
variables. Each module has foreground and background assets. Note that modifiers
like **bold** are not supported. When defining a theme, please make sure that text
at the end of your command and string that you add to the `powerline_themes` are
exactly the same:

``` kak
set-option -add global powerline_themes "base16-gruvbox"
define-command   -hidden powerline-theme-base16-gruvbox %{...}
#                                        ^^^^^^^^^^^^^^
#                                       This is important
#                                     These must be the same
```

If they are the same **powerline.kak** will show you completion items with
correct theme name and execute this command for you. No need to execute this
command manually. All you need to do is `powerline-theme base16-gruvbox`.

Also make sure to put theme into appropriate module, and require it after main
module is loaded via hook:

``` kak
hook global ModuleLoaded powerline %{ require-module powerline_base16_gruvbox }
```

There are 32 default colors available for modules. 16 of them are reserved by
default **powerline.kak** modules. Each module should use only two colors - one
for foreground and one for background, and only those which are not used by
other modules, if possible. These colors are used by default modules:

| Module Name | Foreground |        Background |
|:------------|-----------:|------------------:|
| bufname     |    color00 |           color03 |
| client      |    color13 |           color12 |
| filetype    |    color10 |           color11 |
| git         |    color02 |           color04 |
| line-column |    color06 |           color09 |
| mode-info   |    color07 | base_bg (color08) |
| position    |    color05 |           color01 |
| session     |    color15 |           color14 |
| lsp         |    color06 |           color09 |

Colors from `color16` to `color31` are declared by the main script, but not used
by any of default modules so you could use them in your own modules. Make sure
to add comment which module uses those colors if you want to submit your module
to **powerline.kak**.

## Writing a module

This is a bit trickier than writing themes, but you can add your own modules to
powerline. To create a module you need the following things:

- declare Boolean option for toggling module on and off.
- declare string option for contents of the module within the powerline.
- define an update command (if your module needs to be updated frequently).
  - create update hooks to update module when something related to it happens.
- define a module command itself.
- add module name to global list of modules.
- wrap a module into a `provide-module` and require it with `ModuleLoaded` hook.

Here's an example of adding a module that shows current position within edited
file in percents. This module already exists in **powerline.kak** but still can
be a good example, because it is not existing functionality in Kakoune itself,
and needs an update function.

First, lets declare `hidden` option of `str` type, that will store our position:

``` kak
declare-option -hidden str powerline_position ''
```

We're not giving it a default value, since our next command will handle it:

``` kak
define-command -hidden powerline-update-position %{ set-option window powerline_position %sh{
    echo "$(($kak_cursor_line * 100 / $kak_buf_line_count))%"
}}
```

As you can see, we're using `set-option` in context of a `window` to update our
`powerline_pos_percent` variable, because we don't want to update position in
another window while scrolling the only one of them. Now we need a `hook` that
will update it only when needed. To declare hooks you need to create a function
that has this template name `powerline-MODULENAME-setup-hooks`. It will be
called automatically by `powerline.kak`.

``` kak
define-command powerline-position-setup-hooks %{
    remove-hooks global powerline-position
    evaluate-commands %sh{
        if [ "$kak_opt_powerline_module_position" = "true" ]; then
            printf "%s\n" "hook -group powerline-position global NormalKey [jk] powerline-update-position"
            printf "%s\n" "hook -group powerline-position global NormalIdle .*  powerline-update-position"
        fi
    }
}
```

This way `powerline.kak` will be able to automatically call this function
whenever powerline is being rebuild and define these hooks - first to update it
frequently while we move with <kbd>j</kbd> and <kbd>k</kbd> and second to update
it via timeout, so it could show actual position after jumps and searches.

Now we need a **module** command. In **powerline.kak** every module that you see
in your modeline is actually a command, that is being called once when
**powerline.kak** builds modeline for you. In this case, percent position is
already an existing module, so here's how it is defined:

``` kak
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

There's a lot going on, so lets break it down.

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
  it should use for it's separator. This is very important, since without it
  smooth transition between modules isn't possible. It must be set to
  `$kak_opt_powerline_next_bg` which will be explained later.
- `normal` - a separator with solid body.
- `thin` - a separator with thin body.

After that we have an `if` statement, that ensures that module isn't toggled `off`,
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

``` kak
define-command -hidden powerline-toggle-position -params ..1 %{ evaluate-commands %sh{
    [ "$kak_opt_powerline_module_position" = "true" ] && value=false || value=true
    if [ -n "$1" ]; then
        [ "$1" = "on" ] && value=true || value=false
    fi
    echo "set-option global powerline_module_position $value"
}}
```

This command has one optional parameter for `on` and `off` switches which are
checked inside of it.

This is how you add a module to **powerline.kak**. So, if you're writing
a plugin, you can have this code inside your plugin, or you can send a PR with
it and it will be included to **powerline.kak** as a separate module. But how
would **powerline.kak** know how to execute these commands?

That's a good question. Remember when we added our module name to global module
list with:

``` kak
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

<!--  LocalWords:  Powerline Kakoune Kakoune's modeline filetype kak
      LocalWords:  powerline Autoload pre powerlines filetypes lsp
      LocalWords:  bufname kbd colorscheme
 -->
