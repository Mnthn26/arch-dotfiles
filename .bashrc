#
# ~/.bashrc
#

[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# Shell-safe logout alias bypassing Lua dispatcher interception
alias logout='kill -9 -1'

# Display fastfetch on terminal startup
fastfetch
eval "$(starship init bash)"

# Run Fastfetch only in Kitty terminal windows
if [[ "$TERM" == "xterm-kitty" ]] && [[ $- == *i* ]]; then
    fastfetch
fi
