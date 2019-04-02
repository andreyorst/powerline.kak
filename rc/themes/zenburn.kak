# Powerline colorscheme for zenburn Kakoune theme

declare-option -hidden str-list powerline_themes
set-option -add global powerline_themes "zenburn"

define-command -hidden powerline-theme-zenburn %{
    set-option global powerline_base_bg        rgb:2a2a2a
    set-option global powerline_git_fg         rgb:7f9f7f
    set-option global powerline_git_bg         rgb:4a4a4a
    set-option global powerline_bufname_fg     rgb:cc9393
    set-option global powerline_bufname_bg     rgb:2a2a2a
    set-option global powerline_line_column_fg rgb:7f9f7f
    set-option global powerline_line_column_bg rgb:4a4a4a
    set-option global powerline_mode_info_fg   white
    set-option global powerline_mode_info_bg   rgb:2a2a2a
    set-option global powerline_filetype_fg    rgb:7f9f7f
    set-option global powerline_filetype_bg    rgb:4a4a4a
    set-option global powerline_client_fg      rgb:cc9393
    set-option global powerline_client_bg      rgb:2a2a2a
    set-option global powerline_session_fg     rgb:7f9f7f
    set-option global powerline_session_bg     rgb:4a4a4a
    set-option global powerline_position_fg    white
    set-option global powerline_position_bg    rgb:2a2a2a
}
