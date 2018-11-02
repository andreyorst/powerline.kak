# Powerline colorscheme for base16 Kakoune theme

set-option -add global powerline_themes "base16"

define-command -hidden powerline-theme-base16 %{ evaluate-commands %sh{
    black_lighterer='rgb:383838'
    black_lighter='rgb:2D2D2D'
    black_light='rgb:1C1C1C'
    cyan_light='rgb:7CB0FF'
    green_dark='rgb:A1B56C'
    grey_dark='rgb:585858'
    grey_light='rgb:D8D8D8'
    magenta_dark='rgb:AB4642'
    magenta_light='rgb:AB4434'
    orange_dark='rgb:DC9656'
    orange_light='rgb:F7CA88'
    purple_dark='rgb:BA8BAF'
    echo "
        set-option global powerline_git_fg         ${cyan_light}
        set-option global powerline_git_bg         ${black_lighterer}
        set-option global powerline_bufname_fg     ${black_light}
        set-option global powerline_bufname_bg     ${cyan_light}
        set-option global powerline_line_column_fg ${grey_light}
        set-option global powerline_line_column_bg ${grey_dark}
        set-option global powerline_mode_info_fg   ${black_lighterer}
        set-option global powerline_mode_info_bg   ${black_lighterer}
        set-option global powerline_filetype_fg    ${grey_light}
        set-option global powerline_filetype_bg    ${grey_dark}
        set-option global powerline_client_fg      ${black_lighter}
        set-option global powerline_client_bg      ${orange_light}
        set-option global powerline_session_fg     ${black_lighter}
        set-option global powerline_session_bg     ${orange_dark}
        set-option global powerline_position_fg    ${grey_light}
        set-option global powerline_position_bg    ${black_lighterer}
    "
}}

