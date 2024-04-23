FROM fedora:latest

ARG USERNAME=ide
ARG GROUPNAME=ide
ARG UID=1000
ARG GID=1000

# creating the non-root user
RUN groupadd -o -g ${GID} ${GROUPNAME} && adduser -u ${UID} -g ${GROUPNAME} ${USERNAME}

# required for man pages
RUN sed -i 's/^.*\(tsflags=nodocs\).*/# the option tsflags=nodocs has been commented by the docker build\r\n#\1/g' /etc/dnf/dnf.conf

# installing feroda packages
RUN dnf -y install man man-pages man-db git curl make gcc python3-pip icu ripgrep fd-find unzip npm nodejs wget glibc-langpack-en firefox dnf-plugins-core && dnf clean all

# reinstalling curl to get the man pages
RUN dnf -y reinstall curl && dnf clean all

# installing lazygit
RUN dnf copr enable atim/lazygit -y
RUN dnf install -y lazygit && dnf clean all

# for OSC52 clipboard patch
RUN dnf copr enable agriffis/neovim-nightly -y
RUN dnf install -y neovim python3-neovim && dnf clean all

# installing global npm modules
RUN npm install -g neovim yarn

# setup lang and timezone
ENV LANG=en_CA.utf8
ENV TZ=America/Montreal
ENV HOME=/home/$USERNAME

# required for npm install
WORKDIR $HOME

# run as non-root user
USER $USERNAME

# Copy nvim config files
COPY --chown=$USERNAME .config/nvim $HOME/.config/nvim

# nvim bootstrap (to avoid noice pop-up)
RUN nvim --headless +"15sleep" +"qa!"
RUN nvim --headless +"Lazy check" +"Lazy update" +"15sleep" +"qa!"
RUN nvim --headless +"Mason" +"MasonInstall lua-language-server stylua" +"qa!"

# Markdown preview npm dependencies installation
# -- make sure the command xdg-open is able to open a broswer in your OS UI (will need a browser like chrome or firefox)
# Using the package.json from github:
ENV MARKDOWN_PREVIEW_VERSION=0.0.10
ENV MARKDOWN_PREVIEW_URL="https://raw.githubusercontent.com/iamcco/markdown-preview.nvim/v$MARKDOWN_PREVIEW_VERSION/package.json"
RUN curl -f -l -O $MARKDOWN_PREVIEW_URL
RUN npm install

COPY --chown=$USERNAME requirements.txt $HOME/requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

#RUN git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
ENV POWERLEVEL10K_VERSION=1.20.0
ENV POWERLEVEL10K_URL="https://github.com/romkatv/powerlevel10k/archive/refs/tags/v$POWERLEVEL10K_URL.tar.gz"
#RUN curl -l -O 

# TODO:
# - zsh? powerlevel10k
# - firefox or chrome config for markdown-preview
# - install strace
