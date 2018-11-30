# install tmux plugins
echo "Install tmux plugins"
~/.tmux/plugins/tpm/scripts/install_plugins.sh


# zsh plugin manager
echo "Install zplug"
if [ ! -d ~/.zplug ]; then
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
else
  echo "zplug already Installed"
fi

python -m pip install virtualenvwrapper --user
