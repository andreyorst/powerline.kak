# base16-gruvbox colorscheme for powerline.kak
# based on https://github.com/andreyorst/base16-gruvbox.kak

set-option -add global powerline_themes "base16-gruvbox"

define-command -override -hidden powerline-theme-base16-gruvbox %{
    declare-option -hidden str powerline_color00 "rgb:282828" # bufname fg
    declare-option -hidden str powerline_color01 "rgb:ebdbb2" # position fg
    declare-option -hidden str powerline_color02 "rgb:bdae93" # git fg
    declare-option -hidden str powerline_color03 "rgb:a89984" # bufname bg
    declare-option -hidden str powerline_color04 "rgb:3c3836" # git bg
    declare-option -hidden str powerline_color05 "rgb:504945" # position bg
    declare-option -hidden str powerline_color06 "rgb:bdae93" # line-column fg
    declare-option -hidden str powerline_color07 "rgb:d5c4a1" # mode-info fg
    declare-option -hidden str powerline_color08 "rgb:3c3836" # base background
    declare-option -hidden str powerline_color09 "rgb:504945" # line-column bg
    declare-option -hidden str powerline_color10 "rgb:ebdbb2" # filetype fg
    declare-option -hidden str powerline_color11 "rgb:504945" # filetype bg
    declare-option -hidden str powerline_color12 "rgb:665c54" # client bg
    declare-option -hidden str powerline_color13 "rgb:ebdbb2" # client fg
    declare-option -hidden str powerline_color14 "rgb:7c6f64" # session fg
    declare-option -hidden str powerline_color15 "rgb:fbf1c7" # session bg
}

