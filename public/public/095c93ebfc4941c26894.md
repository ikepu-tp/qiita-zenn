---
title: Reactライブラリ用のテンプレートを作成してみた
tags:
  - template
  - npm
  - library
  - React
  - storybook
private: false
updated_at: '2023-11-01T23:39:45+09:00'
id: 095c93ebfc4941c26894
organization_url_name: null
slide: false
ignorePublish: false
---

こんにちは，ご覧いただきありがとうございます。
普段，Reactでフロントを作成しているのですが，個人開発なため，毎度同じようなコンポーネントを利用します。
そのため，最近はライブラリ化を行い，それぞれのコンポーネントを使いまわすようにしています。（これについては賛否両論あるかもしれませんが）
しかし，そのライブラリ化を行うにあたって，毎度同じようなリポジトリを作るのも億劫です（本当に面倒くさがりなんです）。
そこで今回，そのリポジトリをテンプレートにしちゃえということで作成しました。

https://github.com/ikepu-tp/js-lib-template

テンプレートとしてリポジトリを登録しておりますので右上の「Use this template」から簡単にリポジトリをコピーできます！！
ぜひご活用ください！！

以下はリポジトリについての簡単に説明です。

## 前提

- Reactのためのライブラリ
- Storybookでコンポーネント管理
- ビルド等はVite

## ディレクトリ・ファイル等

### ~/.github/workflows/publish.yml

`main`ブランチにおいて，`package.json`が更新された際に実行されます。

1. ビルドが行われ，npmに公開します。
2. `package.json`の`version`の値から取得したリリースとそのブランチを作成します。

:::note info
アクションのsecretsに`NPM_TOKEN`に`npmjs.org`で発行したトークンを登録しておいてください。
:::

### ~/.github/workflows/sb-build.yml

`main`ブランチにおいて，`/stories/*`が更新された際に実行されます。

1. `yarn build-sb`(`Storybook`のビルド)が行われます。
2. `gh-pages`にプッシュします。

:::note info
`gh-pages`のブランチを事前に作成してください。
:::

### ~/.storybook

`Storybook`に関する設定等のファイルです。
`Storybook`については公式サイトをご確認ください。

https://storybook.js.org/

### ~/docs

`Storybook`のビルドファイルを格納します。
GitHub Pagesで

### ~/src/index.ts

このファイルにコンポーネントを定義し，`export`してください。
あるいは他のファイルのコンポーネントを`import`し，`export`してください。
このファイルの内容のビルドが行われ，ライブラリとして公開されます。

### ~/stories

`Storybook`で管理するコンポーネントのストーリーファイルを作成してください。
詳細は公式サイトをご確認ください。

https://storybook.js.org/

### ~/*

諸々のファイルがありますが，ここでの説明は割愛します。
