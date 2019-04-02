# Powerline colorscheme for base16 Kakoune theme

set-option -add global powerline_themes "base16"

define-command -hidden powerline-theme-base16 %{ evaluate-commands %sh{
    black_lighterer='rgb:383838'
    black_lighter='rgb:2D2D2D'
    black_light='rgb:1C1C1C'
    cyan_light='rgb:7CB0FF'
    green_dark='rgb:A1B56C'
    grey_dark='rgb:585858'
    grey_light='rgb:D8D8D8'
    magenta_dark='rgb:AB4642'
    magenta_light='rgb:AB4434'
    orange_dark='rgb:DC9656'
    orange_light='rgb:F7CA88'
    purple_dark='rgb:BA8BAF'
    echo "
        declare-option -hidden str powerline_color00 ${black_light}     # fg: bufname
        declare-option -hidden str powerline_color01 ${cyan_light}      # bg: position
        declare-option -hidden str powerline_color02 ${cyan_light}      # fg: git
        declare-option -hidden str powerline_color03 ${cyan_light}      # bg: bufname
        declare-option -hidden str powerline_color04 ${black_lighterer} # bg: git
        declare-option -hidden str powerline_color05 ${black_light}     # fg: position
        declare-option -hidden str powerline_color06 ${grey_light}      # fg: line-column
        declare-option -hidden str powerline_color07 ${black_lighterer} # fg: mode-info
        declare-option -hidden str powerline_color08 ${black_lighterer} # base background
        declare-option -hidden str powerline_color09 ${grey_dark}       # bg: line-column
        declare-option -hidden str powerline_color10 ${grey_light}      # fg: filetype
        declare-option -hidden str powerline_color11 ${grey_dark}       # bg: filetype
        declare-option -hidden str powerline_color12 ${purple_dark}     # bg: client
        declare-option -hidden str powerline_color13 ${black_lighter}   # fg: client
        declare-option -hidden str powerline_color14 ${black_lighter}   # fg: session
        declare-option -hidden str powerline_color15 ${magenta_dark}    # bg: session
    "
}}

