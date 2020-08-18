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

define-command -hidden powerline-git %{ evaluate-commands %sh{
    default=$kak_opt_powerline_base_bg
    next_bg=$kak_opt_powerline_next_bg
    normal=$kak_opt_powerline_separator
    thin=$kak_opt_powerline_separator_thin
    if [ "$kak_opt_powerline_module_git" = "true" ]; then
        fg=$kak_opt_powerline_color02
        bg=$kak_opt_powerline_color04
        [ "$next_bg" = "$bg" ] && separator="{$fg,$bg}$thin" || separator="{$bg,${next_bg:-$default}}$normal"
        branch=$(cd "${kak_buffile%/*}" 2>/dev/null && git branch | awk '{print $2;}')
        if [ -n "$branch" ]; then
        	printf "%s\n" "set-option -add global powerlinefmt %{$separator{$fg,$bg} $branch  }"
       	fi
        printf "%s\n" "set-option global powerline_next_bg $bg"
    fi
}}

define-command -hidden powerline-toggle-git -params ..1 %{ evaluate-commands %sh{
    [ "$kak_opt_powerline_module_git" = "true" ] && value=false || value=true
    if [ -n "$1" ]; then
        [ "$1" = "on" ] && value=true || value=false
    fi
    printf "%s\n" "set-option global powerline_module_git $value"
}}

§
