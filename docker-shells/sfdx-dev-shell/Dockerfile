#
## Base builder image
##

# FROM debian:buster-slim as sfdx-dev-shell-builder
FROM python:3.9.5-buster as sfdx-dev-shell-builder

RUN set -ex \
  && apt-get update \
  && apt-get install --yes --no-install-recommends \
     zsh lsof vim jq git-flow bash-completion \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* *.deb

ENV APP_USER=vscode
ENV APP_USER_GROUP=root
ARG APP_USER_HOME=/home/$APP_USER

RUN useradd -rm -d /home/$APP_USER -s /bin/zsh -g root -G sudo -u 1001 $APP_USER

USER $APP_USER
WORKDIR $APP_USER_HOME

##
## Node.js
##

FROM node:16.1-buster-slim as nodejs-builder

## Install Node Packages
RUN set -ex \
    && npm install sfdx-cli --global \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

##
## python packages and zsh
##

FROM sfdx-dev-shell-builder as sfdx-dev-shell-builder-python
LABEL Vendor="Alpine"
LABEL distro="alpine" distro_version="3.13.0" architecture="x86_64"

# install oh-my-zsh
RUN wget -qO- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | zsh || true
ARG ZSH_CUSTOM=$APP_USER_HOME/.oh-my-zsh/custom

## Copy dotfiles
COPY --chown=$APP_USER:$APP_USER_GROUP dotfiles/.zshrc $APP_USER_HOME/.zshrc
COPY --chown=$APP_USER:$APP_USER_GROUP dotfiles/.zprofile $APP_USER_HOME/.zprofile
COPY --chown=$APP_USER:$APP_USER_GROUP dotfiles/.alias.sh $APP_USER_HOME/.alias.sh
# pipx packages
RUN set -ex \
    && python3 -m pip install --user pipx \
    && python3 -m pipx ensurepath \
    && python3 -m pipx install cumulusci \
    && python3 -m pipx install ggshield \
    && python3 -m pipx install pre-commit \
    && python3 -m pipx install commitizen \
    && python3 -m pipx install cruft 


FROM sfdx-dev-shell-builder

## System
ENV TIMEZONE="Etc/UTC" \
    TERM="xterm" \
    HOSTNAME="sfdx-dev-shell"

ENV UMASK="0022"

# Install Nodejs
COPY --from=nodejs-builder /usr/local /usr/local
COPY --from=sfdx-dev-shell-builder-python $APP_USER_HOME $APP_USER_HOME

ENTRYPOINT ["/usr/bin/zsh"]
CMD [ "/usr/bin/zsh" ]


