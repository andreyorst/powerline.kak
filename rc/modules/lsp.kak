hook global ModuleLoaded powerline %{ require-module powerline_lsp }

provide-module powerline_lsp %§

declare-option -hidden bool powerline_module_lsp true
set-option -add global powerline_modules 'lsp'

define-command -hidden powerline-lsp %{
    try %{
        #First try adding a highlighter. If we can, then LSP isn't enabled.
        add-highlighter window/lsp_references ranges lsp_references
        remove-highlighter window/lsp_references
    } catch %{
        #We can't add the highlighter. LSP is enabled.
        evaluate-commands %sh{
            default=$kak_opt_powerline_base_bg
            next_bg=$kak_opt_powerline_next_bg
            normal=$kak_opt_powerline_separator
            thin=$kak_opt_powerline_separator_thin
            if [ "$kak_opt_powerline_module_lsp" = "true" ]; then
                fg=$kak_opt_powerline_color06
                bg=$kak_opt_powerline_color09
                [ "$next_bg" = "$bg" ] && separator="{$fg,$bg}$thin" || separator="{$bg,${next_bg:-$default}}$normal"
                printf "%s\n" "set-option -add global powerlinefmt %{$separator{$fg,$bg} E:%opt{lsp_diagnostic_error_count} W:%opt{lsp_diagnostic_warning_count} }"
                printf "%s\n" "set-option global powerline_next_bg $bg"
            fi
        }
    }
}

define-command -hidden powerline-toggle-lsp -params ..1 %{ evaluate-commands %sh{
    [ "$kak_opt_powerline_module_lsp" = "true" ] && value=false || value=true
    if [ -n "$1" ]; then
        [ "$1" = "on" ] && value=true || value=false
    fi
    printf "%s\n" "set-option global powerline_module_lsp $value"
}}

§
