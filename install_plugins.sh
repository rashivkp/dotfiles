# Install tmux plugins
echo "Installing tmux plugins"
mkdir -p ~/.tmux/plugins
if [ ! -d ~/.tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# zsh plugin manager
echo "Installing zplug"
if [ ! -d ~/.zplug ]; then
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
else
  echo "zplug already Installed"
fi

# Install nvm
echo "Installing nvm"
if [ ! -d ~/.nvm ]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
else
  echo "nvm already Installed"
fi

# Install pyenv
echo "Installing pyenv"
if [ ! -d ~/.pyenv ]; then
  curl https://pyenv.run | bash
else
  echo "pyenv already Installed"
fi
