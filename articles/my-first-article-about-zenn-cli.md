---
title: "Zenn初投稿です！！Zenn CLI＋dockerでローカルでの執筆環境を作りました！"
emoji: "🙌"
type: "idea" # tech: 技術記事 / idea: アイデア
topics: [
  "zenn",
  "docker",
  "qiita",
  "GitHub"
]
published: true
---

はじめまして！今回，Zennへの投稿が初めてとなります！
最近，時間があ少しあって色々手を出して遊んでいるのですが，数日前には[Qiita](https://qiita.com/ikepu-tp)の投稿を始めました。

基本的には同じ記事を流していこうと思うのですが，どちらかのみの投稿もあるので良ければご覧いただけたらと思います。

記念すべき初投稿は`docker`+`Zenn CLI`でローカルに執筆環境を作ったのでその共有です。

## はじめに

`Qiita`の執筆環境をローカルに作っており，それを編集する形としました。
また，複数の端末（Win11デスクトップx2，Win11ノートパソコン，MacBookAir）を使っており，どの端末でも簡単に使えるように`Docker`を使用しています。

## 前提

1. `Zenn`と`GitHub`を連携している。
2. `Qiita Cli`を`docker`で構築している。
`Qiita CLI`の構築は`Qiita`の記事をご覧ください。

https://qiita.com/ikepu-tp/items/c22bf26ee97100f64d9a

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

## 最終的な形

```bash:dir
/root
  /.github/workflows
    - publish.yml #Qiita投稿用workflow
  /articles
    - *.md #Zenn投稿用Markdown
  /books
    - *.md #Zennの本用Markdown
  /qiita
    /.config
      - credentials.json #これがないとエラーが起きる　なぜ？
    /public
      - *.md #Qiita投稿用Markdown
    - Dockerfile #Qiita用node
    - package.json
    - qiita.config.json
  /zenn
    - Dockerfile #Zenn用node
  - .gitignore
  - docker-compose.yml
  - package.json
  - README.md #ZennCLIでインストールすると勝手に作られたがなくてもよい
```

## 構築手順

### 1. `docker-compose`編集

1. `Qiita`のディレクトリを`./qiita`にしたので`volumes`を変更します。
2. `Zenn`のコンテナを追加します。

```diff docker:docker-compose.yml
version: "3"
services:
  qiita:
    container_name: qiita
    build:
      context: .
      dockerfile: ./qiita/Dockerfile
    tty: true
    ports:
      - 8888:8888
    volumes:
+      - ./qiita:/qiita
    environment:
      TZ: Asia/Tokyo
+  zenn:
+    container_name: zenn
+    build:
+      context: .
+      dockerfile: ./zenn/Dockerfile
+    tty: true
+    ports:
+      - 9999:8000
+    volumes:
+      - ./:/zenn
+    environment:
+      TZ: Asia/Tokyo
```

### 2. Qiita投稿用のワークフローの編集

Qiitaのディレクトリを変更したのでワークフローを編集します。

```diff yml:publish.yml
name: Publish articles

on:
  push:
    branches:
      - main
+    paths:
+      - "qiita/**"
  workflow_dispatch:

permissions:
  contents: write

concurrency:
  group: ${{ github.workflow }}-${{ github.ref }}
  cancel-in-progress: false

jobs:
  publish_articles:
    runs-on: ubuntu-latest
    timeout-minutes: 5
    steps:
      - uses: actions/checkout@v3
        with:
          fetch-depth: 0
      - uses: increments/qiita-cli/actions/publish@v1
        with:
          qiita-token: ${{ secrets.QIITA_TOKEN }}
+          root: "./qiita/"
```

### 3. `Zenn Cli`のインストール

1. `npm`を用いてインストールします。
2. `Zenn`の初期化をします。

```bash
docker-compose exec -it zenn sh
npm install zenn-cli #インストール
npx zenn init #初期化
```

### 4.`Zenn`のプレビュー

```bash
npx zenn preview
```

以下のURLにアクセスすると，プレビュー画面が表示されます

http://localhost:9999

## さいごに

`Zenn CLI`の詳細はZenn公式の投稿にありますのでそちらをご確認いただけたらと思います。

## 参考

https://zenn.dev/zenn/articles/install-zenn-cli#2.-zenn%E7%94%A8%E3%81%AE%E3%82%BB%E3%83%83%E3%83%88%E3%82%A2%E3%83%83%E3%83%97%E3%82%92%E8%A1%8C%E3%81%86

https://zenn.dev/zenn/articles/zenn-cli-guide
