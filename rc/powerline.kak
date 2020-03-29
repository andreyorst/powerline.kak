# ╭─────────────╥───────────────────────╮
# │ Author:     ║ File:                 │
# │ Andrey Orst ║ powerline.kak         │
# ╞═════════════╩═══════════════════════╡
# │ Powerline plugin for Kakoune        │
# ╞═════════════════════════════════════╡
# │ GitHub.com/andreyorst/powerline.kak │
# ╰─────────────────────────────────────╯

declare-option -hidden -docstring "old modelinefmt value is stored here." \
str powerline_modelinefmt_backup %opt{modelinefmt}

declare-option -hidden bool powerline_on_screen false

define-command -docstring "powerline-start: require poserline module and enable powerline for all buffers." \
powerline-start %{
    set-option global powerline_on_screen true
    hook -once global BufCreate .* %{
        require-module powerline
        powerline-enable
    }
}

provide-module powerline %§

# Options
declare-option -hidden str-list powerline_themes
declare-option -hidden str-list powerline_modules

declare-option -docstring "powerline separator character with solid body." str powerline_separator ''
declare-option -docstring "powerline separator character thin." str powerline_separator_thin ''

declare-option -docstring "ignore warnings when building powerline." bool powerline_ignore_warnings false

declare-option -docstring "powerline format: order of powerline modules to render in modeline.
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
    position:    percent position in file" \
str powerline_format "git bufname line_column mode_info filetype client session position"

declare-option -hidden -docstring "powerlinefmt is something similar to modelinefmt
used to store powerline configuration before passing it to modeline.
should never be accessed or modified directly." \
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
# | position    | color05    | color01      |
# | session     | color14    | color15      |

declare-option -hidden str powerline_color00 black  # fg: bufname
declare-option -hidden str powerline_color01 yellow # bg: position
declare-option -hidden str powerline_color02 green  # fg: git
declare-option -hidden str powerline_color03 yellow # bg: bufname
declare-option -hidden str powerline_color04 black  # bg: git
declare-option -hidden str powerline_color05 black  # fg: position
declare-option -hidden str powerline_color06 cyan   # fg: line-column
declare-option -hidden str powerline_color07 blue   # fg: mode-info
declare-option -hidden str powerline_color08 black  # base background
declare-option -hidden str powerline_color09 black  # bg: line-column
declare-option -hidden str powerline_color10 yellow # fg: filetype
declare-option -hidden str powerline_color11 black  # bg: filetype
declare-option -hidden str powerline_color12 blue   # bg: client
declare-option -hidden str powerline_color13 black  # fg: client
declare-option -hidden str powerline_color14 cyan   # fg: session
declare-option -hidden str powerline_color15 black  # bg: session
declare-option -hidden str powerline_color16 black  # unused
declare-option -hidden str powerline_color17 yellow # unused
declare-option -hidden str powerline_color18 green  # unused
declare-option -hidden str powerline_color19 yellow # unused
declare-option -hidden str powerline_color20 black  # unused
declare-option -hidden str powerline_color21 black  # unused
declare-option -hidden str powerline_color22 cyan   # unused
declare-option -hidden str powerline_color23 blue   # unused
declare-option -hidden str powerline_color24 black  # unused
declare-option -hidden str powerline_color25 black  # unused
declare-option -hidden str powerline_color26 yellow # unused
declare-option -hidden str powerline_color27 black  # unused
declare-option -hidden str powerline_color28 blue   # unused
declare-option -hidden str powerline_color29 black  # unused
declare-option -hidden str powerline_color30 cyan   # unused
declare-option -hidden str powerline_color31 black  # unused

declare-option -hidden str powerline_next_bg %opt{powerline_color08}
declare-option -hidden str powerline_base_bg %opt{powerline_color08}

