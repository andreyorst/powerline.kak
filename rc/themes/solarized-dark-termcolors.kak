# Powerline colorscheme for solarized-dark-termcolors Kakoune theme

hook -once global WinSetOption powerline_loaded=true %{ require-module powerline_solarized_dark_termcolors }

provide-module powerline_solarized_dark_termcolors %§
set-option -add global powerline_themes "solarized-dark-termcolors"

define-command -hidden powerline-theme-solarized-dark-termcolors %{
    declare-option -hidden str powerline_color00 black         # fg: bufname
    declare-option -hidden str powerline_color01 bright-red    # bg: position
    declare-option -hidden str powerline_color02 cyan          # fg: git
    declare-option -hidden str powerline_color03 bright-cyan   # bg: bufname
    declare-option -hidden str powerline_color04 black         # bg: git
    declare-option -hidden str powerline_color05 black         # fg: position
    declare-option -hidden str powerline_color06 black         # fg: line-column
    declare-option -hidden str powerline_color07 bright-cyan   # fg: mode-info
    declare-option -hidden str powerline_color08 black         # base background
    declare-option -hidden str powerline_color09 bright-yellow # bg: line-column
    declare-option -hidden str powerline_color10 black         # fg: filetype
    declare-option -hidden str powerline_color11 bright-cyan   # bg: filetype
    declare-option -hidden str powerline_color12 bright-blue   # bg: client
    declare-option -hidden str powerline_color13 black         # fg: client
    declare-option -hidden str powerline_color14 black         # fg: session
    declare-option -hidden str powerline_color15 bright-yellow # bg: session
    declare-option -hidden str powerline_color16 black         # unused
    declare-option -hidden str powerline_color17 bright-red    # unused
    declare-option -hidden str powerline_color18 cyan          # unused
    declare-option -hidden str powerline_color19 bright-cyan   # unused
    declare-option -hidden str powerline_color20 black         # unused
    declare-option -hidden str powerline_color21 black         # unused
    declare-option -hidden str powerline_color22 black         # unused
    declare-option -hidden str powerline_color23 bright-cyan   # unused
    declare-option -hidden str powerline_color24 black         # unused
    declare-option -hidden str powerline_color25 bright-yellow # unused
    declare-option -hidden str powerline_color26 black         # unused
    declare-option -hidden str powerline_color27 bright-cyan   # unused
    declare-option -hidden str powerline_color28 bright-blue   # unused
    declare-option -hidden str powerline_color29 black         # unused
    declare-option -hidden str powerline_color30 black         # unused
    declare-option -hidden str powerline_color31 bright-yellow # unused

    declare-option -hidden str powerline_next_bg %opt{powerline_color08}
    declare-option -hidden str powerline_base_bg %opt{powerline_color08}
    set-face global StatusLine bright-cyan,black
}

§
