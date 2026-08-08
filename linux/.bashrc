# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Guarded because globstar only exists in bash 4+.
shopt -s globstar 2>/dev/null

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Prompt setup
for _git_prompt in \
    /usr/share/git-core/contrib/completion/git-prompt.sh \
    /usr/lib/git-core/git-sh-prompt \
    /etc/bash_completion.d/git-prompt \
    /usr/share/bash-completion/completions/git-prompt.sh
do
    if [ -f "$_git_prompt" ]; then
        . "$_git_prompt"
        break
    fi
done
unset _git_prompt

if ! declare -F __git_ps1 >/dev/null; then
    __git_ps1() {
        local branch
        branch=$(git symbolic-ref --short HEAD 2>/dev/null) || return 0
        printf "${1:-%s}" "$branch"
    }
fi

PS1='\[\e[32m\]\t\[\e[0m\] \[\e[34m\]\w\[\e[0m\] \[\e[31m\]$(__git_ps1 "%s")\[\e[0m\] \$ '

# Atuin
[ -f "$HOME/.atuin/bin/env" ] && . "$HOME/.atuin/bin/env"
[ -f ~/.bash-preexec.sh ] && source ~/.bash-preexec.sh
command -v atuin >/dev/null 2>&1 && eval "$(atuin init bash)"

# Setup aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Default editor
export EDITOR="nvim"

# Environment setup
# Neovim (release tarball extracted to /opt/nvim)
[ -d /opt/nvim/bin ] && export PATH="/opt/nvim/bin:$PATH"

# uv and other user-local binaries
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"

# Rust
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
