# ╭─────────────╥───────────────────────╮
# │ Author:     ║ File:                 │
# │ Andrey Orst ║ git.kak               │
# ╞═════════════╩═══════════════════════╡
# │ Git module for powerline.kak        │
# ╞═════════════════════════════════════╡
# │ GitHub.com/andreyorst/powerline.kak │
# ╰─────────────────────────────────────╯

hook -once global WinSetOption powerline_loaded=true %{ require-module powerline_git }

provide-module powerline_git %§

set-option -add global powerline_modules 'git'

declare-option -hidden bool powerline_module_git true
declare-option -hidden str powerline_branch

define-command -hidden powerline-update-branch %{ set-option window powerline_branch %sh{
    if [ "$kak_opt_powerline_module_git" = "true" ]; then
        branch=$(cd "${kak_buffile%/*}" 2>/dev/null && git rev-parse --abbrev-ref HEAD 2>/dev/null)
    fi
    if [ -n "$branch" ]; then
        echo "$branch "
    else
        echo ""
    fi
}}

hook global WinDisplay .* powerline-update-branch
hook global WinCreate .* powerline-update-branch
hook -once global WinSetOption powerline_branch=.+ %{
    powerline-rebuild
}

define-command -hidden powerline-git %{ evaluate-commands %sh{
    default=$kak_opt_powerline_base_bg
    next_bg=$kak_opt_powerline_next_bg
    normal=$kak_opt_powerline_separator
    thin=$kak_opt_powerline_separator_thin
    if [ "$kak_opt_powerline_module_git" = "true" ]; then
        fg=$kak_opt_powerline_color02
        bg=$kak_opt_powerline_color04
        if [ -n "$kak_opt_powerline_branch" ]; then
            [ "$next_bg" = "$bg" ] && separator="{$fg,$bg}$thin" || separator="{$bg,${next_bg:-$default}}$normal"
            echo "set-option -add global powerlinefmt %{$separator{$fg,$bg} %opt{powerline_branch} }"
            echo "set-option global powerline_next_bg $bg"
        fi
    fi
}}

define-command -hidden powerline-toggle-git -params ..1 %{ evaluate-commands %sh{
    [ "$kak_opt_powerline_module_git" = "true" ] && value=false || value=true
    if [ -n "$1" ]; then
        [ "$1" = "on" ] && value=true || value=false
    fi
    echo "set-option global powerline_module_git $value"
    echo "powerline-rebuild"
}}

§
