# ╭─────────────╥────────────────────────╮
# │ Author:     ║ File:                  │
# │ Andrey Orst ║ line_column.kak        │
# ╞═════════════╩════════════════════════╡
# │ Line Column module for powerline.kak │
# ╞══════════════════════════════════════╡
# │ GitHub.com/andreyorst/powerline.kak  │
# ╰──────────────────────────────────────╯

hook global ModuleLoaded powerline %{ require-module powerline_line_column }

provide-module powerline_line_column %§

declare-option -hidden bool powerline_module_line_column true
set-option -add global powerline_modules 'line_column'

define-command -hidden powerline-line-column %{ evaluate-commands %sh{
    default=$kak_opt_powerline_base_bg
    next_bg=$kak_opt_powerline_next_bg
    normal=$kak_opt_powerline_separator
    thin=$kak_opt_powerline_separator_thin
    if [ "$kak_opt_powerline_module_line_column" = "true" ]; then
        fg=$kak_opt_powerline_color06
        bg=$kak_opt_powerline_color09
        [ "$next_bg" = "$bg" ] && separator="{$fg,$bg}$thin" || separator="{$bg,${next_bg:-$default}@powerline_base}$normal"
        printf "%s\n" "set-option -add global powerlinefmt %{$separator{$fg,$bg} %val{cursor_line}{$fg,$bg}:{$fg,$bg}%val{cursor_char_column} }"
        printf "%s\n" "set-option global powerline_next_bg $bg"
    fi
}}

define-command -hidden powerline-toggle-line-column -params ..1 %{ evaluate-commands %sh{
    [ "$kak_opt_powerline_module_line_column" = "true" ] && value=false || value=true
    if [ -n "$1" ]; then
        [ "$1" = "on" ] && value=true || value=false
    fi
    printf "%s\n" "set-option global powerline_module_line_column $value"
}}

§
