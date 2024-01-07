#!/bin/sh
tools=''
config=~/.config/config.yml

if [ -d "$HOME/.termux" ]; then
  echo "Running on Termux"
  tools='.tools.all.packages[] + .tools.all.zsh.packages[] + .tools.mobile.packages[] | join(" ")'
  pkg in -y ruby
elif [ "$(uname -s)" = "Darwin" ]; then
  echo "Running on macOS"
  tools='.tools.all.packages[] + .tools.all.zsh.packages[] + .tools.computer.all.packages[] + .tools.computer.mac.packages[] | join(" ")'
elif [ -f "/etc/os-release" ] && [ "$(source /etc/os-release && echo "$ID")" = "arch" ]; then
  echo "Runnin on Arch Linux"
  tools='.tools.all.packages[] + .tools.all.zsh.packages[] + .tools.computer.all.packages[] + .tools.computer.linux.packages[] | join(" ")'
else
  echo "Unsupported environment"
  exit
fi

pre_install() {
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"

  if command -v git > /dev/null 2>&1; then
    brew install yq
  else
    brew install yq git
  fi
}

clone_config() {
  cd
  mkdir .config
  cd .config
  git init .
  git remote add origin https://github.com/mac-codes9/dot
  git pull origin master
  ln -s ~/.config/vim/vimrc ~/.vimrc
  ln -s ~/.config/zsh/zshrc ~/.zshrc
  ln -s ~/.config/git/config ~/.gitconfig
  ln -s ~/.config/git/msg ~/.gitmessage
  cd; git clone https://github.com/mac-codes9/dot.wiki.git notes
}

install_tools() {
  brew install $(yq e "$tools" "$config")
  curl --proto '=https' --tlsv1.2 -sSf https://setup.atuin.sh | sh
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
}

post_install() {
  mkdir docs
  cd docs git clone https://github.com/mac-codes9/portfolio
  if [ "$SHELL" != "/bin/zsh" ]; then
    chsh -s zsh
  fi
}

pre_install
clone_config
install_tools
post_install
