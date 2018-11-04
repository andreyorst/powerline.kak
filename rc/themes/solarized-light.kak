# Powerline colorscheme for solarized-light Kakoune theme

set-option -add global powerline_themes "solarized-light"

define-command -hidden powerline-theme-solarized-light %{ evaluate-commands %sh{
	base03='rgb:002b36'
	base02='rgb:073642'
	base01='rgb:586e75'
	base00='rgb:657b83'
	base0='rgb:839496'
	base1='rgb:93a1a1'
	base2='rgb:eee8d5'
	base3='rgb:fdf6e3'
	yellow='rgb:b58900'
	orange='rgb:cb4b16'
	red='rgb:dc322f'
	magenta='rgb:d33682'
	violet='rgb:6c71c4'
	blue='rgb:268bd2'
	cyan='rgb:2aa198'
	green='rgb:859900'

    echo "
        set-option global powerline_base_bg        ${base2}
        set-option global powerline_git_fg         ${cyan}
        set-option global powerline_git_bg         ${base2}
        set-option global powerline_bufname_fg     ${base02}
        set-option global powerline_bufname_bg     ${base1}
        set-option global powerline_line_column_fg ${base02}
        set-option global powerline_line_column_bg ${base00}
        set-option global powerline_mode_info_fg   ${base1}
        set-option global powerline_mode_info_bg   ${base2}
        set-option global powerline_filetype_fg    ${base02}
        set-option global powerline_filetype_bg    ${base1}
        set-option global powerline_client_fg      ${base02}
        set-option global powerline_client_bg      ${base0}
        set-option global powerline_session_fg     ${base02}
        set-option global powerline_session_bg     ${base00}
        set-option global powerline_position_fg    ${orange}
        set-option global powerline_position_bg    ${base02}
    "
}}

