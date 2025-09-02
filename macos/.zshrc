# Prompt setup
autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats "%b "

setopt PROMPT_SUBST
PROMPT='%F{green}%*%f %F{blue}%~%f %F{red}${vcs_info_msg_0_}%f$ '

# PATH setup
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="/opt/homebrew/lib/ruby/gems/3.3.0/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"

# GHC setup
[ -f "/Users/graham/.ghcup/env" ] && . "/Users/graham/.ghcup/env" # ghcup-env
export PATH="$PATH:$HOME/.ghcup/bin"

# FZF setup
# source <(fzf --zsh)

. "$HOME/.atuin/bin/env"
eval "$(atuin init zsh)"

# File path setup
hash -d unisa=/Users/graham/Documents/university/unisa/bsc98923

source ~/.zsh_aliases
