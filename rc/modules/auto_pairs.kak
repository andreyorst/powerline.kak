# ╭─────────────╥────────────────────────╮
# │ Author:     ║ File:                  │
# │ Andrey Orst ║ auto_pairs.kak         │
# ╞═════════════╩════════════════════════╡
# │ Auto Pairs module for powerline.kak  │
# │ Depends on autopairs.kak script by   │
# │ alexherbo2. Plugin can be found at   │
# │ GitHub.com/alexherbo2/auto-pairs.kak │
# ╞══════════════════════════════════════╡
# │ GitHub.com/andreyorst/powerline.kak  │
# ╰──────────────────────────────────────╯

declare-option -hidden str powerline_auto_pairs 'surround'
declare-option -hidden bool powerline_module_auto_pairs true
set-option -add global powerline_modules 'auto_pairs'

define-command -hidden powerline-update-auto-pairs %{ evaluate-commands %sh{
    if [ "$kak_opt_auto_pairs_surround_enabled" = "true" ]; then
        echo "powerline-toggle auto_pairs on"
    else
        echo "powerline-toggle auto_pairs off"
    fi
}}

hook -group powerline global WinCreate .* %{
    powerline-update-auto-pairs
    hook -group powerline window ModeChange 'normal:insert' powerline-update-auto-pairs
    hook -group powerline window ModeChange 'insert:normal' %{powerline-toggle auto_pairs off}
}

define-command -hidden powerline-auto-pairs %{ evaluate-commands %sh{
    default=$kak_opt_powerline_base_bg
    next_bg=$kak_opt_powerline_next_bg
    normal=$kak_opt_powerline_separator
    thin=$kak_opt_powerline_separator_thin
    if [ "$kak_opt_powerline_module_auto_pairs" = "true" ]; then
        bg=$kak_opt_powerline_mode_info_bg
        fg=$kak_opt_powerline_mode_info_fg
        [ "$next_bg" = "$bg" ] && separator="{$fg,$bg}$thin" || separator="{$bg,${next_bg:-$default}}$normal"
        echo "set-option -add window powerlinefmt %{$separator{$fg,$bg} %opt{powerline_auto_pairs} }"
        echo "set-option window powerline_next_bg $bg"
    fi
}}

define-command -hidden powerline-toggle-auto-pairs -params ..1 %{ evaluate-commands %sh{
    [ "$kak_opt_powerline_module_auto_pairs" = "true" ] && value=false || value=true
    if [ -n "$1" ]; then
        [ "$1" = "on" ] && value=true || value=false
    fi
    echo "set-option global powerline_module_auto_pairs $value"
    echo "powerline-rebuild"
}}

