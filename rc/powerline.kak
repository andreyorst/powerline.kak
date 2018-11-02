# ╭─────────────╥───────────────────────╮
# │ Author:     ║ File:                 │
# │ Andrey Orst ║ powerline.kak         │
# ╞═════════════╩═══════════════════════╡
# │ Powerline plugin for Kakoune        │
# ╞═════════════════════════════════════╡
# │ GitHub.com/andreyorst/powerline.kak │
# ╰─────────────────────────────────────╯

# Options
declare-option -hidden str powerline_separator_left ''
declare-option -hidden str powerline_separator_left_thin ''
declare-option -hidden str powerline_separator_right ''
declare-option -hidden bool powerline_bidirectional_separators false

declare-option -hidden str powerline_pos_percent
declare-option -hidden str powerline_git_branch
declare-option -hidden str powerline_readonly

declare-option -docstring "if set to 'true' display git module in powerline"         bool powerline_module_git         true
declare-option -docstring "if set to 'true' display bufname module in powerline"     bool powerline_module_bufname     true
declare-option -docstring "if set to 'true' display line_column module in powerline" bool powerline_module_line_column true
declare-option -docstring "if set to 'true' display mode_info module in powerline"   bool powerline_module_mode_info   true
declare-option -docstring "if set to 'true' display filetype module in powerline"    bool powerline_module_filetype    true
declare-option -docstring "if set to 'true' display client module in powerline"      bool powerline_module_client      true
declare-option -docstring "if set to 'true' display session module in powerline"     bool powerline_module_session     true
declare-option -docstring "if set to 'true' display position module in powerline"    bool powerline_module_position    true

declare-option -hidden str powerline_bckground1 "rgb:3c3836"
declare-option -hidden str powerline_line_column_fg "rgb:3c3836"
declare-option -hidden str powerline_line_column_bg "rgb:504945"
declare-option -hidden str powerline_background3 "rgb:665c54"
declare-option -hidden str powerline_background3 "rgb:665c54"
declare-option -hidden str powerline_background4 "rgb:7c6f64"
declare-option -hidden str powerline_foreground0 "rgb:fbf1c7"
declare-option -hidden str powerline_foreground1 "rgb:ebdbb2"
declare-option -hidden str powerline_foreground2 "rgb:d5c4a1"
declare-option -hidden str powerline_git_fg "rgb:bdae93"

declare-option -hidden str powerline_buffile_bg "rgb:282828"
declare-option -hidden str powerline_buffile_fg "rgb:a89984"

# Commands
define-command -override -hidden \
powerline-update-position %{ evaluate-commands %sh{
    echo "set-option window powerline_pos_percent $(($kak_cursor_line * 100 / $kak_buf_line_count))%"
}}

define-command -override -hidden \
powerline-update-readonly %{ set-option global powerline_readonly %sh{
    if [ -w ${kak_buffile} ]; then
        echo ''
    else
        echo ' '
    fi
}}

define-command -override -hidden \
powerline-update-branch %{ set-option global powerline_git_branch %sh{
    branch=$(cd "${kak_buffile%/*}" 2>/dev/null && git rev-parse --abbrev-ref HEAD 2>/dev/null)
    if [ ! -z $branch ]; then
        echo "$kak_opt_powerline_separator_left_thin $branch "
    else
        echo ""
    fi
}}

# Hooks
hook global WinCreate .* %{
    powerline-update-position
    hook window NormalKey (j|k) powerline-update-position
    hook window NormalIdle .* powerline-update-position
}

hook global WinDisplay .* %{powerline-rebuild}

