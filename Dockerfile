FROM --platform=$BUILDPLATFORM fedora:42

ARG USERNAME=ide
ARG GROUPNAME=ide
ARG UID=1000
ARG GID=1000
ARG HOME_DIR="/Users/${USERNAME}"
ARG TARGETARCH

# required for man pages
#RUN sed -i 's/^.*\(tsflags=nodocs\).*/# the option tsflags=nodocs has been commented by the docker build\r\n#\1/g' /etc/dnf/dnf.conf

# installing feroda packages
RUN dnf -y install \
       #man man-pages man-db \
       wkhtmltopdf bind-utils iputils net-tools zsh \
       git curl make gcc strace jq python3-pip icu ripgrep uv\
       fd-find unzip npm nodejs wget glibc-langpack-en firefox \
       fzf azure-cli kubernetes-client helm dnf-plugins-core \
       && dnf clean all

# installing docker
RUN dnf config-manager addrepo --from-repofile=https://download.docker.com/linux/fedora/docker-ce.repo
RUN dnf -y install socat docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin && dnf clean all

# creating the non-root user
RUN groupadd -o -g ${GID} ${GROUPNAME} && adduser -u ${UID} -g ${GROUPNAME} -d ${HOME_DIR} -s /bin/zsh ${USERNAME}

# installing lazygit
RUN dnf copr enable atim/lazygit -y
RUN dnf install -y lazygit && dnf clean all

# installing neovim
# for OSC52 clipboard patch
#RUN dnf copr enable agriffis/neovim-nightly -y
# https://copr.fedorainfracloud.org/coprs/agriffis/neovim-nightly/package/neovim/
# to specify a fix version (see the commented line bellow)
#RUN dnf install -y neovim-0.10.0~dev.2976.g208852126-1.fc40.aarch64 python3-neovim && dnf clean all
RUN dnf install -y neovim python3-neovim && dnf clean all

# installing terraform
RUN dnf config-manager addrepo --from-repofile=https://rpm.releases.hashicorp.com/fedora/hashicorp.repo
RUN dnf -y install terraform

# install kubelogin
RUN az aks install-cli

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

# installing krew
RUN ( set -x; cd "$(mktemp -d)" && \
      OS="$(uname | tr '[:upper:]' '[:lower:]')" && \
      ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" && \
      KREW="krew-${OS}_${ARCH}" && \
      curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" && \
      tar zxvf "${KREW}.tar.gz" && \
      ./"${KREW}" install krew \
    )
ENV PATH="${HOME}/.krew/bin:${PATH}"

# installing kubens and stern
RUN kubectl krew install ns stern

# setup python virtual env
COPY --chown=${USERNAME} pyproject.toml ${HOME}/pyproject.toml
RUN uv sync --link-mode=copy
ENV UV_PROJECT_ENVIRONMENT=${HOME}/.venv
RUN source ${UV_PROJECT_ENVIRONMENT}/bin/activate

# copy the zsh config files
COPY --chown=${USERNAME} .zshrc ${HOME}/.zshrc
COPY --chown=${USERNAME} .p10k.zsh ${HOME}/.p10k.zsh

# create the folder to store .zsh_history
RUN mkdir -p ${HOME}/.local/state/zsh

# installing powerlevel10k
ENV POWERLEVEL10K_VERSION=1.20.0
ENV POWERLEVEL10K_URL="https://github.com/romkatv/powerlevel10k/archive/refs/tags/v${POWERLEVEL10K_VERSION}.tar.gz"
RUN curl -f -L ${POWERLEVEL10K_URL} -o powerlevel10k.tar.gz && \
  mkdir -p ${HOME}/.local/share/zsh/powerlevel10k && \
  tar -zxf powerlevel10k.tar.gz --strip-components=1 -C ${HOME}/.local/share/zsh/powerlevel10k && \
  rm powerlevel10k.tar.gz

# installing flux2 cli
ENV FLUX_VERSION=2.5.1
ENV FLUX_URL=https://github.com/fluxcd/flux2/releases/download/v${FLUX_VERSION}/flux_${FLUX_VERSION}_linux_${TARGETARCH}.tar.gz
RUN curl -f -L ${FLUX_URL} -o flux.tar.gz && \
  mkdir -p ${HOME}/.local/bin && \
  tar -zxf flux.tar.gz -C ${HOME}/.local/bin && \
  rm flux.tar.gz

# copy nvim config files
COPY --chown=${USERNAME} .config/nvim ${HOME}/.config/nvim

# nvim bootstrap (to avoid noice pop-up)
RUN nvim --headless +"Mason" +"MasonInstall \
    docker-compose-language-service \
    dockerfile-language-server \
    hadolint \
    json-lsp \
    lua-language-server \
    markdown-toc \
    markdownlint \
    markdownlint-cli2 \
    marksman \
    pyright \
    ruff \
    shfmt \
    stylua \
    typescript-language-server\
    vtsls" \
  +"qa!"
RUN nvim --headless +"Lazy check" +"Lazy sync" +"qa!"

CMD ["/bin/zsh"]
