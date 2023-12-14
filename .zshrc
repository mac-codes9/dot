eval "$(starship init zsh)"

alias zc="vim ~/.zshrc"
alias zr="source ~/.zshrc"
alias vc="vim ~/.vimrc"
alias v="vim"
alias c="clear"
alias lsa="ls -a"
alias gi="git init"
alias gaa="git add ."
alias gc="git commit -m"
alias gac="git add .; git commit -m"
alias gp="git push"
alias gf="git fetch"
alias gpl="git pull"
alias gpu="git push -u origin"
alias gpn="git pull --no-rebase"
alias ghb="gh browse"
alias cs="gh copilot suggest"
alias hf="hyperfine"

source ~/.zplug/init.zsh
zplug "MichaelAquilina/zsh-you-should-use"
zplug "hchbaw/zce.zsh"
zplug "jeffreytse/zsh-vi-mode"
zplug "marlonrichert/zsh-autocomplete"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug load

bindkey '^s' zce
