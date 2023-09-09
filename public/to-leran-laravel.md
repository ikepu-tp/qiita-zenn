---
title: Laravel初学者へのすすめ#1
tags:
  - Git
  - GitHub
  - Laravel
  - Docker
  - 初学者
private: true
updated_at: '2023-09-09T15:30:12+09:00'
id: f950cadf0dac7331b4b5
organization_url_name: null
slide: false
---

## はじめに

Laravelに関してまだまだな自分ですが，弟がLaravelを勉強してみたいとのことなので学習内容をまとめます。
これまでに個人開発で必要だと感じたことを中心にまとめて行きます。
Laravelに限らず。VSCodeやDockerのこともあるのでLaravel以外を学ぶ方にも役立ちます。
第1弾はLaravel利用前の開発環境の構築やGitHubの使い方等です。

## 前提

- パソコンがある（Windowsを前提にまとめます。Macは適宜読み替え等してください。）
- Web制作ではなく，Web開発ができることが目標
- 学ぶ意欲がある

## 1. Docker, WSL2のインストール

これはマストではないですが，複数人で開発する際はDockerを用いた方が環境構築が早いのです。
Laravelでは`sail`というものが用意され，簡単にDockerを使える様になっています。
なお，以後は`sail`を使うことを前提に話を進めます。

Windowsの方はDockerを使うためにWSL（Windows上で動かすLinux）が必要です。インストールは次のサイトを参考にしてください。

Dockerのインストールは次のサイトを参考にしてください。

## 2. VSCodeのインストール

VSCodeのインストールは次のサイトを参考に行なってください。

また，開発が早くなる様に拡張機能を色々インストールする必要があります。今回は自分が使っている拡張機能の設定データを公開しているのでそちらをインポートすればあっと言う間に必要な拡張機能がインストールされます。

VSCodeの使い方はGoogleで調べてください。

## 3. Gitのインストール

Gitとはコード管理ツールです。
Gitのインストールについては次のサイトを参考にしてください。

なお，Gitは次の段階を経てリモートリポジトリにアップされます。

1. プログラムの変更
2. コミットの作成
3. プッシュ
4. リモートリポジトリにプログラムの変更が反映

## 4. GitHubアカウントの作成

上記のGitのサービスを提供してくれるメジャーなサイトです。
GitHubアカウントを作成してください。
GitHubのアカウント作成は次のサイトを参考にしてください。

なお，あなたのアカウント名はログイン後の[https://github.com/](https://github.com/)の左上に表示されるものです。
[https://github.com/アカウント名](https://github.com/アカウント名)がGitHubのあなたのプロフィール画面になります。

## 5. GitHubへのテストプッシュ

1. 適当なディレクトリ下（Documents等）に`test`ディレクトリ（フォルダ）を作成してください。
2. 2.でインストールしたVSCodeを開き，「フォルダを開く」から`test`を開いてください。
3. `readme.md`を作成し，適当に入力してください。（下に例を書いています）
4. VSCodeのGitツールを利用し，GitHubに公開します。リポジトリ名はGitHubのアカウント名として，publicリポジトリにしましょう。（他のリポジトリ名でも問題ないです）
5. [https://github.com/アカウント名/リポジトリ名](https://github.com/アカウント名/リポジトリ名)を開き，先ほど作成した`readme.md`があれば成功です。

### VSCodeでのGitHubへのプッシュ

### `readme.md`の記述例

```json:readme.md
# Welcome to *アカウント名*

This repository is described about *アカウント名*.

## About me

* University student in Technology faculty
* Laravel Engineer
```

## 6. GitHubの実用的運用

GitHubの実用的な運用をする前にGitに関する用語の説明をします。

### コミット -commit-

プログラミングがある程度できたところでコミットを行います。
コミットを行った後にプッシュすることでGitHubにプログラムの変更が反映されます。
5.のところで実際にされたと思います。
そのコミットをする際にはコメントが必要となります。
ただ闇雲にコメントをしてもレビューの際に困るため，ある程度規則性があるコメントが必要です。
私が普段運用しているコミットのメッセージルールは別でまとめますのでそちらをご覧ください。

### ブランチ -branch-

Gitには`branch`というものがあり，これでコードのバージョン等をわけることが多いです。
また，機能追加や修正の際もブランチを切ってから作業をし，最終的にマージをするといったことも多いです。
`branch`の運用についてもさまざまありますが，私が普段運用している`branch`ルールは別でまとめますのでそちらをご覧ください。

### プルリクエスト -Pull Request(PR)-

ブランチの節でブランチをマージすることを書きました。
ただ，チーム開発をしている際に勝手にブランチをマージされても周囲の人が困ることがありますよね。例えば，変数名が分からなかったり，新たなバグが発生し，他の人の作業に影響が出る等。
それを防ぐためにGitHubではブランチをマージする前にPull  Request（PR）を送れる様になっています。PR後にレビューワーがコードを確認し，修正内容が大丈夫であればマージしてくれます。

### GitHubの実用的運用演習

それではGitに関する用語について，ある程度理解できたことだと思うので実際にやってみましょう。
5.の時のディレクトリをVSCodeで開いていますか？開いていない方は開きましょう。

1. VSCodeの左下に`main`または`master`と表示されていると思うのでそれをクリックし，新しい`branch`を作成しましょう。（ここでは`feature-practice`を作ったとします）
2. 先ほどの`readme.md`を変更しましょう。（例えば著作権を追加しましょうか。）
3. VSCodeのGitツールを使って，`コミットメッセージ`を入力し，コミットしましょう。
4. `branch`を公開(publish)しましょう。
5. [https://github.com/アカウント名/リポジトリ名/pull_request](https://github.com/アカウント名/リポジトリ名/pull_request)にアクセスしましょう。`main`では変更されていませんが，`feature-practice`に切り替えると，変更されているはずです。
6. `New Pull Request`からPull Requestを作成します。名前は適当に（例えば「PR practice」）して，`feature-practice`から`main`(`master`)に対してPRを出しましょう。(`main`<-`feature-practice`のような表示になると思います)
7. Pull Requestを作成したらマージをしてみましょう。マージをしたら`main`にも先ほどの変更が反映されます。

#### `readme.md`の変更例

```diff_json:readme.md
# Welcome to *アカウント名*

This repository is described about *アカウント名*.

## About me

* University student in Technology faculty
* Laravel Engineer

+ ## Copyright
+
+ Copyright (c) 2023 ikepu-tp.
```

## まとめ

第1弾では
