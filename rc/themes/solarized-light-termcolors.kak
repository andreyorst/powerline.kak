# Powerline colorscheme for solarized-light-termcolors Kakoune theme

set-option -add global powerline_themes "solarized-light-termcolors"

define-command -hidden powerline-theme-solarized-light-termcolors %{
    set-option global powerline_base_bg        white
    set-option global powerline_git_fg         cyan
    set-option global powerline_git_bg         white
    set-option global powerline_bufname_fg     black
    set-option global powerline_bufname_bg     bright-cyan
    set-option global powerline_line_column_fg black
    set-option global powerline_line_column_bg bright-yellow
    set-option global powerline_mode_info_fg   bright-cyan
    set-option global powerline_mode_info_bg   white
    set-option global powerline_filetype_fg    black
    set-option global powerline_filetype_bg    bright-cyan
    set-option global powerline_client_fg      black
    set-option global powerline_client_bg      bright-blue
    set-option global powerline_session_fg     black
    set-option global powerline_session_bg     bright-yellow
    set-option global powerline_position_fg    bright-red
    set-option global powerline_position_bg    black
}

