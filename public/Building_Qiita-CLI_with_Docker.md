---
title: Dockerを用いたqiita-cliの環境構築
tags:
  - 'Docker'
  - 'Qiita'
  - 'qiita-cli'
private: false
updated_at: ''
id: null
organization_url_name: null
slide: false
---

こんにちは，ご覧いただきありがとうございます。
普段，皆さんはコーディングの時にどのソフトを使っていますか？
ちなみに私はVSCodeを使っています。
使い慣れているソフトがあるのであれば，Qiitaの投稿もそれを使ってしたいですよね！！

それを可能にする

https://github.com/increments/qiita-cli

というものがありました！
Dockerを使ってローカルで環境構築をしたのでその備忘録です。
皆さんのお役に立つことを願って…

## 環境

- Windows11
- WSL2

```bash:wsl2
$ cat /etc/lsb-release

DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=22.04
DISTRIB_CODENAME=jammy
DISTRIB_DESCRIPTION="Ubuntu 22.04.2 LTS"
```

## 1. Dockerfileの作成

Dockerを使うのではじめは当然`Dockerfile`の作成です。
適当に作業ディレクトリを作ってください。

```Dockerfile:Dockerfile
FROM node:20-alpine3.17

WORKDIR /qiita

RUN sed -e "s/localhost/qiita/g" -i /qiita/node_modules/@qiita/qiita-cli/dist/server/app.js

EXPOSE 8888
```

```yaml:docker-compose.yml
version: "3"
services:
  qiita:
    container_name: qiita
    build:
      context: .
      dockerfile: Dockerfile
    tty: true
    ports:
      - 8888:8888
    volumes:
      - ./:/qiita
    environment:
      TZ: Asia/Tokyo
```

## 2. コンテナの起動

```bash
docker-compose up -d
```

## 3. `qiita-cli`のインストール

```bash
docker-compose exec -it qiita sh
npm install @qiita/qiita-cli --save-dev
```

```bash
npx qiita version
```

でバージョンが表示されればインストール成功です。

## 4. `qiita-cli`の設定

### 4-1. 初期設定

```bash
npx qiita init
```

### 4-2. Qiitaログイン

#### APIキーの生成

以下からAPIキーを生成しておいてください。

https://qiita.com/settings/tokens/new?read_qiita=1&write_qiita=1&description=qiita-cli

#### CLIでのログイン

```bash
npx qiita login
```

トークンを聞かれるので上で発行したキーを入力してください。

### 4-3. プレビュー画面の表示

```bash
npx qiita preview
```

プレビュー画面が起動されたはずです！

http://localhost:8888/

:::note info
もし2回目以降に`npx qiita preview`でエラーが起きる場合
`~/.config/qiita-cli/credentials.json`を作成すると大丈夫でそうです。
:::

以上でローカルに`qiita-cli`の環境構築ができました。
これからのQiita投稿作業が幾分か楽になりそうです！！（笑）

## 参考

https://qiita.com/engishoma/items/13b7eac3b335b56711a7

https://qiita.com/yukin01/items/4f54496fd2f577c56b1d

https://github.com/increments/qiita-cli
