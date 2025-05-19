# adding user bin folder to the path
path+=(${HOME}/.local/bin)
export PATH

# Docker in Docker (dnd)
export DOCKER_HOST=tcp://localhost:2375

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ${HOME}/.local/share/zsh/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Fix the permissions of /run/host-services/ssh-auth.sock, to be able to use the socket as a non-root USER
# the permissions change will affect all the containers of the host, and must be executed after a docker service restart
# here are the default permissions of the socket
# ❯ ls -al /run/host-services/ssh-auth.sock
# srw-rw---- 1 root root 0 May  6 22:28 /run/host-services/ssh-auth.sock
# Ref:
# - https://docs.docker.com/desktop/networking/#ssh-agent-forwarding
SSH_AUTH_SOCK="/run/host-services/ssh-auth.sock"

# if the ssh socket is not own by the current user, run a container as root to change the ownership
if [[ ! -O "${SSH_AUTO_SOCK}" ]]; then
  docker run -it --rm -u root \
    --mount type=bind,source=${SSH_AUTH_SOCK},target=${SSH_AUTH_SOCK} \
	  alpine:latest \
    chown $(id -u ${USER}):$(id -g ${USER}) ${SSH_AUTH_SOCK}
fi

# History
# #######
# use the following command to see all the history:
# history 1
export HISTFILE=${HOME}/.local/state/zsh/.zsh_history
export HISTSIZE=10000000
export SAVEHIST=10000000
setopt sharehistory
setopt extendedhistory
