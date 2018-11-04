# Powerline colorscheme for desertex Kakoune theme

set-option -add global powerline_themes "desertex"

define-command -hidden powerline-theme-desertex %{
    set-option global powerline_base_bg        black
    set-option global powerline_git_fg         blue
    set-option global powerline_git_bg         black
    set-option global powerline_bufname_fg     black
    set-option global powerline_bufname_bg     yellow
    set-option global powerline_line_column_fg black
    set-option global powerline_line_column_bg blue
    set-option global powerline_mode_info_fg   blue
    set-option global powerline_mode_info_bg   black
    set-option global powerline_filetype_fg    black
    set-option global powerline_filetype_bg    blue
    set-option global powerline_client_fg      black
    set-option global powerline_client_bg      rgb:fa8072
    set-option global powerline_session_fg     black
    set-option global powerline_session_bg     magenta
    set-option global powerline_position_fg    black
    set-option global powerline_position_bg    yellow
}

