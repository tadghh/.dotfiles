alias forcekill='kill -SIGKILL'
HISTSIZE=2000
HISTFILESIZE=2000
HISTTIMEFORMAT="%m/%d/%y %T "
export HISTCONTROL=ignoredups:erasedups

# Dont duplicate text if autocompleting from inside a word
bind "set skip-completed-text on"
bind "set history-preserve-point on"
# Shift tab = go backwards
bind '"\e[Z": menu-complete-backward'
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind "set show-all-if-ambiguous on"
bind "set menu-complete-display-prefix on"
bind "TAB: menu-complete"
# Colors!
bind "set colored-completion-prefix on"
bind "set colored-stats on"
