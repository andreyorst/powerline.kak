# Powerline colorscheme for Default Kakoune theme

hook -once global WinSetOption powerline_loaded=true %{ require-module powerline_default }

provide-module powerline_default %§
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
    declare-option -hidden str powerline_color16 black  # unused
    declare-option -hidden str powerline_color17 yellow # unused
    declare-option -hidden str powerline_color18 green  # unused
    declare-option -hidden str powerline_color19 yellow # unused
    declare-option -hidden str powerline_color20 black  # unused
    declare-option -hidden str powerline_color21 black  # unused
    declare-option -hidden str powerline_color22 cyan   # unused
    declare-option -hidden str powerline_color23 blue   # unused
    declare-option -hidden str powerline_color24 black  # unused
    declare-option -hidden str powerline_color25 black  # unused
    declare-option -hidden str powerline_color26 yellow # unused
    declare-option -hidden str powerline_color27 black  # unused
    declare-option -hidden str powerline_color28 blue   # unused
    declare-option -hidden str powerline_color29 black  # unused
    declare-option -hidden str powerline_color30 cyan   # unused
    declare-option -hidden str powerline_color31 black  # unused

    declare-option -hidden str powerline_next_bg %opt{powerline_color08}
    declare-option -hidden str powerline_base_bg %opt{powerline_color08}
}

§
