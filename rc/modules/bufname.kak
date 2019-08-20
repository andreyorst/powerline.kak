# ╭─────────────╥────────────────────────╮
# │ Author:     ║ File:                  │
# │ Andrey Orst ║ bufname.kak            │
# ╞═════════════╩════════════════════════╡
# │ Buffer name and context info module  │
# │ for powerline.kak                    │
# ╞══════════════════════════════════════╡
# │ GitHub.com/andreyorst/powerline.kak  │
# ╰──────────────────────────────────────╯

hook global ModuleLoaded powerline %{ require-module powerline_bufname }

provide-module powerline_bufname %§

declare-option -hidden bool powerline_module_bufname true
set-option -add global powerline_modules 'bufname'

define-command -hidden powerline-bufname %{ evaluate-commands %sh{
    default=$kak_opt_powerline_base_bg
    next_bg=$kak_opt_powerline_next_bg
    normal=$kak_opt_powerline_separator
    thin=$kak_opt_powerline_separator_thin
    if [ "$kak_opt_powerline_module_bufname" = "true" ]; then
        fg=$kak_opt_powerline_color00
        bg=$kak_opt_powerline_color03
        [ "$next_bg" = "$bg" ] && separator="{$fg,$bg}$thin" || separator="{$bg,${next_bg:-$default}}$normal"
        echo "set-option -add global powerlinefmt %{$separator{$fg,$bg} %val{bufname}{{context_info}}%opt{powerline_readonly} }"
        echo "set-option global powerline_next_bg $bg"
    fi
}}

declare-option -hidden str powerline_readonly
define-command -hidden powerline-update-readonly %{ set-option buffer powerline_readonly %sh{
    if [ -w "${kak_buffile}" ]; then
        echo ''
    else
        echo ' '
    fi
}}

hook -group powerline global WinDisplay .* powerline-update-readonly
hook -group powerline global BufWritePost .* powerline-update-readonly

define-command -hidden powerline-toggle-bufname -params ..1 %{ evaluate-commands %sh{
    [ "$kak_opt_powerline_module_bufname" = "true" ] && value=false || value=true
    if [ -n "$1" ]; then
        [ "$1" = "on" ] && value=true || value=false
    fi
    echo "set-option global powerline_module_bufname $value"
    echo "powerline-rebuild"
}}

§
