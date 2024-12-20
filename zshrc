# If you come from bash you might have to change your $PATH.


export PATH=$PATH:$HOME/bin:$HOME/.config/composer/vendor/bin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:/usr/local/go/bin

export ANDROID_HOME=$HOME/Android/Sdk
# export JAVA_HOME=/usr/lib/jvm/default-java

export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools


export ZSH=~/.oh-my-zsh
ZSH_THEME="customfishy"
# ZSH_THEME="fishy"
HIST_STAMPS="dd-mm-yyyy"
source $ZSH/oh-my-zsh.sh

# nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# command completions docker @see https://docs.docker.com/compose/completion/#install-command-completion
fpath=(~/.zsh/completion $fpath)

# tmuxinator completions https://github.com/tmuxinator/tmuxinator
source ~/.bin/tmuxinator.zsh
export EDITOR="nvim"


source ~/.zplug/init.zsh
# zplug "zsh-users/zsh-history-substring-search"
# zplug "plugins/laravel5", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh
# zplug "plugins/virtualenvwrapper", from:oh-my-zsh
# zplug "plugins/docker", from:oh-my-zsh
zplug "plugins/tmux", from:oh-my-zsh
# zplug "plugins/golang", from:oh-my-zsh
zplug "plugins/pyenv", from:oh-my-zsh
# zplug "plugins/poetry", from:oh-my-zsh
# Syntax highlighting for commands, load last
zplug "zsh-users/zsh-syntax-highlighting", from:github, defer:3

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
# zplug load --verbose
zplug load

alias vim="nvim"
alias vi="nvim"
alias vimdiff='nvim -d'
alias mux="tmuxinator"
alias svim='vim -u ~/.SpaceVim/vimrc'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export HTTP_X_APPENGINE_CRON=True
export PATH=/usr/bin:$PATH
