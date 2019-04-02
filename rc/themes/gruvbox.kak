# Powerline colorscheme for base16 Kakoune theme

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

    echo "
        declare-option -hidden str powerline_color00 ${bg} # fg: bufname
        declare-option -hidden str powerline_color01 ${bg4} # bg: position
        declare-option -hidden str powerline_color02 ${yellow} # fg: git
        declare-option -hidden str powerline_color03 ${fg} # bg: bufname
        declare-option -hidden str powerline_color04 ${bg} # bg: git
        declare-option -hidden str powerline_color05 ${fg0} # fg: position
        declare-option -hidden str powerline_color06 ${fg0} # fg: line-column
        declare-option -hidden str powerline_color07 ${bg} # fg: mode-info
        declare-option -hidden str powerline_color08 ${bg} # base background
        declare-option -hidden str powerline_color09 ${bg4} # bg: line-column
        declare-option -hidden str powerline_color10 ${fg3} # fg: filetype
        declare-option -hidden str powerline_color11 ${bg1} # bg: filetype
        declare-option -hidden str powerline_color12 ${bg2} # bg: client
        declare-option -hidden str powerline_color13 ${fg2} # fg: client
        declare-option -hidden str powerline_color14 ${fg} # fg: session
        declare-option -hidden str powerline_color15 ${bg3} # bg: session
    "
}}

