# Powerline colorscheme for Default Kakoune theme

set-option -add global powerline_themes "default"

define-command -hidden powerline-theme-default %{
    declare-option -hidden str powerline_color00 black  # fg: bufname
    declare-option -hidden str powerline_color01 yellow # bg: position
    declare-option -hidden str powerline_color02 green  # fg: git
    declare-option -hidden str powerline_color03 yellow # bg: bufname
    declare-option -hidden str powerline_color04 black  # bg: git
    declare-option -hidden str powerline_color05 black  # fg: position
    declare-option -hidden str powerline_color06 cyan   # fg: line-column
    declare-option -hidden str powerline_color07 blue   # fg: mode-info
    declare-option -hidden str powerline_color08 black  # base background
    declare-option -hidden str powerline_color09 black  # bg: line-column
    declare-option -hidden str powerline_color10 yellow # fg: filetype
    declare-option -hidden str powerline_color11 black  # bg: filetype
    declare-option -hidden str powerline_color12 blue   # bg: client
    declare-option -hidden str powerline_color13 black  # fg: client
    declare-option -hidden str powerline_color14 cyan   # fg: session
    declare-option -hidden str powerline_color15 black  # bg: session
}

