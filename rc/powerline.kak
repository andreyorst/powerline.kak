# ╭─────────────╥───────────────────────╮
# │ Author:     ║ File:                 │
# │ Andrey Orst ║ powerline.kak         │
# ╞═════════════╩═══════════════════════╡
# │ Powerline plugin for Kakoune        │
# ╞═════════════════════════════════════╡
# │ GitHub.com/andreyorst/powerline.kak │
# ╰─────────────────────────────────────╯

# Options
declare-option -hidden str-list powerline_themes
declare-option -hidden str-list powerline_modules

set-option -add global powerline_modules 'git'
set-option -add global powerline_modules 'bufname'
set-option -add global powerline_modules 'line_column'
set-option -add global powerline_modules 'mode_info'
set-option -add global powerline_modules 'filetype'
set-option -add global powerline_modules 'client'
set-option -add global powerline_modules 'session'
set-option -add global powerline_modules 'position'

declare-option -docstring "powerline separator chatacter with solid body" str powerline_separator ''
declare-option -docstring "powerline separator chatacter thin" str powerline_separator_thin ''

declare-option -docstring "powerline format: order of powerline modules to render in modeline
default value:
    'git bufname line_column mode_info filetype client session position'

available modules:
    git:         git branch
    bufname:     filename and information about buffer
    line_column: line and column
    mode_info:   mode information
    filetype:    filetype of current buffer
    client:      client name
    session:     session pid
    position:    percent position in file " \
str powerline_format "git bufname line_column mode_info filetype client session position"

declare-option -hidden -docstring "powerlinefmt is something similar to modelinefmt
used to store powerline configuration before passing it to modeline.
should never be accessed or modified directly" \
str powerlinefmt

declare-option -hidden str powerline_next_bg

declare-option -docstring "if set to 'true' display git module in powerline" \
bool powerline_module_git true
declare-option -docstring "if set to 'true' display bufname module in powerline" \
bool powerline_module_bufname true
declare-option -docstring "if set to 'true' display line_column module in powerline" \
bool powerline_module_line_column true
declare-option -docstring "if set to 'true' display mode_info module in powerline" \
bool powerline_module_mode_info true
declare-option -docstring "if set to 'true' display filetype module in powerline" \
bool powerline_module_filetype true
declare-option -docstring "if set to 'true' display client module in powerline" \
bool powerline_module_client true
declare-option -docstring "if set to 'true' display session module in powerline" \
bool powerline_module_session true
declare-option -docstring "if set to 'true' display position module in powerline" \
bool powerline_module_position true

declare-option -hidden str powerline_base_bg       default
declare-option -hidden str powerline_git_fg        blue
declare-option -hidden str powerline_git_bg        default
declare-option -hidden str powerline_bufname_bg    yellow
declare-option -hidden str powerline_bufname_fg    black
declare-option -hidden str powerline_line_column_fg black
declare-option -hidden str powerline_line_column_bg cyan
declare-option -hidden str powerline_mode_info_fg   black
declare-option -hidden str powerline_mode_info_bg   default
declare-option -hidden str powerline_filetype_fg   black
declare-option -hidden str powerline_filetype_bg   blue
declare-option -hidden str powerline_client_fg     black
declare-option -hidden str powerline_client_bg     cyan
declare-option -hidden str powerline_session_fg    black
declare-option -hidden str powerline_session_bg    magenta
declare-option -hidden str powerline_position_fg   black
declare-option -hidden str powerline_position_bg   yellow

declare-option -docstring "if 'true' additionally display text formatted position in file, like 'top' and  'bottom'" \
bool powerline_position_text_format false

# Commands
declare-option -hidden str powerline_pos_percent
define-command -hidden powerline-update-position %{ evaluate-commands %sh{
    position="$(($kak_cursor_line * 100 / $kak_buf_line_count))%"
    if [ "$kak_opt_powerline_position_text_format" = "true" ]; then
        if [ "$position" = "100%" ]; then
            position="bottom"
        elif [ $kak_cursor_line -eq 1 ]; then
            position="top"
        fi
    fi
    echo "set-option window powerline_pos_percent $position"
}}

declare-option -hidden str powerline_readonly
define-command -hidden powerline-update-readonly %{ set-option window powerline_readonly %sh{
    if [ -w ${kak_buffile} ]; then
        echo ''
    else
        echo ' '
    fi
}}

