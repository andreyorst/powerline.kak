# Powerline colorscheme for Default Kakoune theme

set-option -add global powerline_themes "default"

define-command -hidden powerline-theme-default %{
    declare-option -hidden str powerline_color00 black  # bufname fg
    declare-option -hidden str powerline_color01 yellow # position fg
    declare-option -hidden str powerline_color02 green  # git fg
    declare-option -hidden str powerline_color03 yellow # bufname bg
    declare-option -hidden str powerline_color04 black  # git bg
    declare-option -hidden str powerline_color05 black  # position bg
    declare-option -hidden str powerline_color06 cyan   # line-column fg
    declare-option -hidden str powerline_color07 blue   # mode-info fg
    declare-option -hidden str powerline_color08 black  # mode-info bg
    declare-option -hidden str powerline_color09 black  # line-column bg
    declare-option -hidden str powerline_color10 yellow # filetype fg
    declare-option -hidden str powerline_color11 black  # filetype bg
    declare-option -hidden str powerline_color12 blue   # client bg
    declare-option -hidden str powerline_color13 black  # client fg
    declare-option -hidden str powerline_color14 cyan   # session fg
    declare-option -hidden str powerline_color15 black  # session bg
}

