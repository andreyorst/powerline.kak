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

declare-option -docstring "shorten the name of the buffer accordingly to the setting.
full  - do not shorten buffer name: '/full/path/file'.
short - display short path: '/f/p/file'.
name  - only show the file name: 'file'." \
str powerline_shorten_bufname "full"

define-command -hidden powerline-bufname %{ evaluate-commands %sh{
    default=$kak_opt_powerline_base_bg
    next_bg=$kak_opt_powerline_next_bg
    normal=$kak_opt_powerline_separator
    thin=$kak_opt_powerline_separator_thin
    if [ "$kak_opt_powerline_module_bufname" = "true" ]; then
        fg=$kak_opt_powerline_color00
        bg=$kak_opt_powerline_color03
        [ "$next_bg" = "$bg" ] && separator="{$fg,$bg}$thin" || separator="{$bg,${next_bg:-$default}}$normal"
        printf "%s\n" "set-option -add global powerlinefmt %{$separator{$fg,$bg} %opt{powerline_bufname}{{context_info}}%opt{powerline_readonly} }"
        printf "%s\n" "set-option global powerline_next_bg $bg"
    fi
}}

declare-option -hidden str powerline_readonly
define-command -hidden powerline-update-readonly %{ set-option buffer powerline_readonly %sh{
    if [ ! "${kak_opt_readonly}" = "true" ]; then
        if [ -w "${kak_buffile}" ] || [ -z "${kak_buffile##*\**}" ]; then
            printf "%s\n" ''
            exit
        fi
    fi
    printf "%s\n" '[]'
}}

declare-option -hidden str powerline_bufname
define-command -hidden powerline-update-bufname %{ set-option buffer powerline_bufname %sh{
    case "$kak_opt_powerline_shorten_bufname" in
        (full)
            printf "%s\n" "${kak_bufname}" ;;
        (short)
            [ -z "${kak_bufname##*/*}" ] && short=$(printf "%s" "${kak_bufname%/*}/" | perl -pe 's:(?(?<=/)|(?<=^))([^\p{Letter}\p{Digit}]+.|[^/]).+?/:\1/:g')
            printf "%s\n" "${short}${kak_bufname##*/}" ;;
        (name)
            printf "%s\n" "${kak_bufname##*/}" ;;
    esac
}}

define-command -hidden powerline-bufname-setup-hooks %{
    remove-hooks global powerline-bufname
    evaluate-commands %sh{
        if [ "$kak_opt_powerline_module_bufname" = "true" ]; then
            printf "%s\n" "hook -group powerline-bufname global WinDisplay .* %{ powerline-update-readonly; powerline-update-bufname }"
            printf "%s\n" "hook -group powerline-bufname global BufWritePost .* %{ powerline-update-readonly; powerline-update-bufname }"
            printf "%s\n" "hook -group powerline-bufname global BufSetOption readonly=.+ %{ powerline-update-readonly; powerline-update-bufname }"
            printf "%s\n" "hook -group powerline-bufname global BufSetOption powerline_shorten_bufname=.+ %{ powerline-update-readonly; powerline-update-bufname }"
        fi
    }
}

define-command -hidden powerline-toggle-bufname -params ..1 %{ evaluate-commands %sh{
    [ "$kak_opt_powerline_module_bufname" = "true" ] && value=false || value=true
    if [ -n "$1" ]; then
        [ "$1" = "on" ] && value=true || value=false
    fi
    printf "%s\n" "set-option global powerline_module_bufname $value"
}}

§
