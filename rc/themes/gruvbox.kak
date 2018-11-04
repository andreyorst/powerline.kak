# Powerline colorscheme for base16 Kakoune theme

set-option -add global powerline_themes "gruvbox"

define-command -hidden powerline-theme-gruvbox %{ evaluate-commands %sh{
    gray="rgb:928374"
    red="rgb:fb4934"
    green="rgb:b8bb26"
    yellow="rgb:fabd2f"
    blue="rgb:83a598"
    purple="rgb:d3869b"
    aqua="rgb:8ec07c"
    orange="rgb:fe8019"

    bg="rgb:282828"
    bg1="rgb:3c3836"
    bg2="rgb:504945"
    bg3="rgb:665c54"
    bg4="rgb:7c6f64"

    fg0="rgb:fbf1c7"
    fg="rgb:ebdbb2"
    fg2="rgb:d5c4a1"
    fg3="rgb:bdae93"
    fg4="rgb:a89984"

    echo "
        set-option global powerline_base_bg        ${bg}
        set-option global powerline_git_fg         ${yellow}
        set-option global powerline_git_bg         ${bg}
        set-option global powerline_bufname_fg     ${bg}
        set-option global powerline_bufname_bg     ${fg}
        set-option global powerline_line_column_fg ${fg0}
        set-option global powerline_line_column_bg ${bg4}
        set-option global powerline_mode_info_fg   ${bg}
        set-option global powerline_mode_info_bg   ${bg}
        set-option global powerline_filetype_fg    ${fg3}
        set-option global powerline_filetype_bg    ${bg1}
        set-option global powerline_client_fg      ${fg2}
        set-option global powerline_client_bg      ${bg2}
        set-option global powerline_session_fg     ${fg}
        set-option global powerline_session_bg     ${bg3}
        set-option global powerline_position_fg    ${fg0}
        set-option global powerline_position_bg    ${bg4}
    "
}}

