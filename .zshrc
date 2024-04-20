echo "Sweet Home: " $HOME

# adding user bin folder to the path
path+=(${HOME}/.local/bin)
export PATH

# Aliases
alias jump="ssh jump"
#alias vi="nvim"
#alias vim="nvim"
alias nvim="ide nvim"

# History
setopt share_history
