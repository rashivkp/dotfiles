# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.config/composer/vendor/bin:$HOME/.local/bin:/usr/local/bin:$PATH

export ZSH=~/.oh-my-zsh
ZSH_THEME="customfishy"
HIST_STAMPS="dd-mm-yyyy"
source $ZSH/oh-my-zsh.sh

#FZF vim
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# command completions docker @see https://docs.docker.com/compose/completion/#install-command-completion
fpath=(~/.zsh/completion $fpath)

# tmuxinator completions https://github.com/tmuxinator/tmuxinator
source ~/.bin/tmuxinator.zsh
export EDITOR="nvim"


source ~/.zplug/init.zsh
zplug "zsh-users/zsh-history-substring-search"
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/virtualenvwrapper", from:oh-my-zsh
zplug "plugins/docker", from:oh-my-zsh
zplug "plugins/tmux", from:oh-my-zsh
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

# enabling virtualenv when new window opens
if [[ ! $DISABLE_VENV_CD -eq 1 ]]; then
  workon_cwd
fi
alias vim="nvim"
alias vi="nvim"
alias vimdiff='nvim -d'
