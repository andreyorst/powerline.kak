# ╭─────────────╥───────────────────────╮
# │ Author:     ║ File:                 │
# │ Andrey Orst ║ mode_info.kak         │
# ╞═════════════╩═══════════════════════╡
# │ Mode info module for powerline.kak  │
# ╞═════════════════════════════════════╡
# │ GitHub.com/andreyorst/powerline.kak │
# ╰─────────────────────────────────────╯

hook global ModuleLoaded powerline %{ require-module powerline_mode_info }

provide-module powerline_mode_info %§

set-option -add global powerline_modules 'mode_info'
declare-option -hidden bool powerline_module_mode_info true

define-command -hidden powerline-mode-info %{ evaluate-commands %sh{
    default=$kak_opt_powerline_base_bg
    next_bg=$kak_opt_powerline_next_bg
    normal=$kak_opt_powerline_separator
    thin=$kak_opt_powerline_separator_thin
    if [ "$kak_opt_powerline_module_mode_info" = "true" ]; then
        bg=$kak_opt_powerline_base_bg
        fg=$kak_opt_powerline_color07
        [ "$next_bg" = "$bg" ] && separator="{$fg,$bg}$thin" || separator="{$bg,${next_bg:-$default}@powerline_base}$normal"
        printf "%s\n" "set-option -add global powerlinefmt %{$separator{$fg,$bg} {{mode_info}} }"
        printf "%s\n" "set-option global powerline_next_bg $bg"
    fi
}}

define-command -hidden powerline-toggle-mode-info -params ..1 %{ evaluate-commands %sh{
    [ "$kak_opt_powerline_module_mode_info" = "true" ] && value=false || value=true
    if [ -n "$1" ]; then
        [ "$1" = "on" ] && value=true || value=false
    fi
    printf "%s\n" "set-option global powerline_module_mode_info $value"
}}

§
