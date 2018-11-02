# Powerline colorscheme for Default Kakoune theme

define-command -hidden powerline-theme-default %{
    set-option global powerline_git_fg         blue
    set-option global powerline_git_bg         default
    set-option global powerline_bufname_bg     yellow
    set-option global powerline_bufname_fg     black
    set-option global powerline_line_column_fg black
    set-option global powerline_line_column_bg cyan
    set-option global powerline_mode_info_fg   black
    set-option global powerline_mode_info_bg   black
    set-option global powerline_filetype_fg    black
    set-option global powerline_filetype_bg    cyan
    set-option global powerline_client_fg      black
    set-option global powerline_client_bg      blue
    set-option global powerline_session_fg     black
    set-option global powerline_session_bg     cyan
    set-option global powerline_position_fg    black
    set-option global powerline_position_bg    yellow
}

