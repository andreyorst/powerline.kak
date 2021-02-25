# Powerline colorscheme for base16 Kakoune theme

hook global ModuleLoaded powerline %{ require-module powerline_greyscale }

provide-module powerline_greyscale %§
set-option -add global powerline_themes "greyscale"

define-command -hidden powerline-theme-greyscale %{ evaluate-commands %sh{
    grey_light_5="rgb:fafafa"
    grey_light_4="rgb:f5f5f5"
    grey_light_3="rgb:eeeeee"
    grey_light_2="rgb:e0e0e0"
    grey_light_1="rgb:bdbdbd"
    grey="rgb:9e9e9e"
    grey_dark_1="rgb:757575"
    grey_dark_2="rgb:616161"
    grey_dark_3="rgb:424242"
    grey_dark_4="rgb:212121"
    grey_dark_5="rgb:121212"

     bg="${grey_dark_1}"
     bg1="${grey_dark_2}"
     bg2="${grey_dark_3}"
     bg3="${grey_dark_4}"
     bg4="${grey_dark_5}"
     fg="${grey_light_1}"
     fg1="${grey_light_1}"
     fg2="${grey_light_2}"
     fg3="${grey_light_3}"
     fg4="${grey_light_4}"

    printf "%s\n" "
        declare-option -hidden str powerline_color00 ${bg}     # fg: bufname
        declare-option -hidden str powerline_color01 ${bg4}    # bg: position
        declare-option -hidden str powerline_color02 ${fg}     # fg: git
        declare-option -hidden str powerline_color03 ${fg}     # bg: bufname
        declare-option -hidden str powerline_color04 ${bg}     # bg: git
        declare-option -hidden str powerline_color05 ${fg1}    # fg: position
        declare-option -hidden str powerline_color06 ${fg1}    # fg: line-column
        declare-option -hidden str powerline_color07 ${bg}     # fg: mode-info
        declare-option -hidden str powerline_color08 ${fg}     # base background
        declare-option -hidden str powerline_color09 ${bg4}    # bg: line-column
        declare-option -hidden str powerline_color10 ${fg3}    # fg: filetype
        declare-option -hidden str powerline_color11 ${bg1}    # bg: filetype
        declare-option -hidden str powerline_color12 ${bg2}    # bg: client
        declare-option -hidden str powerline_color13 ${fg2}    # fg: client
        declare-option -hidden str powerline_color14 ${fg}     # fg: session
        declare-option -hidden str powerline_color15 ${bg3}    # bg: session
        declare-option -hidden str powerline_color16 ${bg}     # unused
        declare-option -hidden str powerline_color17 ${bg4}    # unused
        declare-option -hidden str powerline_color18 ${fg}     # unused
        declare-option -hidden str powerline_color19 ${fg}     # unused
        declare-option -hidden str powerline_color20 ${bg}     # unused
        declare-option -hidden str powerline_color21 ${fg0}    # unused
        declare-option -hidden str powerline_color22 ${fg0}    # unused
        declare-option -hidden str powerline_color23 ${bg}     # unused
        declare-option -hidden str powerline_color24 ${bg}     # unused
        declare-option -hidden str powerline_color25 ${bg4}    # unused
        declare-option -hidden str powerline_color26 ${fg3}    # unused
        declare-option -hidden str powerline_color27 ${bg1}    # unused
        declare-option -hidden str powerline_color28 ${bg2}    # unused
        declare-option -hidden str powerline_color29 ${fg2}    # unused
        declare-option -hidden str powerline_color30 ${fg}     # unused
        declare-option -hidden str powerline_color31 ${bg3}    # unused

        declare-option -hidden str powerline_next_bg %opt{powerline_color08}
        declare-option -hidden str powerline_base_bg %opt{powerline_color08}
    "
}}

§
