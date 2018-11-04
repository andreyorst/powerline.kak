## Powerline colorscheme for reeder Kakoune theme

set-option -add global powerline_themes "reeder"

define-command -hidden powerline-theme-reeder %{ evaluate-commands %sh{
    white="rgb:f9f8f6"
    white_light="rgb:f6f5f0"
    black="rgb:383838"
    black_light="rgb:635240"
    grey_dark="rgb:c6b0a4"
    grey_light="rgb:e8e8e8"
    brown_dark="rgb:af4609"
    brown_light="rgb:baa188"
    brown_lighter="rgb:f0e7df"
    orange="rgb:fc7302"
    orange_light="rgb:f88e3b"
    green="rgb:438047"
    green_light="rgb:7ba84d"
    red="rgb:f03c3c"
    echo "
        set-option global powerline_base_bg        ${grey_light}
        set-option global powerline_git_fg         ${black_light}
        set-option global powerline_git_bg         ${brown_light}
        set-option global powerline_bufname_fg     ${black_light}
        set-option global powerline_bufname_bg     ${brown_lighter}
        set-option global powerline_line_column_fg ${black_light}
        set-option global powerline_line_column_bg ${brown_light}
        set-option global powerline_mode_info_fg   ${black_light}
        set-option global powerline_mode_info_bg   ${grey_light}
        set-option global powerline_filetype_fg    ${black_light}
        set-option global powerline_filetype_bg    ${grey_dark}
        set-option global powerline_client_fg      ${grey_dark}
        set-option global powerline_client_bg      ${black_light}
        set-option global powerline_session_fg     ${grey_dark}
        set-option global powerline_session_bg     ${black}
        set-option global powerline_position_fg    ${black_light}
        set-option global powerline_position_bg    ${brown_lighter}
    "
}}