declare-option -hidden str powerline_git_branch
define-command -hidden powerline-update-branch %{ set-option window powerline_git_branch %sh{
    if [ "$kak_opt_powerline_module_git" = "true" ]; then
        branch=$(cd "${kak_buffile%/*}" 2>/dev/null && git rev-parse --abbrev-ref HEAD 2>/dev/null)
    fi
    if [ -n "$branch" ]; then
        echo "$branch "
    else
        echo ""
    fi
}}

# auto-pairs section
declare-option -hidden str powerline_auto_pairs 'surround'
declare-option -hidden bool powerline_module_auto_pairs true
set-option -add global powerline_modules 'auto_pairs'

## auto-pairs update command
define-command -hidden powerline-update-auto-pairs %{ evaluate-commands %sh{
    if [ "$kak_opt_auto_pairs_surround_enabled" = "true" ]; then
        echo "powerline-toggle auto_pairs on"
    else
        echo "powerline-toggle auto_pairs off"
    fi
}}

## auto-pairs update hook
hook global WinCreate .* %{
    powerline-update-auto-pairs
    hook window ModeChange 'normal:insert' powerline-update-auto-pairs
    hook window ModeChange 'insert:normal' %{powerline-toggle auto_pairs off}
}

## auto-pairs module
define-command -hidden powerline-auto-pairs %{ evaluate-commands %sh{
    default=$kak_opt_powerline_base_bg
    next_bg=$kak_opt_powerline_next_bg
    normal=$kak_opt_powerline_separator
    thin=$kak_opt_powerline_separator_thin
    if [ "$kak_opt_powerline_module_auto_pairs" = "true" ]; then
        bg=$kak_opt_powerline_mode_info_bg
        fg=$kak_opt_powerline_mode_info_fg
        [ "$next_bg" = "$bg" ] && separator="{$fg,$bg}$thin" || separator="{$bg,${next_bg:-$default}}$normal"
        echo "set-option -add window powerlinefmt %{$separator{$fg,$bg} %opt{powerline_auto_pairs} }"
        echo "set-option window powerline_next_bg $bg"
    fi
}}

define-command -hidden powerline-toggle-auto-pairs -params ..1 %{ evaluate-commands %sh{
    [ "$kak_opt_powerline_module_auto_pairs" = "true" ] && value=false || value=true
    if [ -n "$1" ]; then
        [ "$1" = "on" ] && value=true || value=false
    fi
    echo "set-option global powerline_module_auto_pairs $value"
    echo "powerline-rebuild"
}}


# Hooks
hook global WinCreate .* %{
    powerline-update-position
    powerline-update-branch
    hook window NormalKey (j|k) powerline-update-position
    hook window NormalIdle .* powerline-update-position
    hook global WinDisplay .* %{powerline-rebuild}
}

# Modules
define-command -hidden powerline-git %{ evaluate-commands %sh{
    default=$kak_opt_powerline_base_bg
    next_bg=$kak_opt_powerline_next_bg
    normal=$kak_opt_powerline_separator
    thin=$kak_opt_powerline_separator_thin
    if [ "$kak_opt_powerline_module_git" = "true" ]; then
        fg=$kak_opt_powerline_git_fg
        bg=$kak_opt_powerline_git_bg
        if [ -n "$kak_opt_powerline_git_branch" ]; then
            [ "$next_bg" = "$bg" ] && separator="{$fg,$bg}$thin" || separator="{$bg,${next_bg:-$default}}$normal"
            echo "set-option -add window powerlinefmt %{$separator{$fg,$bg} %opt{powerline_git_branch} }"
            echo "set-option window powerline_next_bg $bg"
        fi
    fi
}}

define-command -hidden powerline-bufname %{ evaluate-commands %sh{
    default=$kak_opt_powerline_base_bg
    next_bg=$kak_opt_powerline_next_bg
    normal=$kak_opt_powerline_separator
    thin=$kak_opt_powerline_separator_thin
    if [ "$kak_opt_powerline_module_bufname" = "true" ]; then
        fg=$kak_opt_powerline_bufname_fg
        bg=$kak_opt_powerline_bufname_bg
        [ "$next_bg" = "$bg" ] && separator="{$fg,$bg}$thin" || separator="{$bg,${next_bg:-$default}}$normal"
        echo "set-option -add window powerlinefmt %{$separator{$fg,$bg} %val{bufname}{{context_info}}%opt{powerline_readonly} }"
        echo "set-option window powerline_next_bg $bg"
    fi
}}

