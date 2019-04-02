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

declare-option -docstring "powerline separator character with solid body" str powerline_separator ''
declare-option -docstring "powerline separator character thin" str powerline_separator_thin ''

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

# Default Module Colors Table
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
# | Name        | foreground | background   |
# |-------------+------------+--------------|
# | bufname     | color00    | color03      |
# | client      | color12    | color13      |
# | filetype    | color10    | color11      |
# | git         | color02    | color04      |
# | line-column | color06    | color09      |
# | mode-info   | color07    | base_bg (08) |
# | position    | color01    | color05      |
# | session     | color14    | color15      |

declare-option -hidden str powerline_color00 black    # bufname fg
declare-option -hidden str powerline_color01 yellow   # position fg
declare-option -hidden str powerline_color02 green    # git fg
declare-option -hidden str powerline_color03 yellow   # bufname bg
declare-option -hidden str powerline_color04 black    # git bg
declare-option -hidden str powerline_color05 black    # position bg
declare-option -hidden str powerline_color06 cyan     # line-column fg
declare-option -hidden str powerline_color07 blue     # mode-info fg
declare-option -hidden str powerline_color08 black    # base background
declare-option -hidden str powerline_color09 black    # line-column bg
declare-option -hidden str powerline_color10 yellow   # filetype fg
declare-option -hidden str powerline_color11 black    # filetype bg
declare-option -hidden str powerline_color12 blue     # client bg
declare-option -hidden str powerline_color13 black    # client fg
declare-option -hidden str powerline_color14 cyan     # session fg
declare-option -hidden str powerline_color15 black    # session bg
declare-option -hidden str powerline_color16 default  # unused
declare-option -hidden str powerline_color17 default  # unused
declare-option -hidden str powerline_color18 default  # unused
declare-option -hidden str powerline_color19 default  # unused
declare-option -hidden str powerline_color20 default  # unused
declare-option -hidden str powerline_color21 default  # unused
declare-option -hidden str powerline_color22 default  # unused
declare-option -hidden str powerline_color23 default  # unused
declare-option -hidden str powerline_color24 default  # unused
declare-option -hidden str powerline_color25 default  # unused
declare-option -hidden str powerline_color26 default  # unused
declare-option -hidden str powerline_color27 default  # unused
declare-option -hidden str powerline_color28 default  # unused
declare-option -hidden str powerline_color29 default  # unused

hook global GlobalSetOption powerline_color08=.* %{
    declare-option -hidden str powerline_next_bg %opt{powerline_color08}
    declare-option -hidden str powerline_base_bg %opt{powerline_color08}
}

declare-option -docstring "if 'true' additionally display text formatted position in file, like 'top' and  'bottom'" \
bool powerline_position_text_format false

hook -group powerline global WinDisplay .* %{powerline-rebuild}

define-command -docstring "construct powerline acorrdingly to configuration options" \
powerline-rebuild %{
    evaluate-commands %sh{
        echo "set-option global powerlinefmt ''"
        echo "set-option global powerline_next_bg %opt{powerline_base_bg}"

        for module in $kak_opt_powerline_format; do
            module=$(echo $module | sed "s:[^a-zA-Z-]:-:")
            echo "powerline-$module"
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
    echo "set-option global powerline_separator '$normal'"
    echo "set-option global powerline_separator_thin '$thin'"
    echo "powerline-rebuild"
}}

define-command -docstring "powerline-toggle <part> [<state>] toggle on and off displaying of powerline parts" \
-shell-script-candidates %{eval "set -- $kak_opt_powerline_modules"; while [ "$1" ]; do echo $1; shift; done} \
powerline-toggle -params 1..2 %{ evaluate-commands %sh{
    module=$(echo $1 | sed "s:[^a-zA-Z-]:-:")
    echo "try %{ powerline-toggle-$module $2 } catch %{ echo -debug %{can't toggle $1, command 'powerline-toggle-$module' not found} }"
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
    echo "set-option global powerline_format %{$formatstring}"
    echo "powerline-rebuild"
}}
