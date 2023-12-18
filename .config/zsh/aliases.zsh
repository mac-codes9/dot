if [ -d "/data/data/com.termux/files" ]; then
    alias update="pkg update"
    alias upgrade="pkg upgrade"
    alias install="pkg install"
    alias remove="pkg remove"
    alias search="pkg search"
    alias clean="pkg clean"
    alias list="pkg list"
elif [ uname -a | grep -i "debian" ]; then
    alias update="sudo apt update"
    alias upgrade="sudo apt upgrade"
    alias install="sudo apt install"
    alias remove="sudo apt remove"
    alias search="sudo apt search"
    alias clean="sudo apt clean"
    alias list="sudo apt list"
elif [ uname -a | grep -i "arch" ]; then
    alias update="sudo pacman -Syu"
    alias upgrade="sudo pacman -Syu"
    alias install="sudo pacman -S"
    alias remove="sudo pacman -R"
    alias search="sudo pacman -Ss"
    alias clean="sudo pacman -Sc"
    alias list="sudo pacman -Q"
elif [ uname -a | grep -i "mac" ]; then
    alias update="brew update"
    alias upgrade="brew upgrade"
    alias install="brew install"
    alias remove="brew remove"
    alias search="brew search"
    alias clean="brew cleanup"
    alias list="brew list"
fi

alias zc="vim ~/.zshrc" 
alias zr="source ~/.zshrc"
alias vc="vim ~/.vimrc"
alias v="vim"
alias c="clear"
alias rmf="rm -rf"
alias ls="eza --icons"
alias lsa="eza -a --icons"
alias tree="eza --icons -T"
alias tk="tokei"
alias cat="bat -p --paging=never"
alias du="dust"
alias hf="hyperfine"
alias gi="git init"
alias gaa="git add ."
alias gc="git commit -m"
alias gac="git add .; git commit -m"
alias gp="git push"
alias gf="git fetch"
alias gpl="git pull"
alias gpu="git push -u origin"
alias gpn="git pull --no-rebase"
alias gl="git log --oneline"
alias gs="git status"
alias ghb="gh browse"
alias cs="gh copilot suggest"
alias csg="gh copilot suggest -t git"
alias csh="gh copilot suggest -t gh"
alias css="gh copilot suggest -t shell"
alias ce="gh copilot explain"
alias postInstall="gh auth login; zplug install; zplug load"
