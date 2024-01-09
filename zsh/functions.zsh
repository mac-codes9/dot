mkcd() {
  mkdir $1
  cd $1
}

gafc() {
  git add $1
  git commit -m "$2"
}

clean_dot_files() {
  rm -rf .config .gitconfig .gitmessage .vimrc .zplug .zshrc docs notes
}

system_check() {
  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if [[ -f /etc/arch-release ]]; then
      echo -e "\e[1;32mRunning on Arch Linux\e[0m"
      os="arch"
    elif [[ -f /etc/lsb-release ]]; then
      echo -e "\e[1;32mRunning on Ubuntu\e[0m"
      os="ubuntu"
    fi
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo -e "\e[1;32mRunning on macOS\e[0m"
    os="mac"
  elif [[ "$OSTYPE" == "linux-android"* ]]; then
    echo -e "\e[1;32mRunning on Termux\e[0m"
    os="termux"
  fi
}
