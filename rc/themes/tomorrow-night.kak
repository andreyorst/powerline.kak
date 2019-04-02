# Powerline colorscheme for Tomorrow-night Kakoune theme

declare-option -hidden str-list powerline_themes
set-option -add global powerline_themes "tomorrow-night"

define-command -hidden powerline-theme-tomorrow-night %{ evaluate-commands %sh{
    foreground="rgb:c5c8c6"
    background="rgb:272727"
    selection="rgb:373b41"
    window="rgb:383838"
    text="rgb:D8D8D8"
    text_light="rgb:4E4E4E"
    line="rgb:282a2e"
    comment="rgb:969896"
    red="rgb:cc6666"
    orange="rgb:d88860"
    yellow="rgb:f0c674"
    green="rgb:b5bd68"
    green_dark="rgb:a1b56c"
    blue="rgb:81a2be"
    aqua="rgb:87afaf"
    magenta="rgb:ab4642"
    purple="rgb:b294bb"

    echo "
        set-option global powerline_base_bg        ${window}
        set-option global powerline_git_fg         ${aqua}
        set-option global powerline_git_bg         ${line}
        set-option global powerline_bufname_fg     white
        set-option global powerline_bufname_bg     ${window}
        set-option global powerline_line_column_fg ${aqua}
        set-option global powerline_line_column_bg ${line}
        set-option global powerline_mode_info_fg   ${aqua}
        set-option global powerline_mode_info_bg   ${window}
        set-option global powerline_filetype_fg    ${aqua}
        set-option global powerline_filetype_bg    ${line}
        set-option global powerline_client_fg      ${aqua}
        set-option global powerline_client_bg      ${window}
        set-option global powerline_session_fg     ${aqua}
        set-option global powerline_session_bg     ${line}
        set-option global powerline_position_fg    ${aqua}
        set-option global powerline_position_bg    ${window}
    "
}}

