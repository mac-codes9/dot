eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

source ~/.config/zsh/aliases.zsh

source ~/.zplug/init.zsh
zplug "jkcdarunday/zplug-blame"
zplug "MichaelAquilina/zsh-you-should-use"
zplug "hchbaw/zce.zsh"
zplug "jeffreytse/zsh-vi-mode"
zplug "marlonrichert/zsh-autocomplete"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zplug/zplug", hook-build:"zplug --self-manage"
zplug check || zplug install
zplug load
bindkey "^s" zce
