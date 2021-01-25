# Powerline colorscheme for base16 Kakoune theme

hook global ModuleLoaded powerline %{ require-module powerline_lucius }

provide-module powerline_lucius %§
set-option -add global powerline_themes "lucius"

define-command -hidden powerline-theme-lucius %{ evaluate-commands %sh{
    # first we define the lucius colors as named colors
    lucius_darker_grey="rgb:303030"
    lucius_dark_grey="rgb:444444"
    lucius_grey="rgb:808080"
    lucius_light_grey="rgb:b2b2b2"
    lucius_lighter_grey="rgb:d7d7d7"

    lucius_dark_red="rgb:870000"
    lucius_light_red="rgb:ff8787"
    lucius_orange="rgb:d78700"
    lucius_purple="rgb:d7afd7"

    lucius_dark_green="rgb:5f875f"
    lucius_bright_green="rgb:87af00"
    lucius_green="rgb:afd787"
    lucius_light_green="rgb:d7d7af"

    lucius_dark_blue="rgb:005f87"
    lucius_blue="rgb:87afd7"
    lucius_light_blue="rgb:87d7ff"

    gray="rgb:928374"
    red="rgb:fb4934"
    green="rgb:b8bb26"
    yellow="rgb:fabd2f"
    blue="rgb:83a598"
    purple="rgb:d3869b"
    aqua="rgb:8ec07c"
    orange="rgb:fe8019"

    bg="${lucius_dark_grey}"
    bg1="${lucius_dark_green}"
    bg2="${lucius_dark_blue}"
    bg3="${lucius_green}"
    bg4="${lucius_darker_grey}"

    fg0="${lucius_light_grey}"
    fg="${lucius_green}"
    fg2="${lucius_blue}"
    fg3="${lucius_light_green}"
    fg4="${lucius_lighter_grey}"

    printf "%s\n" "
        declare-option -hidden str powerline_color00 ${bg}     # fg: bufname
        declare-option -hidden str powerline_color01 ${bg4}    # bg: position
        declare-option -hidden str powerline_color02 ${fg}     # fg: git
        declare-option -hidden str powerline_color03 ${fg}     # bg: bufname
        declare-option -hidden str powerline_color04 ${bg}     # bg: git
        declare-option -hidden str powerline_color05 ${fg0}    # fg: position
        declare-option -hidden str powerline_color06 ${fg0}    # fg: line-column
        declare-option -hidden str powerline_color07 ${bg}     # fg: mode-info
        declare-option -hidden str powerline_color08 ${bg}     # base background
        declare-option -hidden str powerline_color09 ${bg4}    # bg: line-column
        declare-option -hidden str powerline_color10 ${fg3}    # fg: filetype
        declare-option -hidden str powerline_color11 ${bg1}    # bg: filetype
        declare-option -hidden str powerline_color12 ${bg2}    # bg: client
        declare-option -hidden str powerline_color13 ${fg2}    # fg: client
        declare-option -hidden str powerline_color14 ${fg}     # fg: session
        declare-option -hidden str powerline_color15 ${bg}     # bg: session
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
