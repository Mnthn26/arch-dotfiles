# Enable Powerlevel10k/Syntax highlighting and Autosuggestions
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# History configuration
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# Starship Prompt
eval "$(starship init zsh)"

# Fastfetch on launch
if [[ "$TERM" == "xterm-kitty" ]]; then
    fastfetch
fi

# Basic aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
