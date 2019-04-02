# Powerline colorscheme for red-phoenix Kakoune theme

declare-option -hidden str-list powerline_themes
set-option -add global powerline_themes "red-phoenix"

define-command -hidden powerline-theme-red-phoenix %{ evaluate-commands %sh{
    default="rgb:2d2d2d"
    black="rgb:000000"
    blue="rgb:81a2be"
    orange1="rgb:F2361E"
    orange2="rgb:ED4B19"
    orange3="rgb:FA390F"
    light_orange1="rgb:DF9767"
    white1="rgb:EDEDED"
    white2="rgb:E1E1E1"
    gray1="rgb:6F6F6F"
    gray2="rgb:D1D1D1"
    gray3="rgb:2D2D2D"
    gray4="rgb:909090"
    tan1="rgb:D2C3AD"
    tan2="rgb:AAA998"
    tan3="rgb:DF9767"
    yellow1="rgb:AAA998"
    purple1="rgb:4C3A3D"

    echo "
        set-option global powerline_base_bg        ${default}

        set-option global powerline_git_fg         white
        set-option global powerline_git_bg         ${black}
        set-option global powerline_bufname_fg     white
        set-option global powerline_bufname_bg     ${default}
        set-option global powerline_line_column_fg white
        set-option global powerline_line_column_bg ${black}
        set-option global powerline_mode_info_fg   red
        set-option global powerline_mode_info_bg   ${default}
        set-option global powerline_filetype_fg    ${default}
        set-option global powerline_filetype_bg    ${light_orange1}
        set-option global powerline_client_fg      ${default}
        set-option global powerline_client_bg      ${orange2}
        set-option global powerline_session_fg     ${default}
        set-option global powerline_session_bg     ${orange3}
        set-option global powerline_position_fg    ${default}
        set-option global powerline_position_bg    ${orange1}
    "
}}

