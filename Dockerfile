FROM node:20-alpine3.17

WORKDIR /qiita

RUN sed -e "s/localhost/qiita/g" -i /qiita/node_modules/@qiita/qiita-cli/dist/server/app.js

EXPOSE 8888