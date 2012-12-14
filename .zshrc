# =============== #
#   Environment   #
# =============== #

export EDITOR="mate -w"

# Homebrew
export PATH="/usr/local/bin:$PATH"

# Ruby
export PATH="/usr/local/ruby/1.9.3-p327/bin:$PATH"
# export PATH="/usr/local/ruby/1.9.3-p286/bin:$PATH"
# export PATH="/usr/local/ruby/1.9.2-p290/bin:$PATH"
# export PATH="/usr/local/ruby/ree-1.8.7-2011.03/bin:$PATH"

# Node
export PATH="/usr/local/share/npm/bin:$PATH"
export NODE_PATH="/usr/local/lib/node_modules:$NODE_PATH"

# Python
export PATH="/usr/local/share/python:$PATH"
# export PATH="/usr/local/share/python3:$PATH"

# Heroku
export PATH="/usr/local/heroku/bin:$PATH"

# Custom
export PATH="$HOME/bin:$PATH"

# =========== #
#   Aliases   #
# =========== #

alias reload="source ~/.zshrc"
alias config="mate ~/.zshrc"
alias setup="mate -w ~/.zshrc && reload"

# http://twitter.com/michaelvillar/status/228991454461194240
alias webserver="python -m SimpleHTTPServer"

alias back='cd $OLDPWD'
alias ip='echo -n `ifconfig | grep -Po "(?<=inet )\d*\.\d*\.\d*\.\d*(?=.*broadcast)"` | pbcopy'

alias m.="mate ."
alias o.="open ."

alias showhidden="defaults write com.apple.finder AppleShowAllFiles true && killall Finder"
alias hidehidden="defaults write com.apple.finder AppleShowAllFiles false && killall Finder"

alias bi='bundle install'
alias be='bundle exec ' # note the trailing space to trigger chaining
alias bu='bundle update '
alias mongod_="mongod --dbpath /usr/local/var/mongodb/data/db"


# Git
alias gti="git" # shame

alias _glog="git log --pretty=format:'%C(yellow)%h%C(reset)%C(bold red)%d%C(reset) %s %C(green)(%cr) %C(cyan)<%an>%C(reset)' --abbrev-commit"
alias glog="_glog -n 30 | ruby -e 'puts STDIN.read.gsub(%(<#{%x(git config user.name).chomp}>), %())'"
alias gstatus="git status -sbu"
alias gdiff="git diff"
alias gadd="git add -p"
alias gcommit="git commit -v"
alias gcommita="git commit -va"
alias grebase="git rebase -i HEAD~10"
alias gpull="git pull --rebase origin"
alias gpush="git push origin"
alias gstash="git stash save -u"
alias gpop="git stash pop"
alias gclean="git clean -fd"
alias gsub="git submodule"
alias gsuba="git submodule add"
alias gsubi="git submodule init"
alias gsubu="git submodule update"


# Curl
get() {
  curl -D /tmp/fuckin-curl-headers.txt $1
  echo "\n"
  cat /tmp/fuckin-curl-headers.txt
}

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
%F{135}%~%{$reset_color%}  $(git-prompt.rb)
${percent} %{$reset_color%}'

RPROMPT='%F{16}$(date)%{$reset_color%}'

# History (stolen from oh-my-zsh)
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history # share command history data

# Fuck yes, at last. This is what the default behavior of ⬆ and ⬇ should be.
# Seen at http://cims.nyu.edu/cgi-systems/info2html?(zsh)ZLE%2520Functions and http://dotfiles.org/~urukrama/.zshrc
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey '^[[A' history-beginning-search-backward-end
bindkey '^[[B' history-beginning-search-forward-end

# Completions for Ruby, Git, etc.
autoload compinit
compinit


# ============ #
#   Terminal   #
# ============ #

# Open Terminal tabs in same directory (http://superuser.com/a/328148)
if [[ "$TERM_PROGRAM" == "Apple_Terminal" ]] && [[ -z "$INSIDE_EMACS" ]]; then
    update_terminal_cwd() {
        local URL_PATH=''
        {
            local i ch hexch LANG=C
            for ((i = 1; i <= ${#PWD}; ++i)); do
                ch="$PWD[i]"
                if [[ "$ch" =~ [/._~A-Za-z0-9-] ]]; then
                    URL_PATH+="$ch"
                else
                    hexch=$(printf "%02X" "'$ch")
                    URL_PATH+="%$hexch"
                fi
            done
        }
        local PWD_URL="file://$HOST$URL_PATH"
        printf '\e]7;%s\a' "$PWD_URL"
    }
    autoload add-zsh-hook
    add-zsh-hook chpwd update_terminal_cwd
    update_terminal_cwd
fi
