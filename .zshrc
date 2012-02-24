# =============== #
#   Environment   #
# =============== #

export EDITOR="mate -w"

# Homebrew
export PATH="/usr/local/bin:$PATH"

# Ruby
export PATH="/usr/local/ruby/1.9.2-p290/bin:$PATH"

# Python
export PATH="/usr/local/share/python:$PATH"
# export PATH="/usr/local/share/python3:$PATH"

# Custom
export PATH="$HOME/bin:$PATH"

# Node
export NODE_PATH="/usr/local/lib/node_modules:$NODE_PATH"


# =========== #
#   Aliases   #
# =========== #

alias reload="source ~/.zshrc"
alias m.="mate ."
alias o.="open ."
alias showhidden="defaults write com.apple.finder AppleShowAllFiles true && killall Finder"
alias hidehidden="defaults write com.apple.finder AppleShowAllFiles false && killall Finder"

# Git
alias gti="git" # shame

alias glog="git log --oneline --decorate"
alias gstatus="git status -sbu"
alias gdiff="git diff"
alias gadd="git add -p"
alias gcommit="git commit -v"
alias gcommita="git commit -va"
alias grebase="git rebase -i"
alias gpull="git pull --rebase origin"
alias gpush="git push origin"
alias gstash="git stash save"
alias gpop="git stash pop"


# ========== #
#   Prompt   #
# ========== #

# Colors
autoload -U colors
colors
setopt prompt_subst

# PROMPT
local percent="%(?,%{$fg[green]%}%#%{$reset_color%},%{$fg[red]%}%#%{$reset_color%})"

PROMPT='
%F{135}%~%{$reset_color%}  $(git-status.rb)
${percent} %{$reset_color%}'

RPROMPT='%F{16}$(date)%{$reset_color%}'

# History (stolen from oh-my-zsh)
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt hist_ignore_dups # ignore duplication command history list
setopt share_history # share command history data

setopt hist_verify
setopt inc_append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_space

setopt SHARE_HISTORY
setopt APPEND_HISTORY

# Completions for Ruby, Git, etc.
autoload compinit
compinit
