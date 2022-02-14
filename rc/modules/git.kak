# ╭─────────────╥───────────────────────╮
# │ Author:     ║ File:                 │
# │ Andrey Orst ║ git.kak               │
# ╞═════════════╩═══════════════════════╡
# │ Git module for powerline.kak        │
# ╞═════════════════════════════════════╡
# │ GitHub.com/andreyorst/powerline.kak │
# ╰─────────────────────────────────────╯

hook global ModuleLoaded powerline %{ require-module powerline_git }

provide-module powerline_git %§

set-option -add global powerline_modules 'git'

declare-option -hidden bool powerline_module_git true
declare-option -hidden str powerline_branch

define-command -hidden powerline-update-branch %{ set-option buffer powerline_branch %sh{
    if [ "$kak_opt_powerline_module_git" = "true" ]; then
        branch=$(cd "${kak_buffile%/*}" 2>/dev/null && git rev-parse --abbrev-ref HEAD 2>/dev/null)
    fi
    if [ -n "$branch" ]; then
        printf "%s\n" "$branch "
    else
        printf "%s\n" ""
    fi
}}

define-command -hidden powerline-git %{ evaluate-commands %sh{
    default=$kak_opt_powerline_base_bg
    next_bg=$kak_opt_powerline_next_bg
    normal=$kak_opt_powerline_separator
    thin=$kak_opt_powerline_separator_thin
    if [ "$kak_opt_powerline_module_git" = "true" ]; then
        fg=$kak_opt_powerline_color02
        bg=$kak_opt_powerline_color04
        printf "%s\n" "powerline-update-branch"
        if [ -n "$kak_opt_powerline_branch" ]; then
            [ "$next_bg" = "$bg" ] && separator="{$fg,$bg}$thin" || separator="{$bg,${next_bg:-$default}@powerline_base}$normal"
            printf "%s\n" "set-option -add global powerlinefmt %{$separator{$fg,$bg} %opt{powerline_branch} }"
            printf "%s\n" "set-option global powerline_next_bg $bg"
            printf "%s\n" "powerline-update-branch"
        fi
    fi
}}

define-command powerline-git-setup-hooks %{
    remove-hooks global powerline-git
    evaluate-commands %sh{
        if [ "$kak_opt_powerline_module_git" = "true" ]; then
            printf "%s\n" "hook -group powerline-git global WinDisplay .* powerline-update-branch"
            printf "%s\n" "hook -group powerline-git global WinCreate .* powerline-update-branch"
        fi
    }
}

define-command -hidden powerline-toggle-git -params ..1 %{ evaluate-commands %sh{
    [ "$kak_opt_powerline_module_git" = "true" ] && value=false || value=true
    if [ -n "$1" ]; then
        [ "$1" = "on" ] && value=true || value=false
    fi
    printf "%s\n" "set-option global powerline_module_git $value"
}}

§
