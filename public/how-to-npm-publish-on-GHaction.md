---
title: GitHubアクションのワークフローを使ってNPMライブラリを公開する方法
tags:
  - github
private: false
updated_at: null
id: null
organization_url_name: null
slide: false
ignorePublish: false
---

こんにちは，ご覧いただきありがとうございます。
前回，NPMライブラリの作り方を簡単にまとめました。

https://qiita.com/ikepu-tp/items/90e32aac354e0a5b0b6e

ただ，毎回`npm publish`をするのは大変なのでGitHubのアクションを使って自動化します。

## 作ったもの

`/.github/workflows/npm-publish.yml`を次のように作成した。
`secrets`に`NPM_TOKEN`という名前でNPMJSで発行したトークンを保存しておいてください。

```yaml:npm-publish.yml
name: npm publish

on:
  push:
    branches:
      - main
    paths:
      - package.json
  workflow_dispatch:

jobs:
  publish:
    runs-on: ubuntu-latest

    permissions:
      contents: write

    steps:
      - uses: actions/checkout@v3
        with:
          ref: main

      - uses: actions/setup-node@v3
        with:
          node-version: 18
          registry-url: "https://registry.npmjs.org"

      - name: install
        run: yarn install

      - name: build
        run: yarn build

      - name: publish
        run: npm publish
        env:
          NODE_AUTH_TOKEN: ${{secrets.NPM_TOKEN}}

```

## 参考

https://zenn.dev/kshida/articles/auto-generate-release-note-with-calver
