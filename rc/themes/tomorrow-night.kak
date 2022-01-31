# Powerline colorscheme for Tomorrow-night Kakoune theme

hook global ModuleLoaded powerline %{ require-module powerline_tomorrow_night }

provide-module powerline_tomorrow_night %§
set-option -add global powerline_themes "tomorrow-night"

define-command -hidden powerline-theme-tomorrow-night %{ evaluate-commands %sh{
    foreground="rgb:c5c8c6"
    background="rgb:272727"
    selection="rgb:373b41"
    window="rgb:383838"
    text="rgb:D8D8D8"
    text_light="rgb:4E4E4E"
    line="rgb:282a2e"
    comment="rgb:969896"
    red="rgb:cc6666"
    orange="rgb:d88860"
    yellow="rgb:f0c674"
    green="rgb:b5bd68"
    green_dark="rgb:a1b56c"
    blue="rgb:81a2be"
    aqua="rgb:87afaf"
    magenta="rgb:ab4642"
    purple="rgb:b294bb"

    printf "%s\n" "
        declare-option -hidden str powerline_color00 white     # fg: bufname
        declare-option -hidden str powerline_color01 ${window} # bg: position
        declare-option -hidden str powerline_color02 ${aqua}   # fg: git
        declare-option -hidden str powerline_color03 ${window} # bg: bufname
        declare-option -hidden str powerline_color04 ${line}   # bg: git
        declare-option -hidden str powerline_color05 ${aqua}   # fg: position
        declare-option -hidden str powerline_color06 ${aqua}   # fg: line-column
        declare-option -hidden str powerline_color07 ${aqua}   # fg: mode-info
        declare-option -hidden str powerline_color08 ${window} # base background
        declare-option -hidden str powerline_color09 ${line}   # bg: line-column
        declare-option -hidden str powerline_color10 ${aqua}   # fg: filetype
        declare-option -hidden str powerline_color11 ${line}   # bg: filetype
        declare-option -hidden str powerline_color12 ${window} # bg: client
        declare-option -hidden str powerline_color13 ${aqua}   # fg: client
        declare-option -hidden str powerline_color14 ${aqua}   # bg: session
        declare-option -hidden str powerline_color15 ${line}   # fg: session
        declare-option -hidden str powerline_color16 white     # unused
        declare-option -hidden str powerline_color17 ${window} # unused
        declare-option -hidden str powerline_color18 ${aqua}   # unused
        declare-option -hidden str powerline_color19 ${window} # unused
        declare-option -hidden str powerline_color20 ${line}   # unused
        declare-option -hidden str powerline_color21 ${aqua}   # unused
        declare-option -hidden str powerline_color22 ${aqua}   # unused
        declare-option -hidden str powerline_color23 ${aqua}   # unused
        declare-option -hidden str powerline_color24 ${window} # unused
        declare-option -hidden str powerline_color25 ${line}   # unused
        declare-option -hidden str powerline_color26 ${aqua}   # unused
        declare-option -hidden str powerline_color27 ${line}   # unused
        declare-option -hidden str powerline_color28 ${window} # unused
        declare-option -hidden str powerline_color29 ${aqua}   # unused
        declare-option -hidden str powerline_color30 ${aqua}   # unused
        declare-option -hidden str powerline_color31 ${line}   # unused

        declare-option -hidden str powerline_next_bg %opt{powerline_color08}
        declare-option -hidden str powerline_base_bg %opt{powerline_color08}
    "
}}

§