# Modeline
define-command -override -docstring "construct powerline acorrdingly to configuration options" \
powerline-rebuild %{
    set-option global modelinefmt %sh{
        left=$kak_opt_powerline_separator_left
        if [ "$kak_opt_powerline_bidirectional_separators" = "true" ]; then
            right1=$kak_opt_powerline_separator_right
            right2=$right1
        else
            fg=$kak_opt_powerline_buffile_fg
            bg=$kak_opt_powerline_buffile_bg
            right1="{$bg,$fg}$kak_opt_powerline_separator_left{$bg}"
            fg=default
            bg=default
            right2="{$bg,$bg}$kak_opt_powerline_separator_left{$bg}"
        fi

        if [ "$kak_opt_powerline_module_git" = "true" ]; then
            fg=$kak_opt_powerline_git_fg
            git="{$fg}%opt{powerline_git_branch} "
            next_bg=$kak_opt_powerline_line_column_bg
            next_fg=$kak_opt_powerline_line_column_fg
        fi
        if [ "$kak_opt_powerline_module_bufname" = "true" ]; then
            fg=$kak_opt_powerline_buffile_fg
            bg=$kak_opt_powerline_buffile_bg
            bufname="{$fg}$left{$bg,$fg} %val{bufname}{{context_info}}%opt{powerline_readonly} "
            next_bg=$bg2
            next_fg=$fg
        fi
        if [ "$kak_opt_powerline_module_line_column" = "true" ]; then
            if [ "$kak_opt_powerline_module_bufname" = "false" ]; then
                right1="{$bg2,$bg1}$kak_opt_powerline_separator_left{$bg2}"
            fi
            bg=$kak_opt_powerline_line_column_bg
            fg=$kak_opt_powerline_line_column_fg
            line_column="{${next_fg:-$fg},${next_bg:-$bg}}$right1{default,$bg2} {$fg2,$bg2}%val{cursor_line}{$fg2,$bg2}:{$fg2,$bg2}%val{cursor_char_column} "
            next_bg=$bg2
            next_fg=$bg2
        fi
        if [ "$kak_opt_powerline_module_mode_info" = "true" ]; then
            if [ "$kak_opt_powerline_module_line_column" = "false" ]; then
                if [ "$kak_opt_powerline_module_bufname" = "true" ]; then
                    if [ "$kak_opt_powerline_bidirectional_separators" = "false" ]; then
                        right2="{$bg1,$fg4}$kak_opt_powerline_separator_left{$bg2}"
                    fi
                fi
            fi
            mode_info="{${next_fg:-default},default}$right2 {{mode_info}} "
            next_bg="default"
        fi
        if [ "$kak_opt_powerline_module_filetype" = "true" ]; then
            if [ ! -z "$kak_opt_filetype" ]; then
                filetype="{$bg2,$next_bg}$left{$fg2,$bg2} %opt{filetype} "
                next_bg=$bg2
            fi
        fi
        if [ "$kak_opt_powerline_module_client" = "true" ]; then
            client="{$bg3,$next_bg}$left{$fg1,$bg3} %val{client} "
            next_bg=$bg3
        fi
        if [ "$kak_opt_powerline_module_session" = "true" ]; then
            session="{$bg4,$next_bg}$left{$fg0,$bg4} %val{session} "
            next_bg=$bg4
        fi
        if [ "$kak_opt_powerline_module_position" = "true" ]; then
            bg=$kak_opt_powerline_buffile_bg
            fg=$kak_opt_powerline_buffile_fg
            position="{$bg,$next_bg}$left{$fg,$bg} ≣ %opt{powerline_pos_percent} "
        fi

        echo "$git$bufname$line_column$mode_info$filetype$client$session$position"
    }
    powerline-update-branch
    powerline-update-readonly
}

define-command -override -docstring "change separators for powerline" \
-shell-script-candidates %{ for i in "arrow curve flame triangle none random"; do printf %s\\n $i; done } \
powerline-separator -params 1 %{ evaluate-commands %sh{
    if [ "$1" = "random" ]; then
        seed=$(($(date +%N | sed s:^\[0\]:1:) % 4 + 1)) # a posix compliant very-pseudo-random number generation
        separator=$(eval echo "arrow curve flame triangle | awk '{print \$$seed}'")
    else
        separator=$1
    fi
    case $separator in
        arrow)    left=''; thin=''; bidirectional="false" ;;
        curve)    left=''; thin=''; bidirectional="false" ;;
        flame)    left=''; thin=''; bidirectional="false" ;;
        triangle) left=''; thin=''; bidirectional="true"; right='' ;;
        none)     left='';  thin='';  bidirectional="false";;
        *) exit ;;
    esac
    echo "set-option window powerline_separator_left '$left'"
    echo "set-option window powerline_separator_left_thin '$thin'"
    [ -n "$right" ] && echo "set-option window powerline_separator_right '$right'"
    echo "set-option window powerline_bidirectional_separators '$bidirectional'"
    echo "powerline-rebuild"
}}

define-command -override -docstring "powerline-toggle <part> [<state>] toggle on and off displaying of powerline parts" \
-shell-script-candidates %{ for i in "git bufname line_column mode_info filetype client session position"; do printf %s\\n $i; done} \
powerline-toggle -params 1..2 %{ evaluate-commands %sh{
    case $1 in
        git)         [ "$kak_opt_powerline_module_git"         = "true" ] && value=false || value=true ;;
        bufname)     [ "$kak_opt_powerline_module_bufname"     = "true" ] && value=false || value=true ;;
        line_column) [ "$kak_opt_powerline_module_line_column" = "true" ] && value=false || value=true ;;
        mode_info)   [ "$kak_opt_powerline_module_mode_info"   = "true" ] && value=false || value=true ;;
        filetype)    [ "$kak_opt_powerline_module_filetype"    = "true" ] && value=false || value=true ;;
        client)      [ "$kak_opt_powerline_module_client"      = "true" ] && value=false || value=true ;;
        session)     [ "$kak_opt_powerline_module_session"     = "true" ] && value=false || value=true ;;
        position)    [ "$kak_opt_powerline_module_position"    = "true" ] && value=false || value=true ;;
        *) exit ;;
    esac
    if [ -n "$2" ]; then
        [ "$2" = "on" ] && value=true || value=false
    fi
    echo "set-option global powerline_module_$1 $value"
    echo "powerline-rebuild"
}}

