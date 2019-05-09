# Powerline colorscheme for zenburn Kakoune theme

hook global ModuleLoad powerline %{ require-module powerline_zenburn }

provide-module powerline_zenburn %§
set-option -add global powerline_themes "zenburn"

define-command -hidden powerline-theme-zenburn %{
    declare-option -hidden str powerline_color00 rgb:cc9393 # fg: bufname
    declare-option -hidden str powerline_color01 rgb:2a2a2a # bg: position
    declare-option -hidden str powerline_color02 rgb:7f9f7f # fg: git
    declare-option -hidden str powerline_color03 rgb:2a2a2a # bg: bufname
    declare-option -hidden str powerline_color04 rgb:4a4a4a # bg: git
    declare-option -hidden str powerline_color05 white      # fg: position
    declare-option -hidden str powerline_color06 rgb:7f9f7f # fg: line-column
    declare-option -hidden str powerline_color07 white      # fg: mode-info
    declare-option -hidden str powerline_color08 rgb:2a2a2a # base background
    declare-option -hidden str powerline_color09 rgb:4a4a4a # bg: line-column
    declare-option -hidden str powerline_color10 rgb:7f9f7f # fg: filetype
    declare-option -hidden str powerline_color11 rgb:4a4a4a # bg: filetype
    declare-option -hidden str powerline_color12 rgb:2a2a2a # bg: client
    declare-option -hidden str powerline_color13 rgb:cc9393 # fg: client
    declare-option -hidden str powerline_color14 rgb:7f9f7f # fg: session
    declare-option -hidden str powerline_color15 rgb:4a4a4a # bg: session
    declare-option -hidden str powerline_color16 rgb:cc9393 # unused
    declare-option -hidden str powerline_color17 rgb:2a2a2a # unused
    declare-option -hidden str powerline_color18 rgb:7f9f7f # unused
    declare-option -hidden str powerline_color19 rgb:2a2a2a # unused
    declare-option -hidden str powerline_color20 rgb:4a4a4a # unused
    declare-option -hidden str powerline_color21 white      # unused
    declare-option -hidden str powerline_color22 rgb:7f9f7f # unused
    declare-option -hidden str powerline_color23 white      # unused
    declare-option -hidden str powerline_color24 rgb:2a2a2a # unused
    declare-option -hidden str powerline_color25 rgb:4a4a4a # unused
    declare-option -hidden str powerline_color26 rgb:7f9f7f # unused
    declare-option -hidden str powerline_color27 rgb:4a4a4a # unused
    declare-option -hidden str powerline_color28 rgb:2a2a2a # unused
    declare-option -hidden str powerline_color29 rgb:cc9393 # unused
    declare-option -hidden str powerline_color30 rgb:7f9f7f # unused
    declare-option -hidden str powerline_color31 rgb:4a4a4a # unused

    declare-option -hidden str powerline_next_bg %opt{powerline_color08}
    declare-option -hidden str powerline_base_bg %opt{powerline_color08}
}

§
