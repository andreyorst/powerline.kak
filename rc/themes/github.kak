# Powerline colorscheme for github Kakoune theme

declare-option -hidden str-list powerline_themes
set-option -add global powerline_themes "github"

define-command -hidden powerline-theme-github %{
    declare-option -hidden str powerline_color00 rgb:F8F8FF # fg: bufname
    declare-option -hidden str powerline_color01 rgb:4078C0 # bg: position
    declare-option -hidden str powerline_color02 rgb:4078C0 # fg: git
    declare-option -hidden str powerline_color03 rgb:4078C0 # bg: bufname
    declare-option -hidden str powerline_color04 rgb:DDDDDD # bg: git
    declare-option -hidden str powerline_color05 rgb:F8F8FF # fg: position
    declare-option -hidden str powerline_color06 rgb:F8F8FF # fg: line-column
    declare-option -hidden str powerline_color07 rgb:DDDDDD # fg: mode-info
    declare-option -hidden str powerline_color08 rgb:DDDDDD # base background
    declare-option -hidden str powerline_color09 rgb:795DA3 # bg: line-column
    declare-option -hidden str powerline_color10 rgb:F8F8FF # fg: filetype
    declare-option -hidden str powerline_color11 rgb:A71D5D # bg: filetype
    declare-option -hidden str powerline_color12 rgb:4078C0 # bg: client
    declare-option -hidden str powerline_color13 rgb:F8F8FF # fg: client
    declare-option -hidden str powerline_color14 rgb:F8F8FF # fg: session
    declare-option -hidden str powerline_color15 rgb:795DA3 # bg: session
    declare-option -hidden str powerline_color16 rgb:F8F8FF # unused
    declare-option -hidden str powerline_color17 rgb:4078C0 # unused
    declare-option -hidden str powerline_color18 rgb:4078C0 # unused
    declare-option -hidden str powerline_color19 rgb:4078C0 # unused
    declare-option -hidden str powerline_color20 rgb:DDDDDD # unused
    declare-option -hidden str powerline_color21 rgb:F8F8FF # unused
    declare-option -hidden str powerline_color22 rgb:F8F8FF # unused
    declare-option -hidden str powerline_color23 rgb:DDDDDD # unused
    declare-option -hidden str powerline_color24 rgb:DDDDDD # unused
    declare-option -hidden str powerline_color25 rgb:795DA3 # unused
    declare-option -hidden str powerline_color26 rgb:F8F8FF # unused
    declare-option -hidden str powerline_color27 rgb:A71D5D # unused
    declare-option -hidden str powerline_color28 rgb:4078C0 # unused
    declare-option -hidden str powerline_color29 rgb:F8F8FF # unused
    declare-option -hidden str powerline_color30 rgb:F8F8FF # unused
    declare-option -hidden str powerline_color31 rgb:795DA3 # unused
}

