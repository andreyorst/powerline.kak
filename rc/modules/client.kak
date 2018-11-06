# ╭─────────────╥────────────────────────╮
# │ Author:     ║ File:                  │
# │ Andrey Orst ║ client.kak             │
# ╞═════════════╩════════════════════════╡
# │ Client module for powerline.kak      │
# ╞══════════════════════════════════════╡
# │ GitHub.com/andreyorst/powerline.kak  │
# ╰──────────────────────────────────────╯

set-option -add global powerline_modules 'client'

declare-option -hidden bool powerline_module_client true

define-command -hidden powerline-client %{ evaluate-commands %sh{
    default=$kak_opt_powerline_base_bg
    next_bg=$kak_opt_powerline_next_bg
    normal=$kak_opt_powerline_separator
    thin=$kak_opt_powerline_separator_thin
    if [ "$kak_opt_powerline_module_client" = "true" ]; then
        bg=$kak_opt_powerline_client_bg
        fg=$kak_opt_powerline_client_fg
        [ "$next_bg" = "$bg" ] && separator="{$fg,$bg}$thin" || separator="{$bg,${next_bg:-$default}}$normal"
        echo "set-option -add global powerlinefmt %{$separator{$fg,$bg} %val{client} }"
        echo "set-option global powerline_next_bg $bg"
    fi
}}

define-command -hidden powerline-toggle-client -params ..1 %{ evaluate-commands %sh{
    [ "$kak_opt_powerline_module_client" = "true" ] && value=false || value=true
    if [ -n "$1" ]; then
        [ "$1" = "on" ] && value=true || value=false
    fi
    echo "set-option global powerline_module_client $value"
    echo "powerline-rebuild"
}}

