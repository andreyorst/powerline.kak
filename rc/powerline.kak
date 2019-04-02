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

declare-option -hidden str powerline_color00 black
declare-option -hidden str powerline_color01 red
declare-option -hidden str powerline_color02 green
declare-option -hidden str powerline_color03 yellow
declare-option -hidden str powerline_color04 blue
declare-option -hidden str powerline_color05 magenta
declare-option -hidden str powerline_color06 cyan
declare-option -hidden str powerline_color07 white
declare-option -hidden str powerline_color08 bright-black
declare-option -hidden str powerline_color09 bright-red
declare-option -hidden str powerline_color10 bright-green
declare-option -hidden str powerline_color11 bright-yellow
declare-option -hidden str powerline_color12 bright-blue
declare-option -hidden str powerline_color13 bright-magenta
declare-option -hidden str powerline_color14 bright-cyan
declare-option -hidden str powerline_color15 bright-white

declare-option -hidden str powerline_next_bg %opt{powerline_color08}
declare-option -hidden str powerline_base_bg %opt{powerline_color08}

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