define-command -docstring "powerline-enable: enable powerline for all buffers." \
powerline-enable -params ..1 %{
    set-option global powerline_on_screen true
    remove-hooks global powerline(-.*)?
    evaluate-commands %sh{
        eval "set -- $kak_quoted_client_list"
        while [ $# -gt 0 ]; do
            printf "%s\n" "evaluate-commands -client '$1' %{ powerline-rebuild-buffer }"
            shift
        done
    }
    hook -group powerline global WinDisplay .* powerline-rebuild-buffer
    hook -group powerline global WinSetOption powerline_format=.* powerline-rebuild-buffer
}

define-command -docstring "powerline-disable: disable powerline for all buffers." \
powerline-disable  -params ..1 %{
    set-option global powerline_on_screen false
    remove-hooks global powerline(-.*)?
    evaluate-commands %sh{
        eval "set -- $kak_quoted_buflist"
        while [ $# -gt 0 ]; do
            printf "%s\n" "evaluate-commands -buffer '$1' %{
                               set-option buffer modelinefmt %opt{powerline_modelinefmt_backup}
                           }"
            shift
        done
    }
}

define-command -docstring "powerline-toggle: toggle powerline in current buffer." \
powerline-toggle -params ..1 %{ evaluate-commands %sh{
    if [ "$kak_opt_powerline_on_screen" = "true" ]; then
        printf "%s\n" "powerline-disable"
    else
        printf "%s\n" "powerline-enable"
    fi
}}

define-command -docstring "construct powerline for current buffer acorrdingly to configuration options." \
powerline-rebuild-buffer %{
    evaluate-commands %sh{
        if [ "$kak_opt_powerline_on_screen" != "true" ]; then
            printf "%s\n" "echo -markup %{{default}powerline is disabled. Enable with \`{meta}powerline-enable{default}' to rebuild}"
            exit
        fi
        printf "%s\n" "set-option global powerlinefmt ''"
        printf "%s\n" "set-option global powerline_next_bg %opt{powerline_base_bg}"

        for module in ${kak_opt_powerline_format}; do
            [ ! "${kak_opt_powerline_ignore_warnings}" = "true" ] && warning="catch %{ echo -debug %{powerline.kak: Warning, trying to load non-existing module '${module}'} }"
            module=$(printf "%s\n" ${module} | sed "s:[^a-zA-Z-]:-:g")
            printf "%s\n" "try %{ powerline-${module} } ${warning}"
            printf "%s\n" "try %{ powerline-${module}-setup-hooks }"
        done
    }

    set-option buffer modelinefmt %opt{powerlinefmt}
}

define-command -docstring "powerline-separator <separator>: change separators for powerline
if <separator> is 'custom' accepts two additional separators fot normal and thin variants." \
-shell-script-candidates %{ for i in ascii-arrow ascii-triangle ascii-triangle-inverted arrow curve flame triangle triangle-inverted full-step half-step quarter-step bars none random custom; do printf "%s\n" "$i"; done } \
powerline-separator -params 1..3 %{ evaluate-commands %sh{
    if [ ! "$kak_opt_powerline_on_screen" = "true" ]; then
        printf "%s\n" "echo -markup %{{default}powerline is disabled. Enable with \`{meta}powerline-enable{default}' to change separators}"
        exit
    fi
    if [ "$1" = "random" ]; then
        seed=$(($(date +%N | sed s:^\[0\]:1:) % 4 + 1)) # a posix compliant very-pseudo-random number generation
        separator=$(eval printf "%s\n" "arrow curve flame triangle | awk '{print \$${seed}}'")
    else
        separator=$1
    fi
    case ${separator} in
        (none)                    normal='';  thin='' ;;
        (ascii-arrow)             normal='<'; thin='<';;
        (ascii-triangle)          normal='/'; thin='/';;
        (ascii-triangle-inverted) normal='\'; thin='\';;
        (arrow)                   normal=''; thin='';;
        (curve)                   normal=''; thin='';;
        (flame)                   normal=''; thin='';;
        (triangle)                normal=''; thin='';;
        (triangle-inverted)       normal=''; thin='';;
        (quarter-step)            normal='░'; thin='' ;;
        (half-step)               normal='▒'; thin='' ;;
        (full-step)               normal='▓'; thin='' ;;
        (bars)                    normal='║'; thin='│';;
        (custom)
            if [ -n "$2" ]; then normal="$2"; thin="$2"; fi
            if [ -n "$3" ]; then thin="$3"; fi
            ;;
        (*) exit ;;
    esac
    printf "%s\n" "set-option buffer powerline_separator '${normal}'"
    printf "%s\n" "set-option buffer powerline_separator_thin '${thin}'"
    printf "%s\n" "powerline-rebuild-buffer"
}}


define-command -docstring "powerline-toggle-module <part> [<state>] toggle on and off displaying of powerline parts." \
-shell-script-candidates %{eval "set -- ${kak_quoted_opt_powerline_modules}"; while [ "$1" ]; do printf "%s\n" $1; shift; done} \
powerline-toggle-module -params 1..2 %{ evaluate-commands %sh{
    if [ ! "$kak_opt_powerline_on_screen" = "true" ]; then
        printf "%s\n" "echo -markup %{{default}powerline is disabled. Enable with \`{meta}powerline-enable{default}' to toggle modules}"
        exit
    fi
    module=$(printf "%s\n" $1 | sed "s:[^a-zA-Z-]:-:")
    printf "%s\n" "try %{ powerline-toggle-${module} $2 } catch %{ echo -debug %{powerline.kak: Can't toggle $1, command 'powerline-toggle-${module}' not found} }"
    eval "set -- $kak_quoted_client_list"
    while [ $# -gt 0 ]; do
        printf "%s\n" "evaluate-commands -client '$1' %{ powerline-rebuild-buffer }"
        shift
    done
}}

define-command -docstring "powerline-theme <theme>: apply theme to powerline." \
-shell-script-candidates %{ eval "set -- ${kak_quoted_opt_powerline_themes}"; while [ "$1" ]; do printf "%s\n" $1; shift; done} \
powerline-theme -params 1 %{ evaluate-commands %sh{
    if [ ! "$kak_opt_powerline_on_screen" = "true" ]; then
        printf "%s\n" "echo -markup %{{default}powerline is disabled. Enable with \`{meta}powerline-enable{default}' to change theme}"
        exit
    fi
    printf "%s\n" "powerline-theme-$1"
    printf "%s\n" "powerline-rebuild-buffer"
}}

define-command -docstring "powerline-format <formatstring>: change powerline format. Use <Tab> completion to get available modules.

powerline-format default: resets powerline format to default value, which is:
    'git bufname line_column mode_info filetype client session position'." \
-shell-script-completion %{eval "set -- ${kak_quoted_opt_powerline_modules}"; while [ "$1" ]; do printf "%s\n" $1; shift; done} \
powerline-format -params 1.. %{ evaluate-commands %sh{
    if [ ! "$kak_opt_powerline_on_screen" = "true" ]; then
        printf "%s\n" "echo -markup %{{default}powerline is disabled. Enable with \`{meta}powerline-enable{default}' to change format}"
        exit
    fi
    if [ "$1" = "default" ]; then
        formatstring="git bufname line_column mode_info filetype client session position"
    else
        formatstring=
        while [ "$1" ]; do
            formatstring="${formatstring} $1"; shift
        done
    fi
    printf "%s\n" "set-option buffer powerline_format %{${formatstring}}"
    printf "%s\n" "powerline-rebuild-buffer"
}}

§
