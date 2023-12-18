eval "$(starship init zsh)"

source ~/.config/zsh/aliases.zsh

source ~/.zplug/init.zsh
zplug "MichaelAquilina/zsh-you-should-use"
zplug "hchbaw/zce.zsh"
zplug "jeffreytse/zsh-vi-mode"
zplug "marlonrichert/zsh-autocomplete"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
if ! zplug check; then
    zplug install
fi
zplug load
bindkey '^s' zce

