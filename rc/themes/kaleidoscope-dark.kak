# Powerline colorscheme for base16 Kakoune theme

hook global ModuleLoaded powerline %{ require-module powerline_kaleidoscope_dark }

provide-module powerline_kaleidoscope_dark %§
set-option -add global powerline_themes "kaleidoscope-dark"

define-command -hidden powerline-theme-kaleidoscope-dark %{ evaluate-commands %sh{
    black="rgb:303030"
    white="rgb:FDFDFD"

    # Regular text
    bright_blue="rgb:4477AA"
    bright_cyan="rgb:66CCEE"
    bright_green="rgb:228833"
    bright_yellow="rgb:CCBB44"
    bright_red="rgb:EE6677"
    bright_purple="rgb:AA3377"
    bright_grey="rgb:BBBBBB"

    # Emphasis
    high_contrast_blue="rgb:004488"
    high_contrast_yellow="rgb:DDAA33"
    high_contrast_red="rgb:BB5566"

    # High contrast alternative text
    vibrant_orange="rgb:EE7733"
    vibrant_blue="rgb:0077BB"
    vibrant_cyan="rgb:33BBEE"
    vibrant_magenta="rgb:EE3377"
    vibrant_red="rgb:CC3311"
    vibrant_teal="rgb:009988"
    vibrant_grey="rgb:BBBBBB"

    # Darker text with no red
    muted_rose="rgb:CC6677"
    muted_indigo="rgb:332288"
    muted_sand="rgb:DDCC77"
    muted_green="rgb:117733"
    muted_cyan="rgb:88CCEE"
    muted_wine="rgb:882255"
    muted_teal="rgb:44AA99"
    muted_olive="rgb:999933"
    muted_purple="rgb:AA4499"
    muted_pale_grey="rgb:DDDDDD"

    # Low contrast background colors
    light_blue="rgb:77AADD"
    light_orange="rgb:EE8866"
    light_yellow="rgb:EEDD88"
    light_pink="rgb:FFAABB"
    light_cyan="rgb:99DDFF"
    light_mint="rgb:44BB99"
    light_pear="rgb:BBCC33"
    light_olive="rgb:AAAA00"
    light_grey="rgb:DDDDDD"

    # Pale background colors, black foreground
    pale_blue="rgb:BBCCEE"
    pale_cyan="rgb:CCEEFF"
    pale_green="rgb:CCDDAA"
    pale_yellow="rgb:EEEEBB"
    pale_red="rgb:FFCCCC"
    pale_grey="rgb:DDDDDD"

    # Dark background colors, white foreground
    dark_blue="rgb:222255"
    dark_cyan="rgb:225555"
    dark_green="rgb:225522"
    dark_yellow="rgb:666633"
    dark_red="rgb:663333"
    dark_grey="rgb:555555"
    
#    gray="rgb:928374"
#    red="rgb:fb4934"
#    green="rgb:b8bb26"
#    yellow="rgb:fabd2f"
#    blue="rgb:83a598"
#    purple="rgb:d3869b"
#    aqua="rgb:8ec07c"
#    orange="rgb:fe8019"

    bg="${vibrant_grey}"
    bg1="${dark_grey}"
    bg2="${dark_cyan}"
    bg3="${dark_green}"
    bg4="${dark_blue}"

    fg0="rgb:fbf1c7"
    fg="rgb:ebdbb2"
    fg2="${vibrant_cyan}"
    fg3="${vibrant_green}"
    fg4="${vibrant_blue}"

    printf "%s\n" "
        declare-option -hidden str powerline_color00 ${fg2}    # fg: bufname
        declare-option -hidden str powerline_color01 ${bg4}    # bg: position
        declare-option -hidden str powerline_color02 ${bg3}    # fg: git
        declare-option -hidden str powerline_color03 ${bg2}    # bg: bufname
        declare-option -hidden str powerline_color04 ${bg}     # bg: git
        declare-option -hidden str powerline_color05 ${fg0}    # fg: position
        declare-option -hidden str powerline_color06 ${fg0}    # fg: line-column
        declare-option -hidden str powerline_color07 ${black}  # fg: mode-info
        declare-option -hidden str powerline_color08 ${bg}     # base background
        declare-option -hidden str powerline_color09 ${bg4}    # bg: line-column
        declare-option -hidden str powerline_color10 ${fg3}    # fg: filetype
        declare-option -hidden str powerline_color11 ${bg3}    # bg: filetype
        declare-option -hidden str powerline_color12 ${bg2}    # bg: client
        declare-option -hidden str powerline_color13 ${fg2}    # fg: client
        declare-option -hidden str powerline_color14 ${fg}     # fg: session
        declare-option -hidden str powerline_color15 ${bg3}    # bg: session
        declare-option -hidden str powerline_color16 ${bg}     # unused
        declare-option -hidden str powerline_color17 ${bg4}    # unused
        declare-option -hidden str powerline_color18 ${yellow} # unused
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
