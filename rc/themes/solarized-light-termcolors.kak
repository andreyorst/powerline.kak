# Powerline colorscheme for solarized-light-termcolors Kakoune theme

declare-option -hidden str-list powerline_themes
set-option -add global powerline_themes "solarized-light-termcolors"

define-command -hidden powerline-theme-solarized-light-termcolors %{
    declare-option -hidden str powerline_color00 black          # fg: bufname
    declare-option -hidden str powerline_color01 bright-red     # bg: position
    declare-option -hidden str powerline_color02 cyan           # fg: git
    declare-option -hidden str powerline_color03 bright-cyan    # bg: bufname
    declare-option -hidden str powerline_color04 white          # bg: git
    declare-option -hidden str powerline_color05 black          # fg: position
    declare-option -hidden str powerline_color06 black          # fg: line-column
    declare-option -hidden str powerline_color07 bright-cyan    # fg: mode-info
    declare-option -hidden str powerline_color08 white          # base background
    declare-option -hidden str powerline_color09 bright-yellow  # bg: line-column
    declare-option -hidden str powerline_color10 black          # fg: filetype
    declare-option -hidden str powerline_color11 bright-cyan    # bg: filetype
    declare-option -hidden str powerline_color12 bright-blue    # bg: client
    declare-option -hidden str powerline_color13 black          # fg: client
    declare-option -hidden str powerline_color14 black          # fg: session
    declare-option -hidden str powerline_color15 bright-yellow  # bg: session
}

