# Powerline colorscheme for desertex Kakoune theme

hook global ModuleLoaded powerline %{ require-module powerline_desertex }

provide-module powerline_desertex %§
set-option -add global powerline_themes "desertex"

define-command -hidden powerline-theme-desertex %{
    declare-option -hidden str powerline_color00 black      # fg: bufname
    declare-option -hidden str powerline_color01 yellow     # bg: position
    declare-option -hidden str powerline_color02 blue       # fg: git
    declare-option -hidden str powerline_color03 yellow     # bg: bufname
    declare-option -hidden str powerline_color04 black      # bg: git
    declare-option -hidden str powerline_color05 black      # fg: position
    declare-option -hidden str powerline_color06 black      # fg: line-column
    declare-option -hidden str powerline_color07 blue       # fg: mode-info
    declare-option -hidden str powerline_color08 black      # base background
    declare-option -hidden str powerline_color09 blue       # bg: line-column
    declare-option -hidden str powerline_color10 black      # fg: filetype
    declare-option -hidden str powerline_color11 blue       # bg: filetype
    declare-option -hidden str powerline_color12 rgb:fa8072 # bg: client
    declare-option -hidden str powerline_color13 black      # fg: client
    declare-option -hidden str powerline_color14 black      # fg: session
    declare-option -hidden str powerline_color15 magenta    # bg: session
    declare-option -hidden str powerline_color16 black      # unused
    declare-option -hidden str powerline_color17 yellow     # unused
    declare-option -hidden str powerline_color18 blue       # unused
    declare-option -hidden str powerline_color19 yellow     # unused
    declare-option -hidden str powerline_color20 black      # unused
    declare-option -hidden str powerline_color21 black      # unused
    declare-option -hidden str powerline_color22 black      # unused
    declare-option -hidden str powerline_color23 blue       # unused
    declare-option -hidden str powerline_color24 black      # unused
    declare-option -hidden str powerline_color25 blue       # unused
    declare-option -hidden str powerline_color26 black      # unused
    declare-option -hidden str powerline_color27 blue       # unused
    declare-option -hidden str powerline_color28 rgb:fa8072 # unused
    declare-option -hidden str powerline_color29 black      # unused
    declare-option -hidden str powerline_color30 black      # unused
    declare-option -hidden str powerline_color31 magenta    # unused

    declare-option -hidden str powerline_next_bg %opt{powerline_color08}
    declare-option -hidden str powerline_base_bg %opt{powerline_color08}
}

§
