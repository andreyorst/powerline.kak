# Powerline colorscheme for solarized-dark Kakoune theme

hook global ModuleLoaded powerline %{ require-module powerline_solarized_dark }

provide-module powerline_solarized_dark %§
set-option -add global powerline_themes "solarized-dark"

define-command -hidden powerline-theme-solarized-dark %{ evaluate-commands %sh{
    base03='rgb:002b36'
    base02='rgb:073642'
    base01='rgb:586e75'
    base00='rgb:657b83'
    base0='rgb:839496'
    base1='rgb:93a1a1'
    base2='rgb:eee8d5'
    base3='rgb:fdf6e3'
    yellow='rgb:b58900'
    orange='rgb:cb4b16'
    red='rgb:dc322f'
    magenta='rgb:d33682'
    violet='rgb:6c71c4'
    blue='rgb:268bd2'
    cyan='rgb:2aa198'
    green='rgb:859900'

    printf "%s\n" "
        declare-option -hidden str powerline_color00 ${base02} # fg: bufname
        declare-option -hidden str powerline_color01 ${orange} # bg: position
        declare-option -hidden str powerline_color02 ${cyan}   # fg: git
        declare-option -hidden str powerline_color03 ${base1}  # bg: bufname
        declare-option -hidden str powerline_color04 ${base02} # bg: git
        declare-option -hidden str powerline_color05 ${base02} # fg: position
        declare-option -hidden str powerline_color06 ${base02} # fg: line-column
        declare-option -hidden str powerline_color07 ${base1}  # fg: mode-info
        declare-option -hidden str powerline_color08 ${base02} # base background
        declare-option -hidden str powerline_color09 ${base00} # bg: line-column
        declare-option -hidden str powerline_color10 ${base02} # fg: filetype
        declare-option -hidden str powerline_color11 ${base1}  # bg: filetype
        declare-option -hidden str powerline_color12 ${base0}  # bg: client
        declare-option -hidden str powerline_color13 ${base02} # fg: client
        declare-option -hidden str powerline_color14 ${base02} # fg: session
        declare-option -hidden str powerline_color15 ${base00} # bg: session
        declare-option -hidden str powerline_color16 ${base02} # unused
        declare-option -hidden str powerline_color17 ${orange} # unused
        declare-option -hidden str powerline_color18 ${cyan}   # unused
        declare-option -hidden str powerline_color19 ${base1}  # unused
        declare-option -hidden str powerline_color20 ${base02} # unused
        declare-option -hidden str powerline_color21 ${base02} # unused
        declare-option -hidden str powerline_color22 ${base02} # unused
        declare-option -hidden str powerline_color23 ${base1}  # unused
        declare-option -hidden str powerline_color24 ${base02} # unused
        declare-option -hidden str powerline_color25 ${base00} # unused
        declare-option -hidden str powerline_color26 ${base02} # unused
        declare-option -hidden str powerline_color27 ${base1}  # unused
        declare-option -hidden str powerline_color28 ${base0}  # unused
        declare-option -hidden str powerline_color29 ${base02} # unused
        declare-option -hidden str powerline_color30 ${base02} # unused
        declare-option -hidden str powerline_color31 ${base00} # unused

        declare-option -hidden str powerline_next_bg %opt{powerline_color08}
        declare-option -hidden str powerline_base_bg %opt{powerline_color08}
    "
}}

§
