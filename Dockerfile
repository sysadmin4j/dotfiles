FROM --platform=$BUILDPLATFORM fedora:40

ARG USERNAME=ide
ARG GROUPNAME=ide
ARG UID=1000
ARG GID=1000
ARG HOME_DIR="/Users/${USERNAME}"

# required for man pages
RUN sed -i 's/^.*\(tsflags=nodocs\).*/# the option tsflags=nodocs has been commented by the docker build\r\n#\1/g' /etc/dnf/dnf.conf

# installing feroda packages
RUN dnf -y install iputils net-tools man man-pages man-db zsh git curl make gcc strace jq python3-pip icu ripgrep fd-find unzip npm nodejs wget glibc-langpack-en firefox dnf-plugins-core && dnf clean all

# installing docker
RUN dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
RUN dnf -y install socat docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-compose && dnf clean all

# reinstalling curl to get the man pages
RUN dnf -y reinstall curl && dnf clean all

# creating the non-root user
RUN groupadd -o -g ${GID} ${GROUPNAME} && adduser -u ${UID} -g ${GROUPNAME} -d ${HOME_DIR} -s /bin/zsh ${USERNAME}

# installing lazygit
RUN dnf copr enable atim/lazygit -y
RUN dnf install -y lazygit && dnf clean all

# for OSC52 clipboard patch
RUN dnf copr enable agriffis/neovim-nightly -y
# https://copr.fedorainfracloud.org/coprs/agriffis/neovim-nightly/package/neovim/
# to specify a fix version (see the commented line bellow)
#RUN dnf install -y neovim-0.10.0~dev.2976.g208852126-1.fc40.aarch64 python3-neovim && dnf clean all
RUN dnf install -y neovim python3-neovim && dnf clean all

# installing global npm modules
RUN npm install -g neovim yarn

# for Saleor
RUN npm install -g pnpm@8.9.0 saleor-cli

# ping requirement for saleor-cli
RUN setcap cap_net_raw+p /usr/bin/ping

# setup lang and timezone
ENV LANG=en_CA.utf8
ENV TZ=America/Montreal
ENV HOME=${HOME_DIR}

# required for npm install
WORKDIR ${HOME}

# adding sudo all to the image user
# uncomment to test package installations in a more convenient way
RUN echo "${USERNAME} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/ide-user

# run as non-root user
USER ${USERNAME}


COPY --chown=${USERNAME} requirements.txt ${HOME}/requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy the zsh config files
COPY --chown=${USERNAME} .zshrc ${HOME}/.zshrc
COPY --chown=${USERNAME} .p10k.zsh ${HOME}/.p10k.zsh

# Create the folder to store .zsh_history
RUN mkdir -p ${HOME}/.local/state/zsh

# Installing powerlevel10k
ENV POWERLEVEL10K_VERSION=1.20.0
ENV POWERLEVEL10K_URL="https://github.com/romkatv/powerlevel10k/archive/refs/tags/v${POWERLEVEL10K_VERSION}.tar.gz"
RUN curl -f -L ${POWERLEVEL10K_URL} -o powerlevel10k.tar.gz && \
  mkdir -p ${HOME}/.local/share/zsh/powerlevel10k && \
  tar -zxf powerlevel10k.tar.gz --strip-components=1 -C ${HOME}/.local/share/zsh/powerlevel10k && \
  rm powerlevel10k.tar.gz

# Copy nvim config files
COPY --chown=${USERNAME} .config/nvim ${HOME}/.config/nvim

# nvim bootstrap (to avoid noice pop-up)
RUN nvim --headless +"30sleep" +"qa!"
RUN nvim --headless +"Lazy check" +"Lazy update" +"30sleep" +"qa!"
RUN nvim --headless +"Mason" +"MasonInstall \
  lua-language-server \
  stylua \
  docker-compose-language-service \
  dockerfile-language-server \
  shfmt \
  typescript-language-server \
  json-lsp \
  pyright \
  ruff-lsp \
  hadolint \
  markdownlint \
  marksman \
  ruff-lsp \
  --target=linux_x64_gnu" +"qa!"

CMD ["/bin/zsh"]
