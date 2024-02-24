---
title: GitHubアクションのワークフローを使ってリリースを作成する方法
tags:
  - GitHub
private: false
updated_at: '2023-09-24T16:42:27+09:00'
id: 2841e1dbbc8bf363a8fd
organization_url_name: null
slide: false
ignorePublish: false
---

こんにちは，ご覧いただきありがとうございます。
前回，`package.json`を更新したら`npm publish`されるワークフローについてまとめました。

https://qiita.com/ikepu-tp/items/8c7e9975d3f3864afc48

ついでにこのタイミングで`release-v*`のブランチ作成とリリース作成も自動化することにしました。

## 作ったもの

`/.github/workflows/npm-publish.yml`を次のように作成した。
`secrets`に`NPM_TOKEN`という名前でNPMJSで発行したトークンを保存しておいてください。

```diff_yaml:npm-publish.yml
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
        
+      - name: create release branch
+        run: |
+          git config --global user.name 'github-actions[bot]'
+          git config --global user.email '41898282+github-actions[bot]@users.noreply.github.com'
+          git branch release-${{ env.RELEASED_VERSION }}
+          git push -u origin release-${{ env.RELEASED_VERSION }}
+          git branch -a
+
+      - name: create release
+        run: |
+          curl -X POST \
+            -H "Authorization: token ${{ secrets.GITHUB_TOKEN }}" \
+            -d "{ \"tag_name\": \"${{ env.RELEASED_VERSION }}\", \"name\": \"${{ env.RELEASED_VERSION }}\", \"generate_release_notes\": true }" \
+            https://api.github.com/repos/ikepu-tp/react-mvc/releases

      - name: publish
        run: npm publish
        env:
          NODE_AUTH_TOKEN: ${{secrets.NPM_TOKEN}}

```

## 参考

https://zenn.dev/kshida/articles/auto-generate-release-note-with-calver

https://github.com/increments/qiita-cli/blob/main/.github/workflows/publish-package.yml
