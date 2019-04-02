# Powerline colorscheme for Default Kakoune theme

set-option -add global powerline_themes "default"

define-command -hidden powerline-theme-default %{
    declare-option -hidden str powerline_color00 black
    declare-option -hidden str powerline_color01 red
    declare-option -hidden str powerline_color02 green
    declare-option -hidden str powerline_color03 yellow
    declare-option -hidden str powerline_color04 blue
    declare-option -hidden str powerline_color05 magenta
    declare-option -hidden str powerline_color06 cyan
    declare-option -hidden str powerline_color07 white
    declare-option -hidden str powerline_color08 bright-black
    declare-option -hidden str powerline_color09 bright-red
    declare-option -hidden str powerline_color10 bright-green
    declare-option -hidden str powerline_color11 bright-yellow
    declare-option -hidden str powerline_color12 bright-blue
    declare-option -hidden str powerline_color13 bright-magenta
    declare-option -hidden str powerline_color14 bright-cyan
    declare-option -hidden str powerline_color15 bright-white

    declare-option -hidden str powerline_base_bg %opt{powerline_color00}
}

