# ╭─────────────╥───────────────────────╮
# │ Author:     ║ File:                 │
# │ Andrey Orst ║ powerline.kak         │
# ╞═════════════╩═══════════════════════╡
# │ Powerline plugin for Kakoune        │
# ╞═════════════════════════════════════╡
# │ GitHub.com/andreyorst/powerline.kak │
# ╰─────────────────────────────────────╯

# Options
declare-option -hidden str powerline_separator ''
declare-option -hidden str powerline_separator_thin ''

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

declare-option -hidden str powerline_git_fg         blue
declare-option -hidden str powerline_git_bg         default
declare-option -hidden str powerline_bufname_bg     yellow
declare-option -hidden str powerline_bufname_fg     black
declare-option -hidden str powerline_line_column_fg black
declare-option -hidden str powerline_line_column_bg cyan
declare-option -hidden str powerline_mode_info_fg   black
declare-option -hidden str powerline_mode_info_bg   default
declare-option -hidden str powerline_filetype_fg    black
declare-option -hidden str powerline_filetype_bg    blue
declare-option -hidden str powerline_client_fg      black
declare-option -hidden str powerline_client_bg      cyan
declare-option -hidden str powerline_session_fg     black
declare-option -hidden str powerline_session_bg     magenta
declare-option -hidden str powerline_position_fg    black
declare-option -hidden str powerline_position_bg    yellow

# Commands
define-command -override -hidden \
powerline-update-position %{ evaluate-commands %sh{
    echo "set-option window powerline_pos_percent $(($kak_cursor_line * 100 / $kak_buf_line_count))%"
}}

define-command -override -hidden \
powerline-update-readonly %{ set-option window powerline_readonly %sh{
    if [ -w ${kak_buffile} ]; then
        echo ''
    else
        echo ' '
    fi
}}

define-command -override -hidden \
powerline-update-branch %{ set-option window powerline_git_branch %sh{
    if [ "$kak_opt_powerline_module_git" = "true" ]; then
        branch=$(cd "${kak_buffile%/*}" 2>/dev/null && git rev-parse --abbrev-ref HEAD 2>/dev/null)
    fi
    if [ -n $branch ]; then
        echo "$branch "
    else
        echo ""
    fi
}}

# Hooks
hook global WinCreate .* %{
    powerline-update-position
    hook window NormalKey (j|k) powerline-update-position
    hook window NormalIdle .* powerline-update-position
    hook global WinDisplay .* %{powerline-rebuild}
}

# Modeline
define-command -override -docstring "construct powerline acorrdingly to configuration options" \
powerline-rebuild %{
    set-option global modelinefmt %sh{
        normal=$kak_opt_powerline_separator
        thin=$kak_opt_powerline_separator_thin
        if [ "$kak_opt_powerline_module_git" = "true" ]; then
            fg=$kak_opt_powerline_git_fg
            bg=$kak_opt_powerline_git_bg
            if [ -n "$kak_opt_powerline_git_branch" ]; then
                git="$thin{$fg,$bg} %opt{powerline_git_branch} "
            fi
            next_bg=default
            next_fg=$kak_opt_powerline_line_column_bg
        fi
        if [ "$kak_opt_powerline_module_bufname" = "true" ]; then
            fg=$kak_opt_powerline_bufname_fg
            bg=$kak_opt_powerline_bufname_bg
            bufname="{$bg}$normal{$fg,$bg} %val{bufname}{{context_info}}%opt{powerline_readonly} "
            next_bg=$bg
            next_fg=$kak_opt_powerline_line_column_bg
        fi
        if [ "$kak_opt_powerline_module_line_column" = "true" ]; then
            fg=$kak_opt_powerline_line_column_fg
            bg=$kak_opt_powerline_line_column_bg
            line_column="{${next_fg:-$fg},${next_bg:-default}}$normal{$fg,$bg} %val{cursor_line}{$fg,$bg}:{$fg,$bg}%val{cursor_char_column} "
            next_bg=$bg
            next_fg=$bg
        fi
        if [ "$kak_opt_powerline_module_mode_info" = "true" ]; then
            bg=$kak_opt_powerline_mode_info_bg
            fg=$kak_opt_powerline_mode_info_fg
            mode_info="{$bg,${next_bg:-default}}$normal{default,default} {{mode_info}} "
            next_bg="default"
        fi
        if [ "$kak_opt_powerline_module_filetype" = "true" ]; then
            bg=$kak_opt_powerline_filetype_bg
            fg=$kak_opt_powerline_filetype_fg
            if [ ! -z "$kak_opt_filetype" ]; then
                filetype="{$bg,${next_bg:-default}}$normal{$fg,$bg} %opt{filetype} "
                next_bg=$bg
            fi
        fi
        if [ "$kak_opt_powerline_module_client" = "true" ]; then
            bg=$kak_opt_powerline_client_bg
            fg=$kak_opt_powerline_client_fg
            client="{$bg,${next_bg:-default}}$normal{$fg,$bg} %val{client} "
            next_bg=$bg
        fi
        if [ "$kak_opt_powerline_module_session" = "true" ]; then
            bg=$kak_opt_powerline_session_bg
            fg=$kak_opt_powerline_session_fg
            session="{$bg,${next_bg:-default}}$normal{$fg,$bg} %val{session} "
            next_bg=$bg
        fi
        if [ "$kak_opt_powerline_module_position" = "true" ]; then
            bg=$kak_opt_powerline_position_bg
            fg=$kak_opt_powerline_position_fg
            position="{$bg,${next_bg:-default}}$normal{$fg,$bg} ≣ %opt{powerline_pos_percent} "
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
        arrow)    normal=''; thin='';;
        curve)    normal=''; thin='';;
        flame)    normal=''; thin='';;
        triangle) normal=''; thin='';;
        none)     normal='';  thin='';;
        *) exit ;;
    esac
    echo "set-option window powerline_separator '$normal'"
    echo "set-option window powerline_separator_thin '$thin'"
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

define-command -override -docstring "powerline-theme <theme>: apply theme to powerline" \
-shell-script-candidates %{ for i in "base16 default"; do printf %s\\n $i; done} \
powerline-theme -params 1 %{ evaluate-commands %sh{
    echo "powerline-theme-$1"
    echo "powerline-rebuild"
}}
