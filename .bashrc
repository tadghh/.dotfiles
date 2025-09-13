# .bashrc

# Source global definitions
[[ -f /etc/bashrc ]] && . /etc/bashrc
[[ -f /etc/bash_completion ]] && source /etc/bash_completion

# User specific environment
[[ ":$PATH:" != *":$HOME/.local/bin:"* ]] && PATH="$HOME/.local/bin:$PATH"
[[ ":$PATH:" != *":$HOME/bin:"* ]] && PATH="$HOME/bin:$PATH"

export PATH

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        [[ -f $rc ]] && . "$rc"
    done
fi

unset rc

HISTSIZE=2000
HISTFILESIZE=2000
HISTTIMEFORMAT="%m/%d/%y %T "

export HISTCONTROL=ignoredups:erasedups

# These dump unicode support which can make some applications perform better
export LC_ALL=C
export LANG=C

if [[ $- == *i* ]]; then
    shopt -s histappend
    set -o noclobber
    set -o pipefail

    # These make command completion more fuzzy
    bind "set completion-ignore-case on"
    bind "set completion-map-case on"
    bind "set skip-completed-text on"

    bind "set history-preserve-point on"

    # Bindings for auto complete
    bind '"\e[Z":menu-complete-backward'
    bind '"\e[A":history-search-backward'
    bind '"\e[B":history-search-forward'
    bind '"\e[1;5C":forward-word'
    bind '"\e[1;5D":backward-word'

    # No hitting the bell for ambiguous auto completes, just show the options
    bind "set show-all-if-ambiguous on"
    bind "set show-all-if-unmodified on"

    bind "set menu-complete-display-prefix on"

    # Just silly, im not looking at a book of commands
    bind "set page-completions off"

    bind "TAB:menu-complete"
    bind "set colored-completion-prefix on"
    bind "set colored-stats on"
    bind "set visible-stats on"
    bind "set print-completions-horizontally on"

    # Fix crtl + backspace
    bind '"\C-h":backward-kill-word'
    
    # Fix shift by one char
    bind '"\e[1;2D":backward-char'
    bind '"\e[1;2C":forward-char'
fi
