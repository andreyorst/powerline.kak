# base16-gruvbox colorscheme for powerline.kak
# based on https://github.com/andreyorst/base16-gruvbox.kak

set-option -add global powerline_themes "base16-gruvbox"

define-command -hidden powerline-theme-base16-gruvbox %{
    set-option global powerline_base_bg        "rgb:3c3836"
    set-option global powerline_git_fg         "rgb:d5c4a1"
    set-option global powerline_git_bg         "rgb:3c3836"
    set-option global powerline_bufname_bg     "rgb:a89984"
    set-option global powerline_bufname_fg     "rgb:282828"
    set-option global powerline_line_column_fg "rgb:bdae93"
    set-option global powerline_line_column_bg "rgb:504945"
    set-option global powerline_mode_info_fg   "rgb:d5c4a1"
    set-option global powerline_mode_info_bg   "rgb:3c3836"
    set-option global powerline_filetype_fg    "rgb:d5c4a1"
    set-option global powerline_filetype_bg    "rgb:504945"
    set-option global powerline_client_fg      "rgb:ebdbb2"
    set-option global powerline_client_bg      "rgb:665c54"
    set-option global powerline_session_fg     "rgb:fbf1c7"
    set-option global powerline_session_bg     "rgb:7c6f64"
    set-option global powerline_position_fg    "rgb:282828"
    set-option global powerline_position_bg    "rgb:a89984"
}

