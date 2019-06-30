# base16-gruvbox colorscheme for powerline.kak
# based on https://github.com/andreyorst/base16-gruvbox.kak

hook global ModuleLoaded powerline %{ require-module powerline_base16_gruvbox }

provide-module powerline_base16_gruvbox %§
set-option -add global powerline_themes "base16-gruvbox"

define-command -hidden powerline-theme-base16-gruvbox %{
    declare-option -hidden str powerline_color00 "rgb:282828" # fg: bufname
    declare-option -hidden str powerline_color01 "rgb:a89984" # bg: position
    declare-option -hidden str powerline_color02 "rgb:bdae93" # fg: git
    declare-option -hidden str powerline_color03 "rgb:a89984" # bg: bufname
    declare-option -hidden str powerline_color04 "rgb:3c3836" # bg: git
    declare-option -hidden str powerline_color05 "rgb:282828" # fg: position
    declare-option -hidden str powerline_color06 "rgb:bdae93" # fg: line-column
    declare-option -hidden str powerline_color07 "rgb:d5c4a1" # fg: mode-info
    declare-option -hidden str powerline_color08 "rgb:3c3836" # base background
    declare-option -hidden str powerline_color09 "rgb:504945" # bg: line-column
    declare-option -hidden str powerline_color10 "rgb:ebdbb2" # fg: filetype
    declare-option -hidden str powerline_color11 "rgb:504945" # bg: filetype
    declare-option -hidden str powerline_color12 "rgb:665c54" # bg: client
    declare-option -hidden str powerline_color13 "rgb:ebdbb2" # fg: client
    declare-option -hidden str powerline_color14 "rgb:7c6f64" # fg: session
    declare-option -hidden str powerline_color15 "rgb:fbf1c7" # bg: session
    declare-option -hidden str powerline_color16 "rgb:282828" # unused
    declare-option -hidden str powerline_color17 "rgb:a89984" # unused
    declare-option -hidden str powerline_color18 "rgb:bdae93" # unused
    declare-option -hidden str powerline_color19 "rgb:a89984" # unused
    declare-option -hidden str powerline_color20 "rgb:3c3836" # unused
    declare-option -hidden str powerline_color21 "rgb:282828" # unused
    declare-option -hidden str powerline_color22 "rgb:bdae93" # unused
    declare-option -hidden str powerline_color23 "rgb:d5c4a1" # unused
    declare-option -hidden str powerline_color24 "rgb:3c3836" # unused
    declare-option -hidden str powerline_color25 "rgb:504945" # unused
    declare-option -hidden str powerline_color26 "rgb:ebdbb2" # unused
    declare-option -hidden str powerline_color27 "rgb:504945" # unused
    declare-option -hidden str powerline_color28 "rgb:665c54" # unused
    declare-option -hidden str powerline_color29 "rgb:ebdbb2" # unused
    declare-option -hidden str powerline_color30 "rgb:7c6f64" # unused
    declare-option -hidden str powerline_color31 "rgb:fbf1c7" # unused

    declare-option -hidden str powerline_next_bg %opt{powerline_color08}
    declare-option -hidden str powerline_base_bg %opt{powerline_color08}
}

§
