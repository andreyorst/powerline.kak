# Powerline colorscheme for red-phoenix Kakoune theme

hook global ModuleLoaded powerline %{ require-module powerline_red_phoenix }

provide-module powerline_red_phoenix %§
set-option -add global powerline_themes "red-phoenix"

define-command -hidden powerline-theme-red-phoenix %{ evaluate-commands %sh{
    default="rgb:2d2d2d"
    black="rgb:000000"
    blue="rgb:81a2be"
    orange1="rgb:F2361E"
    orange2="rgb:ED4B19"
    orange3="rgb:FA390F"
    light_orange1="rgb:DF9767"
    white1="rgb:EDEDED"
    white2="rgb:E1E1E1"
    gray1="rgb:6F6F6F"
    gray2="rgb:D1D1D1"
    gray3="rgb:2D2D2D"
    gray4="rgb:909090"
    tan1="rgb:D2C3AD"
    tan2="rgb:AAA998"
    tan3="rgb:DF9767"
    yellow1="rgb:AAA998"
    purple1="rgb:4C3A3D"

    printf "%s\n" "
        declare-option -hidden str powerline_color00 white            # fg: bufname
        declare-option -hidden str powerline_color01 ${orange1}       # bg: position
        declare-option -hidden str powerline_color02 white            # fg: git
        declare-option -hidden str powerline_color03 ${default}       # bg: bufname
        declare-option -hidden str powerline_color04 ${black}         # bg: git
        declare-option -hidden str powerline_color05 ${default}       # fg: position
        declare-option -hidden str powerline_color06 white            # fg: line-column
        declare-option -hidden str powerline_color07 red              # fg: mode-info
        declare-option -hidden str powerline_color08 ${default}       # base background
        declare-option -hidden str powerline_color09 ${black}         # bg: line-column
        declare-option -hidden str powerline_color10 ${default}       # fg: filetype
        declare-option -hidden str powerline_color11 ${light_orange1} # bg: filetype
        declare-option -hidden str powerline_color12 ${orange2}       # bg: client
        declare-option -hidden str powerline_color13 ${default}       # fg: client
        declare-option -hidden str powerline_color14 ${default}       # bg: session
        declare-option -hidden str powerline_color15 ${orange3}       # fg: session
        declare-option -hidden str powerline_color16 white            # unused
        declare-option -hidden str powerline_color17 ${orange1}       # unused
        declare-option -hidden str powerline_color18 white            # unused
        declare-option -hidden str powerline_color19 ${default}       # unused
        declare-option -hidden str powerline_color20 ${black}         # unused
        declare-option -hidden str powerline_color21 ${default}       # unused
        declare-option -hidden str powerline_color22 white            # unused
        declare-option -hidden str powerline_color23 red              # unused
        declare-option -hidden str powerline_color24 ${default}       # unused
        declare-option -hidden str powerline_color25 ${black}         # unused
        declare-option -hidden str powerline_color26 ${default}       # unused
        declare-option -hidden str powerline_color27 ${light_orange1} # unused
        declare-option -hidden str powerline_color28 ${orange2}       # unused
        declare-option -hidden str powerline_color29 ${default}       # unused
        declare-option -hidden str powerline_color30 ${default}       # unused
        declare-option -hidden str powerline_color31 ${orange3}       # unused

        declare-option -hidden str powerline_next_bg %opt{powerline_color08}
        declare-option -hidden str powerline_base_bg %opt{powerline_color08}
    "
}}

§
