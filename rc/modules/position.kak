# ╭─────────────╥────────────────────────╮
# │ Author:     ║ File:                  │
# │ Andrey Orst ║ position.kak           │
# ╞═════════════╩════════════════════════╡
# │ Position module for powerline.kak    │
# ╞══════════════════════════════════════╡
# │ GitHub.com/andreyorst/powerline.kak  │
# ╰──────────────────────────────────────╯

set-option -add global powerline_modules 'position'

declare-option -hidden bool powerline_module_position true

declare-option -hidden str powerline_position ''
define-command -hidden powerline-update-position %{ evaluate-commands %sh{
    position="$(($kak_cursor_line * 100 / $kak_buf_line_count))%"
    if [ "$kak_opt_powerline_position_text_format" = "true" ]; then
        if [ "$position" = "100%" ]; then
            position="bottom"
        elif [ $kak_cursor_line -eq 1 ]; then
            position="top"
        fi
    fi
    echo "set-option window powerline_position $position"
}}

hook -once -group powerline global KakBegin .* %{
    hook -group powerline global NormalKey (j|k) powerline-update-position
    hook -group powerline global NormalIdle .* powerline-update-position
}

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

define-command -hidden powerline-toggle-position -params ..1 %{ evaluate-commands %sh{
    [ "$kak_opt_powerline_module_position" = "true" ] && value=false || value=true
    if [ -n "$1" ]; then
        [ "$1" = "on" ] && value=true || value=false
    fi
    echo "set-option global powerline_module_position $value"
    echo "powerline-rebuild"
}}

