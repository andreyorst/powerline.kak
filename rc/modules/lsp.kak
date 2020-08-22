hook global ModuleLoaded powerline %{ require-module powerline_lsp }

provide-module powerline_lsp %§

declare-option -hidden bool powerline_module_lsp true
set-option -add global powerline_modules 'lsp'

define-command -hidden powerline-lsp %{ evaluate-commands %sh{
    default=$kak_opt_powerline_base_bg
    next_bg=$kak_opt_powerline_next_bg
    normal=$kak_opt_powerline_separator
    thin=$kak_opt_powerline_separator_thin
    if [ "$kak_opt_powerline_module_lsp" = "true" ]; then
        fg=$kak_opt_powerline_color06
        bg=$kak_opt_powerline_color09
        fg2=$kak_opt_powerline_color07
        fg3=$kak_opt_powerline_color03
        [ "$next_bg" = "$bg" ] && separator="{$fg,$bg}$thin" || separator="{$bg,${next_bg:-$default}}$normal"
        printf "%s\n" "set-option -add global powerlinefmt %{$separator{$fg2,$bg} E:%opt{lsp_diagnostic_error_count} {$fg3,$bg} W:%opt{lsp_diagnostic_error_count} }"
        printf "%s\n" "set-option global powerline_next_bg $bg"
    fi
}}

define-command -hidden powerline-toggle-lsp -params ..1 %{ evaluate-commands %sh{
    [ "$kak_opt_powerline_module_lsp" = "true" ] && value=false || value=true
    if [ -n "$1" ]; then
        [ "$1" = "on" ] && value=true || value=false
    fi
    printf "%s\n" "set-option global powerline_module_lsp $value"
}}

§
