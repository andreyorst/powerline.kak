# ╭─────────────╥────────────────────────╮
# │ Author:     ║ File:                  │
# │ Andrey Orst ║ auto_pairs.kak         │
# ╞═════════════╩════════════════════════╡
# │ Filetype module for powerline.kak    │
# ╞══════════════════════════════════════╡
# │ GitHub.com/andreyorst/powerline.kak  │
# ╰──────────────────────────────────────╯

declare-option -hidden bool powerline_module_filetype true

set-option -add global powerline_modules 'filetype'

define-command -hidden powerline-filetype %{ evaluate-commands %sh{
    default=$kak_opt_powerline_base_bg
    next_bg=$kak_opt_powerline_next_bg
    normal=$kak_opt_powerline_separator
    thin=$kak_opt_powerline_separator_thin
    if [ "$kak_opt_powerline_module_filetype" = "true" ]; then
        bg=$kak_opt_powerline_filetype_bg
        fg=$kak_opt_powerline_filetype_fg
        if [ ! -z "$kak_opt_filetype" ]; then
        [ "$next_bg" = "$bg" ] && separator="{$fg,$bg}$thin" || separator="{$bg,${next_bg:-$default}}$normal"
            echo "set-option -add window powerlinefmt %{$separator{$fg,$bg} %opt{filetype} }"
            echo "set-option window powerline_next_bg $bg"
        fi
    fi
}}

define-command -hidden powerline-toggle-filetype -params ..1 %{ evaluate-commands %sh{
    [ "$kak_opt_powerline_module_filetype" = "true" ] && value=false || value=true
    if [ -n "$1" ]; then
        [ "$1" = "on" ] && value=true || value=false
    fi
    echo "set-option global powerline_module_filetype $value"
    echo "powerline-rebuild"
}}

