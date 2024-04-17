echo "Sweet Home: " $HOME

# start xQuartx if the process is not running
ps caux | grep -qi xquartz
if [ "$?" -ne 0 ]; then
  open -g -a xQuartz
  xhost +localhost
fi

# Aliases
alias jump="ssh jump"
#alias vi="nvim"
#alias vim="nvim"
alias nvim="ide nvim"

# History
setopt share_history

# load powelevel 10k