define-command -hidden powerline-line-column %{ evaluate-commands %sh{
    default=$kak_opt_powerline_base_bg
    next_bg=$kak_opt_powerline_next_bg
    normal=$kak_opt_powerline_separator
    thin=$kak_opt_powerline_separator_thin
    if [ "$kak_opt_powerline_module_line_column" = "true" ]; then
        fg=$kak_opt_powerline_line_column_fg
        bg=$kak_opt_powerline_line_column_bg
        [ "$next_bg" = "$bg" ] && separator="{$fg,$bg}$thin" || separator="{$bg,${next_bg:-$default}}$normal"
        echo "set-option -add window powerlinefmt %{$separator{$fg,$bg} %val{cursor_line}{$fg,$bg}:{$fg,$bg}%val{cursor_char_column} }"
        echo "set-option window powerline_next_bg $bg"
    fi
}}

define-command -hidden powerline-mode-info %{ evaluate-commands %sh{
    default=$kak_opt_powerline_base_bg
    next_bg=$kak_opt_powerline_next_bg
    normal=$kak_opt_powerline_separator
    thin=$kak_opt_powerline_separator_thin
    if [ "$kak_opt_powerline_module_mode_info" = "true" ]; then
        bg=$kak_opt_powerline_mode_info_bg
        fg=$kak_opt_powerline_mode_info_fg
        [ "$next_bg" = "$bg" ] && separator="{$fg,$bg}$thin" || separator="{$bg,${next_bg:-$default}}$normal"
        echo "set-option -add window powerlinefmt %{$separator{$fg,$bg} {{mode_info}} }"
        echo "set-option window powerline_next_bg $bg"
    fi
}}

define-command -hidden powerline-filetype %{ evaluate-commands %sh{
    default=$kak_opt_powerline_base_bg
    next_bg=$kak_opt_powerline_next_bg
    normal=$kak_opt_powerline_separator
    thin=$kak_opt_powerline_separator_thin
    if [ "$kak_opt_powerline_module_filetype" = "true" ]; then
        bg=$kak_opt_powerline_filetype_bg
        fg=$kak_opt_powerline_filetype_fg
        if [ ! -z "$kak_opt_filetype" ]; then
        [ "$next_bg" = "$bg" ] && separator="{$fg,$bg}$thin" || separator="{$bg,${next_bg:-$default}}$normal"
            echo "set-option -add window powerlinefmt %{$separator{$fg,$bg} %opt{filetype} }"
            echo "set-option window powerline_next_bg $bg"
        fi
    fi
}}

define-command -hidden powerline-client %{ evaluate-commands %sh{
    default=$kak_opt_powerline_base_bg
    next_bg=$kak_opt_powerline_next_bg
    normal=$kak_opt_powerline_separator
    thin=$kak_opt_powerline_separator_thin
    if [ "$kak_opt_powerline_module_client" = "true" ]; then
        bg=$kak_opt_powerline_client_bg
        fg=$kak_opt_powerline_client_fg
        [ "$next_bg" = "$bg" ] && separator="{$fg,$bg}$thin" || separator="{$bg,${next_bg:-$default}}$normal"
        echo "set-option -add window powerlinefmt %{$separator{$fg,$bg} %val{client} }"
        echo "set-option window powerline_next_bg $bg"
    fi
}}

define-command -hidden powerline-session %{ evaluate-commands %sh{
    default=$kak_opt_powerline_base_bg
    next_bg=$kak_opt_powerline_next_bg
    normal=$kak_opt_powerline_separator
    thin=$kak_opt_powerline_separator_thin
    if [ "$kak_opt_powerline_module_session" = "true" ]; then
        bg=$kak_opt_powerline_session_bg
        fg=$kak_opt_powerline_session_fg
        [ "$next_bg" = "$bg" ] && separator="{$fg,$bg}$thin" || separator="{$bg,${next_bg:-$default}}$normal"
        echo "set-option -add window powerlinefmt %{$separator{$fg,$bg} %val{session} }"
        echo "set-option window powerline_next_bg $bg"
    fi
}}

