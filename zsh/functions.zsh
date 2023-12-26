mkcd() {
  mkdir $1
	cd $1
}

system_check() {
  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if [[ -f /etc/arch-release ]]; then
      os="arch"
    elif [[ -f /etc/lsb-release ]]; then
      os="ubuntu"
    fi
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    os="mac"
  elif [[ "$OSTYPE" == "linux-android"* ]]; then
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
