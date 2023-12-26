mkcd() {
  mkdir $1
	cd $1
}

gafc() {
  git add $1
  git commit -m "$2"
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

system_update() {
  system_check
  if [[ "$os" == "arch" ]]; then
    sudo pacman -Syu
    sudo pacman -S --needed $(yq r config.yml tools.all.packages, tools.computer.packages, tools.computer.linux)
    npm i -g $(yq r config.yml tools.all.node, tools.computer.node)
  elif [[ "$os" == "ubuntu" ]]; then
    sudo apt update && sudo apt upgrade
    sudo apt install $(yq r config.yml tools.all.packages, tools.computer.packages, tools.computer.linux)
    npm i -g $(yq r config.yml tools.all.node, tools.computer.node)
  elif [[ "$os" == "mac" ]]; then
    sudo softwareupdate -i -a
    brew install $(yq r config.yml tools.all.packages, tools.computer.packages, tools.computer)
    npm i -g $(yq r config.yml tools.all.node, tools.computer.node)
  elif [[ "$os" == "termux" ]]; then
    pkg update && pkg upgrade
    yq e '.tools.all.packages + .tools.computer.packages + .tools.computer.termux | join(" ")' config.yml | xargs pkg install
    yq e '.tools.all.node | join(" ")' config.yml | xargs npm i -g
  fi
}
