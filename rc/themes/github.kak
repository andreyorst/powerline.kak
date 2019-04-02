# Powerline colorscheme for github Kakoune theme

declare-option -hidden str-list powerline_themes
set-option -add global powerline_themes "github"

define-command -hidden powerline-theme-github %{
    set-option global powerline_base_bg        rgb:DDDDDD
    set-option global powerline_git_fg         rgb:4078C0
    set-option global powerline_git_bg         rgb:DDDDDD
    set-option global powerline_bufname_fg     rgb:F8F8FF
    set-option global powerline_bufname_bg     rgb:4078C0
    set-option global powerline_line_column_fg rgb:F8F8FF
    set-option global powerline_line_column_bg rgb:795DA3
    set-option global powerline_mode_info_fg   rgb:DDDDDD
    set-option global powerline_mode_info_bg   rgb:DDDDDD
    set-option global powerline_filetype_fg    rgb:F8F8FF
    set-option global powerline_filetype_bg    rgb:A71D5D
    set-option global powerline_client_fg      rgb:F8F8FF
    set-option global powerline_client_bg      rgb:4078C0
    set-option global powerline_session_fg     rgb:F8F8FF
    set-option global powerline_session_bg     rgb:795DA3
    set-option global powerline_position_fg    rgb:F8F8FF
    set-option global powerline_position_bg    rgb:4078C0
}

