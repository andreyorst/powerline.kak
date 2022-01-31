# Powerline colorscheme for base16 Kakoune theme

hook global ModuleLoaded powerline %{ require-module powerline_gruvbox }

provide-module powerline_gruvbox %§
set-option -add global powerline_themes "gruvbox"

define-command -hidden powerline-theme-gruvbox %{ evaluate-commands %sh{
    gray="rgb:928374"
    red="rgb:fb4934"
    green="rgb:b8bb26"
    yellow="rgb:fabd2f"
    blue="rgb:83a598"
    purple="rgb:d3869b"
    aqua="rgb:8ec07c"
    orange="rgb:fe8019"

    bg="rgb:282828"
    bg1="rgb:3c3836"
    bg2="rgb:504945"
    bg3="rgb:665c54"
    bg4="rgb:7c6f64"

    fg0="rgb:fbf1c7"
    fg="rgb:ebdbb2"
    fg2="rgb:d5c4a1"
    fg3="rgb:bdae93"
    fg4="rgb:a89984"

    printf "%s\n" "
        declare-option -hidden str powerline_color00 ${bg}     # fg: bufname
        declare-option -hidden str powerline_color01 ${bg4}    # bg: position
        declare-option -hidden str powerline_color02 ${yellow} # fg: git
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
        declare-option -hidden str powerline_color14 ${fg}     # bg: session
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
