# ╭─────────────╥────────────────────────╮
# │ Author:     ║ File:                  │
# │ Andrey Orst ║ session.kak            │
# ╞═════════════╩════════════════════════╡
# │ Session module for powerline.kak     │
# ╞══════════════════════════════════════╡
# │ GitHub.com/andreyorst/powerline.kak  │
# ╰──────────────────────────────────────╯

hook global ModuleLoad powerline %{ require-module powerline_session }

provide-module powerline_session %§

declare-option -hidden bool powerline_module_session true
set-option -add global powerline_modules 'session'

define-command -hidden powerline-session %{ evaluate-commands %sh{
    default=$kak_opt_powerline_base_bg
    next_bg=$kak_opt_powerline_next_bg
    normal=$kak_opt_powerline_separator
    thin=$kak_opt_powerline_separator_thin
    if [ "$kak_opt_powerline_module_session" = "true" ]; then
        bg=$kak_opt_powerline_color14
        fg=$kak_opt_powerline_color15
        [ "$next_bg" = "$bg" ] && separator="{$fg,$bg}$thin" || separator="{$bg,${next_bg:-$default}}$normal"
        echo "set-option -add global powerlinefmt %{$separator{$fg,$bg} %val{session} }"
        echo "set-option global powerline_next_bg $bg"
    fi
}}

define-command -hidden powerline-toggle-session -params ..1 %{ evaluate-commands %sh{
    [ "$kak_opt_powerline_module_session" = "true" ] && value=false || value=true
    if [ -n "$1" ]; then
        [ "$1" = "on" ] && value=true || value=false
    fi
    echo "set-option global powerline_module_session $value"
    echo "powerline-rebuild"
}}

§
