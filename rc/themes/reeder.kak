## Powerline colorscheme for reeder Kakoune theme

hook global ModuleLoaded powerline %{ require-module powerline_reeder }

provide-module powerline_reeder %§
set-option -add global powerline_themes "reeder"

define-command -hidden powerline-theme-reeder %{ evaluate-commands %sh{
    white="rgb:f9f8f6"
    white_light="rgb:f6f5f0"
    black="rgb:383838"
    black_light="rgb:635240"
    grey_dark="rgb:c6b0a4"
    grey_light="rgb:e8e8e8"
    brown_dark="rgb:af4609"
    brown_light="rgb:baa188"
    brown_lighter="rgb:f0e7df"
    orange="rgb:fc7302"
    orange_light="rgb:f88e3b"
    green="rgb:438047"
    green_light="rgb:7ba84d"
    red="rgb:f03c3c"
    printf "%s\n" "
        declare-option -hidden str powerline_color00 ${black_light}   # fg: bufname
        declare-option -hidden str powerline_color01 ${brown_lighter} # bg: position
        declare-option -hidden str powerline_color02 ${black_light}   # fg: git
        declare-option -hidden str powerline_color03 ${brown_lighter} # bg: bufname
        declare-option -hidden str powerline_color04 ${brown_light}   # bg: git
        declare-option -hidden str powerline_color05 ${black_light}   # fg: position
        declare-option -hidden str powerline_color06 ${black_light}   # fg: line-column
        declare-option -hidden str powerline_color07 ${black_light}   # fg: mode-info
        declare-option -hidden str powerline_color08 ${grey_light}    # base background
        declare-option -hidden str powerline_color09 ${brown_light}   # bg: line-column
        declare-option -hidden str powerline_color10 ${black_light}   # fg: filetype
        declare-option -hidden str powerline_color11 ${grey_dark}     # bg: filetype
        declare-option -hidden str powerline_color12 ${black_light}   # bg: client
        declare-option -hidden str powerline_color13 ${grey_dark}     # fg: client
        declare-option -hidden str powerline_color14 ${grey_dark}     # fg: session
        declare-option -hidden str powerline_color15 ${black}         # bg: session
        declare-option -hidden str powerline_color16 ${black_light}   # unused
        declare-option -hidden str powerline_color17 ${brown_lighter} # unused
        declare-option -hidden str powerline_color18 ${black_light}   # unused
        declare-option -hidden str powerline_color19 ${brown_lighter} # unused
        declare-option -hidden str powerline_color20 ${brown_light}   # unused
        declare-option -hidden str powerline_color21 ${black_light}   # unused
        declare-option -hidden str powerline_color22 ${black_light}   # unused
        declare-option -hidden str powerline_color23 ${black_light}   # unused
        declare-option -hidden str powerline_color24 ${grey_light}    # unused
        declare-option -hidden str powerline_color25 ${brown_light}   # unused
        declare-option -hidden str powerline_color26 ${black_light}   # unused
        declare-option -hidden str powerline_color27 ${grey_dark}     # unused
        declare-option -hidden str powerline_color28 ${black_light}   # unused
        declare-option -hidden str powerline_color29 ${grey_dark}     # unused
        declare-option -hidden str powerline_color30 ${grey_dark}     # unused
        declare-option -hidden str powerline_color31 ${black}         # unused

        declare-option -hidden str powerline_next_bg %opt{powerline_color08}
        declare-option -hidden str powerline_base_bg %opt{powerline_color08}
    "
}}

§
