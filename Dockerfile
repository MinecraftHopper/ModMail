FROM node:14

ENV VERSION=v3.3.2

RUN git clone https://github.com/Dragory/modmailbot && \
    cd modmailbot && \ 
    git checkout ${VERSION} && \
    npm ci

ENV MM_MAIN_SERVER_ID=
ENV MM_INBOX_SERVER_ID=
ENV MM_LOG_CHANNEL_ID=
ENV MM_ALLOW_USER_CLOSE=1
ENV MM_TOKEN=
ENV MM_LOG_STORAGE=none
ENV MM_DB_TYPE=sqlite
ENV MM_CLOSE_MESSAGE="This thread has been closed."
ENV MM_MYSQL_OPTIONS__HOST=localhost
ENV MM_MYSQL_OPTIONS__PORT=3306
ENV MM_MYSQL_OPTIONS__USER=
ENV MM_MYSQL_OPTIONS__PASSWORD=
ENV MM_MYSQL_OPTIONS__DATABASE=modmail
ENV MM_CATEGORY_AUTOMATION__NEW_THREAD=
ENV MM_STATUS="Modmail, the way to report things"

WORKDIR modmailbot

ENTRYPOINT  ["npm", "start"]
