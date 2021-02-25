hook global ModuleLoaded powerline %{ require-module powerline_mode_codepoint }

provide-module powerline_mode_codepoint %§

set-option -add global powerline_modules 'codepoint'
declare-option -hidden bool powerline_module_codepoint true
declare-option -hidden str powerline_codepoint '0000'

define-command -hidden powerline-update-codepoint %{ evaluate-commands %sh{ (
    codepoint=$(printf "%04x" "$kak_cursor_char_value")
    printf "%s\n" "try %{ evaluate-commands -client $kak_client %{ set-option window powerline_codepoint "$codepoint" } }"
    )}
}

define-command -hidden powerline-codepoint %{ evaluate-commands %sh{
    default=$kak_opt_powerline_base_bg
    next_bg=$kak_opt_powerline_next_bg
    normal=$kak_opt_powerline_separator
    thin=$kak_opt_powerline_separator_thin
    if [ "$kak_opt_powerline_module_mode_info" = "true" ]; then
        bg=$kak_opt_powerline_color11
        fg=$kak_opt_powerline_color10
        [ "$next_bg" = "$bg" ] && separator="{$fg,$bg}$thin" || separator="{$bg,${next_bg:-$default}}$normal"
        printf "%s\n" "set-option -add global powerlinefmt %{$separator{$fg,$bg} U+%opt{powerline_codepoint} }"
        printf "%s\n" "set-option global powerline_next_bg $bg"
    fi
}}

define-command -hidden powerline-codepoint-setup-hooks %{
    remove-hooks global powerline-codepoint
    evaluate-commands %sh{
        if [ "$kak_opt_powerline_module_codepoint" = "true" ]; then
            printf "%s\n" "hook -group powerline-codepoint global WinDisplay .*  powerline-update-codepoint"
            printf "%s\n" "hook -group powerline-codepoint global NormalKey .* powerline-update-codepoint"
            printf "%s\n" "hook -group powerline-codepoint global NormalIdle .*  powerline-update-codepoint"
        fi
    }
}

define-command -hidden powerline-toggle-codepoint -params ..1 %{ evaluate-commands %sh{
    [ "$kak_opt_powerline_module_codepoint" = "true" ] && value=false || value=true
    if [ -n "$1" ]; then
        [ "$1" = "on" ] && value=true || value=false
    fi
    printf "%s\n" "set-option global powerline_module_codepoint $value"
}}

§
