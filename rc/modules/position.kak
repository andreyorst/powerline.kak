# ╭─────────────╥────────────────────────╮
# │ Author:     ║ File:                  │
# │ Andrey Orst ║ position.kak           │
# ╞═════════════╩════════════════════════╡
# │ Position module for powerline.kak    │
# ╞══════════════════════════════════════╡
# │ GitHub.com/andreyorst/powerline.kak  │
# ╰──────────────────────────────────────╯

hook global ModuleLoaded powerline %{ require-module powerline_position }

provide-module powerline_position %§

declare-option -docstring "if 'true' additionally display text formatted position in file, like 'top', 'mid', and  'bot'" \
bool powerline_position_text_format false

declare-option -docstring "if 'true' display minimap-like position in file" \
bool powerline_position_minimap_format false

set-option -add global powerline_modules 'position'
declare-option -hidden bool powerline_module_position true
declare-option -hidden str powerline_position ''


define-command -hidden powerline-update-position %{ evaluate-commands %sh{ (
    position="$(($kak_cursor_line * 100 / $kak_buf_line_count))%"
    if [ "$kak_opt_powerline_position_text_format" = "true" ]; then
        if [ ${position%%%} -gt 90 ]; then
            position="bot"
        elif [ ${position%%%} -gt 40 ] && [ ${position%%%} -lt 60 ]; then
            position="mid"
        elif [ ${position%%%} -lt 10 ]; then
            position="top"
        fi
    fi
    if [ "$kak_opt_powerline_position_minimap_format" = "true" ]; then
        if [ ${position%%%} -ge 90 ]; then
            position="⣀"
        elif [ ${position%%%} -ge 75 ] && [ ${position%%%} -lt 90 ]; then
            position="⣤"
        elif [ ${position%%%} -ge 60 ] && [ ${position%%%} -lt 75 ]; then
            position="⠤"
        elif [ ${position%%%} -ge 45 ] && [ ${position%%%} -lt 60 ]; then
            position="⠶"
        elif [ ${position%%%} -ge 30 ] && [ ${position%%%} -lt 45 ]; then
            position="⠒"
        elif [ ${position%%%} -ge 15 ] && [ ${position%%%} -lt 30 ]; then
            position="⠛"
        elif [ ${position%%%} -lt 15 ]; then
            position="⠉"
        fi
    fi
    echo "evaluate-commands -buffer $kak_bufname %{ set-option buffer powerline_position '$position' }" | kak -p $kak_session
) >/dev/null 2>&1 </dev/null & }}

define-command -hidden powerline-position %{ evaluate-commands %sh{
    default=$kak_opt_powerline_base_bg
    next_bg=$kak_opt_powerline_next_bg
    normal=$kak_opt_powerline_separator
    thin=$kak_opt_powerline_separator_thin
    if [ "$kak_opt_powerline_module_position" = "true" ]; then
        bg=$kak_opt_powerline_color01
        fg=$kak_opt_powerline_color05
        [ "$next_bg" = "$bg" ] && separator="{$fg,$bg}$thin" || separator="{$bg,${next_bg:-$default}}$normal"
        printf "%s\n" "set-option -add global powerlinefmt %{$separator{$fg,$bg} ≣ %opt{powerline_position} }"
        printf "%s\n" "set-option global powerline_next_bg $bg"

        printf "%s\n" "hook -group powerline-position global WinDisplay .* powerline-update-position"
        printf "%s\n" "hook -group powerline-position global NormalKey (j|k) powerline-update-position"
        printf "%s\n" "hook -group powerline-position global NormalIdle .* powerline-update-position"
    fi
}}

define-command -hidden powerline-toggle-position -params ..1 %{ evaluate-commands %sh{
    [ "$kak_opt_powerline_module_position" = "true" ] && value=false || value=true
    if [ -n "$1" ]; then
        [ "$1" = "on" ] && value=true || value=false
    fi
    if [ "$value" = "true" ]; then
        printf "%s\n" "hook -group powerline-position global WinDisplay .* powerline-update-position"
        printf "%s\n" "hook -group powerline-position global NormalKey (j|k) powerline-update-position"
        printf "%s\n" "hook -group powerline-position global NormalIdle .* powerline-update-position"
    else
        printf "%s\n" "remove-hooks global powerline-position"
    fi
    echo "set-option global powerline_module_position $value"
    echo "powerline-rebuild"
}}

§
