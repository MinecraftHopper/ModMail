FROM node:22 AS BUILD_IMAGE

ENV VERSION=v3.8.0

WORKDIR /usr/src/app

RUN git clone https://github.com/Dragory/modmailbot && \
    cd modmailbot && \ 
    git checkout ${VERSION} && \
    npm install -g minify-all node-prune && \
    npm ci --only=production && \
    npm prune --production && \
    node-prune && \
    minify-all


FROM node:22-alpine
ENV MM_MAIN_SERVER_ID= \
    MM_INBOX_SERVER_ID= \
    MM_LOG_CHANNEL_ID= \
    MM_ALLOW_USER_CLOSE=1 \
    MM_TOKEN= \
    MM_LOG_STORAGE=local \
    MM_DB_TYPE=sqlite \
    MM_CLOSE_MESSAGE="This thread has been closed." \
    MM_CATEGORY_AUTOMATION__NEW_THREAD= \
    MM_STATUS="Modmail, the way to report things" \
    MM_URL=

COPY --from=BUILD_IMAGE /usr/src/app/modmailbot /usr/src/modmailbot

WORKDIR /usr/src/modmailbot

ENTRYPOINT  ["npm", "start"]
