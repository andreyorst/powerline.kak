# Powerline colorscheme for solarized-light-termcolors Kakoune theme

hook global ModuleLoad powerline %{ require-module powerline_solarized_light_termcolors }

provide-module powerline_solarized_light_termcolors %§
set-option -add global powerline_themes "solarized-light-termcolors"

define-command -hidden powerline-theme-solarized-light-termcolors %{
    declare-option -hidden str powerline_color00 black         # fg: bufname
    declare-option -hidden str powerline_color01 bright-red    # bg: position
    declare-option -hidden str powerline_color02 cyan          # fg: git
    declare-option -hidden str powerline_color03 bright-cyan   # bg: bufname
    declare-option -hidden str powerline_color04 white         # bg: git
    declare-option -hidden str powerline_color05 black         # fg: position
    declare-option -hidden str powerline_color06 black         # fg: line-column
    declare-option -hidden str powerline_color07 bright-cyan   # fg: mode-info
    declare-option -hidden str powerline_color08 white         # base background
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
    declare-option -hidden str powerline_color20 white         # unused
    declare-option -hidden str powerline_color21 black         # unused
    declare-option -hidden str powerline_color22 black         # unused
    declare-option -hidden str powerline_color23 bright-cyan   # unused
    declare-option -hidden str powerline_color24 white         # unused
    declare-option -hidden str powerline_color25 bright-yellow # unused
    declare-option -hidden str powerline_color26 black         # unused
    declare-option -hidden str powerline_color27 bright-cyan   # unused
    declare-option -hidden str powerline_color28 bright-blue   # unused
    declare-option -hidden str powerline_color29 black         # unused
    declare-option -hidden str powerline_color30 black         # unused
    declare-option -hidden str powerline_color31 bright-yellow # unused

    declare-option -hidden str powerline_next_bg %opt{powerline_color08}
    declare-option -hidden str powerline_base_bg %opt{powerline_color08}
    set-face global StatusLine bright-green,white
}

§
