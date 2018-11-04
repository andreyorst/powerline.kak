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

declare-option -docstring "powerline separator chatacter with solid body" str powerline_separator ''
declare-option -docstring "powerline separator chatacter thin" str powerline_separator_thin ''

declare-option -docstring "poweline format: order of powerline modules to render in modeline
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

declare-option -hidden str powerline_base_bg        default
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
define-command -hidden \
powerline-update-position %{ evaluate-commands %sh{
    echo "set-option window powerline_pos_percent $(($kak_cursor_line * 100 / $kak_buf_line_count))%"
}}

define-command -hidden \
powerline-update-readonly %{ set-option window powerline_readonly %sh{
    if [ -w ${kak_buffile} ]; then
        echo ''
    else
        echo ' '
    fi
}}

define-command -hidden \
powerline-update-branch %{ set-option window powerline_git_branch %sh{
    if [ "$kak_opt_powerline_module_git" = "true" ]; then
        branch=$(cd "${kak_buffile%/*}" 2>/dev/null && git rev-parse --abbrev-ref HEAD 2>/dev/null)
    fi
    if [ -n "$branch" ]; then
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
define-command -docstring "construct powerline acorrdingly to configuration options" \
powerline-rebuild %{
    set-option global modelinefmt %sh{
        modelinefmt=
        normal=$kak_opt_powerline_separator
        thin=$kak_opt_powerline_separator_thin
        next_bg=$kak_opt_powerline_base_bg
        git () {
            if [ "$kak_opt_powerline_module_git" = "true" ]; then
                fg=$kak_opt_powerline_git_fg
                bg=$kak_opt_powerline_git_bg
                if [ -n "$kak_opt_powerline_git_branch" ]; then
                    [ "$next_bg" = "$bg" ] && separator="{$fg,$bg}$thin" || separator="{$bg,${next_bg:-default}}$normal"
                    modelinefmt=$modelinefmt"$separator{$fg,$bg} %opt{powerline_git_branch} "
                fi
                next_bg=$bg
            fi
        }
        bufname () {
            if [ "$kak_opt_powerline_module_bufname" = "true" ]; then
                fg=$kak_opt_powerline_bufname_fg
                bg=$kak_opt_powerline_bufname_bg
                [ "$next_bg" = "$bg" ] && separator="{$fg,$bg}$thin" || separator="{$bg,${next_bg:-default}}$normal"
                modelinefmt=$modelinefmt"$separator{$fg,$bg} %val{bufname}{{context_info}}%opt{powerline_readonly} "
                next_bg=$bg
            fi
        }
        line_column () {
            if [ "$kak_opt_powerline_module_line_column" = "true" ]; then
                fg=$kak_opt_powerline_line_column_fg
                bg=$kak_opt_powerline_line_column_bg
                [ "$next_bg" = "$bg" ] && separator="{$fg,$bg}$thin" || separator="{$bg,${next_bg:-default}}$normal"
                modelinefmt=$modelinefmt"$separator{$fg,$bg} %val{cursor_line}{$fg,$bg}:{$fg,$bg}%val{cursor_char_column} "
                next_bg=$bg
            fi
        }
        mode_info () {
            if [ "$kak_opt_powerline_module_mode_info" = "true" ]; then
                bg=$kak_opt_powerline_mode_info_bg
                fg=$kak_opt_powerline_mode_info_fg
                [ "$next_bg" = "$bg" ] && separator="{$fg,$bg}$thin" || separator="{$bg,${next_bg:-default}}$normal"
                modelinefmt=$modelinefmt"$separator{default,default} {{mode_info}} "
                next_bg=$bg
            fi
        }
        filetype () {
            if [ "$kak_opt_powerline_module_filetype" = "true" ]; then
                bg=$kak_opt_powerline_filetype_bg
                fg=$kak_opt_powerline_filetype_fg
                if [ ! -z "$kak_opt_filetype" ]; then
                [ "$next_bg" = "$bg" ] && separator="{$fg,$bg}$thin" || separator="{$bg,${next_bg:-default}}$normal"
                    modelinefmt=$modelinefmt"$separator{$fg,$bg} %opt{filetype} "
                    next_bg=$bg
                fi
            fi
        }
        client () {
            if [ "$kak_opt_powerline_module_client" = "true" ]; then
                bg=$kak_opt_powerline_client_bg
                fg=$kak_opt_powerline_client_fg
                [ "$next_bg" = "$bg" ] && separator="{$fg,$bg}$thin" || separator="{$bg,${next_bg:-default}}$normal"
                modelinefmt=$modelinefmt"$separator{$fg,$bg} %val{client} "
                next_bg=$bg
            fi
        }
        session () {
            if [ "$kak_opt_powerline_module_session" = "true" ]; then
                bg=$kak_opt_powerline_session_bg
                fg=$kak_opt_powerline_session_fg
                [ "$next_bg" = "$bg" ] && separator="{$fg,$bg}$thin" || separator="{$bg,${next_bg:-default}}$normal"
                modelinefmt=$modelinefmt"$separator{$fg,$bg} %val{session} "
                next_bg=$bg
            fi
        }
        position() {
            if [ "$kak_opt_powerline_module_position" = "true" ]; then
                bg=$kak_opt_powerline_position_bg
                fg=$kak_opt_powerline_position_fg
                [ "$next_bg" = "$bg" ] && separator="{$fg,$bg}$thin" || separator="{$bg,${next_bg:-default}}$normal"
                modelinefmt=$modelinefmt"$separator{$fg,$bg} ≣ %opt{powerline_pos_percent} "
                next_bg=$bg
            fi
        }

        for module in $kak_opt_powerline_format; do
            eval $module
        done
        echo "$modelinefmt"
        # echo "$git$bufname$line_column$mode_info$filetype$client$session$position"
    }
    powerline-update-branch
    powerline-update-readonly
}

define-command -docstring "powerline-separator <separator>:change separators for powerline
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

define-command -docstring "powerline-theme <theme>: apply theme to powerline" \
-shell-script-candidates %{ eval "set -- $kak_opt_powerline_themes"; while [ "$1" ]; do echo $1; shift; done} \
powerline-theme -params 1 %{ evaluate-commands %sh{
    echo "powerline-theme-$1"
    echo "powerline-rebuild"
}}

define-command -docstring "powerline-format <formatstring>: change powerline format
default <formatstring> value:
    'git bufname line_column mode_info filetype client session position'

available modules for <formatstring>:
    git:         git branch
    bufname:     filename and information about buffer
    line_column: line and column
    mode_info:   mode information
    filetype:    filetype of current buffer
    client:      client name
    session:     session pid
    position:    percent position in file " \
-shell-script-completion %{ for i in "git bufname line_column mode_info filetype client session position"; do printf %s\\n $i; done} \
powerline-format -params 1.. %{ evaluate-commands %sh{
    formatstring=
    while [ "$1" ]; do
        formatstring="$formatstring $1"; shift
    done
    echo "set-option window powerline_format %{$formatstring}"
    echo "powerline-rebuild"
}}
