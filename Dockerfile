FROM ubuntu:jammy

ENV DEBIAN_FRONTEND noninteractive
ENV CRAN_URL https://cloud.r-project.org/
ENV USER=sccity
ENV GROUPNAME=$USER

USER root

RUN set -e \
      && ln -sf bash /bin/sh

RUN set -e \
    && apt-get -y update \
    && apt-get -y dist-upgrade \
    && apt-get -y install --no-install-recommends --no-install-suggests \
    apt-transport-https apt-utils ca-certificates curl gdebi-core gnupg2 systemd \
    libapparmor1 libclang-dev libedit2 libpq5 libssl3 libssl-dev lsb-release \
    build-essential libffi-dev python3-dev python3 python3-pip python3-venv git-all \
    libcurl4-openssl-dev \
    psmisc r-base sudo \
    && apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN set -eo pipefail \
    && curl -SL -o /tmp/rstudio-server.deb https://download2.rstudio.org/server/jammy/amd64/rstudio-server-2023.12.1-402-amd64.deb \
    && gdebi --non-interactive /tmp/rstudio-server.deb \
    && rm -rf /tmp/rstudio-server.deb

RUN set -eo pipefail \
    && ln -s /dev/stdout /var/log/syslog \
    && echo "r-cran-repos=${CRAN_URL}" >> /etc/rstudio/rsession.conf

RUN set -eo pipefail \
      && groupadd $GROUPNAME \
      && useradd -m -d /home/$USER -g $GROUPNAME $USER \
      && echo $USER:$USER | chpasswd

WORKDIR /app
COPY entrypoint.sh /app
COPY rdeps.R /app
RUN chown -R "$USER":"$GROUPNAME" /app && chmod -R 775 /app
RUN chmod +x /app/entrypoint.sh

USER sccity

RUN set -eo pipefail \
    && export PATH=/home/sccity/.local/bin:$PATH \
    && /usr/bin/pip3 install jupyterlab jupyterlab-git jupyterlab-code-formatter jupyterlab-lsp jupyterlab-github \
    && /usr/bin/pip3 install lckr_jupyterlab_variableinspector black isort jupyterlab_sql \
    && /home/sccity/.local/bin/jupyter serverextension enable jupyterlab_sql --py --sys-prefix \
    && /home/sccity/.local/bin/jupyter lab build

USER root

RUN set -eo pipefail \
    && /usr/bin/Rscript /app/rdeps.R

EXPOSE 8787 8888
ENTRYPOINT ["/app/entrypoint.sh"]
