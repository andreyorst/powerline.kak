# Powerline colorscheme for base16 Kakoune theme

hook global ModuleLoaded powerline %{ require-module powerline_palenight }

provide-module powerline_palenight %§
set-option -add global powerline_themes "palenight"

define-command -hidden powerline-theme-palenight %{ evaluate-commands %sh{
    red=rgb:ff5370
    light_red=rgb:ff869a
    dark_red=rgb:be5046
    green=rgb:c3e88d
    yellow=rgb:ffcb6b
    dark_yellow=rgb:f78c6c
    blue=rgb:82b1ff
    purple=rgb:c792ea
    cyan=rgb:89ddff
    white=rgb:bfc7d5
    black=rgb:292d3e
    comment_grey=rgb:697098
    gutter_fg_grey=rgb:4b5263
    cursor_grey=rgb:2c323c
    visual_grey=rgb:3e4452
    menu_grey=rgb:697098
    special_grey=rgb:3b4048
    vertsplit=rgb:181a1f
    visual_black=default

    #gray="rgb:928374"
    #red="rgb:fb4934"
    #green="rgb:b8bb26"
    #yellow="rgb:fabd2f"
    #blue="rgb:83a598"
    #purple="rgb:d3869b"
    #aqua="rgb:8ec07c"
    #orange="rgb:fe8019"

    bg="${black}"
    bg1="${menu_grey}"
    bg2="${blue}"
    bg3="${dark_yellow}"
    bg4="${purple}"

    fg0="${visual_black}"
    fg="${white}"
    fg2="${black}"
    fg3="${yellow}"
    fg4="${visual_grey}"

    printf "%s\n" "
        declare-option -hidden str powerline_color00 ${bg}     # fg: bufname
        declare-option -hidden str powerline_color01 ${bg4}    # bg: position
        declare-option -hidden str powerline_color02 ${yellow} # fg: git
        declare-option -hidden str powerline_color03 ${fg}     # bg: bufname
        declare-option -hidden str powerline_color04 ${bg}     # bg: git
        declare-option -hidden str powerline_color05 ${fg4}    # fg: position
        declare-option -hidden str powerline_color06 ${fg4}    # fg: line-column
        declare-option -hidden str powerline_color07 ${bg}     # fg: mode-info
        declare-option -hidden str powerline_color08 ${bg}     # base background
        declare-option -hidden str powerline_color09 ${bg4}    # bg: line-column
        declare-option -hidden str powerline_color10 ${fg3}    # fg: filetype
        declare-option -hidden str powerline_color11 ${bg1}    # bg: filetype
        declare-option -hidden str powerline_color12 ${bg2}    # bg: client
        declare-option -hidden str powerline_color13 ${fg2}    # fg: client
        declare-option -hidden str powerline_color14 ${fg3}    # bg: session
        declare-option -hidden str powerline_color15 ${bg3}    # fg: session
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