define-command -hidden powerline-position %{ evaluate-commands %sh{
    default=$kak_opt_powerline_base_bg
    next_bg=$kak_opt_powerline_next_bg
    normal=$kak_opt_powerline_separator
    thin=$kak_opt_powerline_separator_thin
    if [ "$kak_opt_powerline_module_position" = "true" ]; then
        bg=$kak_opt_powerline_position_bg
        fg=$kak_opt_powerline_position_fg
        [ "$next_bg" = "$bg" ] && separator="{$fg,$bg}$thin" || separator="{$bg,${next_bg:-$default}}$normal"
        echo "set-option -add window powerlinefmt %{$separator{$fg,$bg} ≣ %opt{powerline_pos_percent} }"
        echo "set-option window powerline_next_bg $bg"
    fi
}}

# Modeline
define-command -docstring "construct powerline acorrdingly to configuration options" \
powerline-rebuild %{
    set-option window powerlinefmt ''
    set-option window powerline_next_bg ''

    evaluate-commands %sh{
        for module in $kak_opt_powerline_format; do
            module=$(echo $module | sed "s:[^a-zA-Z-]:-:")
            echo "try %{ powerline-$module }"
        done
    }
    set-option global modelinefmt %sh{echo "$kak_opt_powerlinefmt"}
}

define-command -docstring "powerline-separator <separator>: change separators for powerline
if <separator> is 'custom' accepts two additional separators fot normal and thin variants" \
-shell-script-candidates %{ for i in "arrow curve flame triangle triangle-inverted none random custom"; do printf %s\\n $i; done } \
powerline-separator -params 1..3 %{ evaluate-commands %sh{
    if [ "$1" = "random" ]; then
        seed=$(($(date +%N | sed s:^\[0\]:1:) % 4 + 1)) # a posix compliant very-pseudo-random number generation
        separator=$(eval echo "arrow curve flame triangle | awk '{print \$$seed}'")
    else
        separator=$1
    fi
    case $separator in
        none)              normal='';  thin='';;
        arrow)             normal=''; thin='';;
        curve)             normal=''; thin='';;
        flame)             normal=''; thin='';;
        triangle)          normal=''; thin='';;
        triangle-inverted) normal=''; thin='';;
        custom)
            if [ -n "$2" ]; then
                normal="$2"
            else
                normal=''
            fi
            if [ -n "$3" ]; then
                thin="$3"
            elif [ -n "$2" ]; then
                thin=$2
            else
                thin=''
            fi
            ;;
        *) exit ;;
    esac
    echo "set-option window powerline_separator '$normal'"
    echo "set-option window powerline_separator_thin '$thin'"
    echo "powerline-rebuild"
}}

define-command -docstring "powerline-toggle <part> [<state>] toggle on and off displaying of powerline parts" \
-shell-script-candidates %{eval "set -- $kak_opt_powerline_modules"; while [ "$1" ]; do echo $1; shift; done} \
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
        *)
            module=$(echo $1 | sed "s:[^a-zA-Z-]:-:")
            echo "try %{ powerline-toggle-$module $2} catch %{ echo -debug %{no such module $module} }"
            exit ;;
    esac
    if [ -n "$2" ]; then
        [ "$2" = "on" ] && value=true || value=false
    fi
    echo "set-option global powerline_module_$1 $value"
    echo "powerline-rebuild"
}}

define-command -docstring "powerline-theme <theme>: apply theme to powerline" \
-shell-script-candidates %{ eval "set -- $kak_opt_powerline_themes"; while [ "$1" ]; do echo $1; shift; done} \
powerline-theme -params 1 %{ evaluate-commands %sh{
    echo "powerline-theme-$1"
    echo "powerline-rebuild"
}}

define-command -docstring "powerline-format <formatstring>: change powerline format. Use <Tab> completion to get available modules.

powerline-format default: resets powerline format to default value, which is:
    'git bufname line_column mode_info filetype client session position'" \
-shell-script-completion %{eval "set -- $kak_opt_powerline_modules"; while [ "$1" ]; do echo $1; shift; done} \
powerline-format -params 1.. %{ evaluate-commands %sh{
    if [ "$1" = "default" ]; then
        formatstring="git bufname line_column mode_info filetype client session position"
    else
        formatstring=
        while [ "$1" ]; do
            formatstring="$formatstring $1"; shift
        done
    fi
    echo "set-option window powerline_format %{$formatstring}"
    echo "powerline-rebuild"
}}
