---
title: Laravel初学者へのすすめ#2
tags:
  - Laravel
  - 初学者
private: false
updated_at: ''
id: null
organization_url_name: null
slide: false
---

## はじめに

Laravelに関してまだまだな自分ですが，弟がLaravelを勉強してみたいとのことなので学習内容をまとる第2弾です。
これまでに個人開発で必要だと感じたことを中心にまとめて行きます。
Laravelに限らず。VSCodeやDockerのこともあるのでLaravel以外を学ぶ方にも役立ちます。
第2弾はLaravelの開発環境の構築やGitHubの使い方等です。

## 前提

- パソコンがある（Windowsを前提にまとめます。Macは適宜読み替え等してください。）
- Web制作ではなく，Web開発ができることが目標
- 学ぶ意欲がある
- ある程度のHTMLやCSS，JavaScriptを知っている
- 第1弾を読み終え，ある程度習得している

第1弾の記事は以下から。

https://qiita.com/ikepu-tp/items/f950cadf0dac7331b4b5

## 1. Laravelのプロジェクト作成

今回はDockerでLaravelを開発します。
そのため，phpやcomposerのインストールは不要です。
Laravelのプロジェクト作成に関しては次のサイトを参考にしてください。

## 2. GitHubにリポジトリ作成

上で作成したLaravelのプロジェクトについて，GitHubにリポジトリを作成し，プッシュしましょう。
GitHubのリポジトリ作成及びプッシュについては前回の第1弾の記事をご確認ください。

:::note info
Laravelが使える人が身近にいる場合，その方に添削等をお願いしてみましょう。
GitHubのリポジトリにはユーザーを招待する機能があります。添削してくれる人を招待しましょう。
:::

## 3. ブランチの分岐

GitHubにリポジトリを作成できたら新しくブランチを切りましょう。
`develop`や`practice`等お好みで。
その新しく作ったブランチで編集をしていきます。

## 4. Laravelを編集

### Dockerの起動

Laravelを使うにはDockerを起動する必要があります。
Laravelは`sail`というものが用意してあり，簡単にDockerの起動ができます。
コマンドを立ち上げ，Laravelのプロジェクトを作成したディレクトリに移動しましょう。

> VSCodeであれば，`Shift+Ctrl+P`で起動します。

```bash:Dockerの起動
./vendor/bin/sail up -d
```

### jsライブラリのインストール

Laravelのプロジェクトを作成した段階ではLaravelを動かすことはできますが，スタイルの適用やJavaScriptは動きません。
スタイルシートやJavaScriptはコンパイルが必要なためです。
それらを効率良くしてくれるものとして，Laravelでは`Vite`を使っています。
まずはJavaScriptライブラリをインストールしましょう。

```bash:ライブラリのインストール
sail yarn install
```

### 開発サーバの起動

JavaScriptライブラリのインストールが終わったら開発サーバを立ち上げましょう。

```bash:開発サーバ
sail yarn dev
```

以上でひとまず，Laravelの編集ができる様になりました。
[http://localhost](http://localhost)をブラウザゲーム開くと，ウェルカムページが表示されます。

http://localhost

## 5. Laravelの編集演習

それでは実際にLaravelを編集してみましょう。
Laravelについて解説されたサイトはたくさんあるのでここからは自身で検索し，次の課題を実装してください。
課題の添削が必要であれば，GitHubのリポジトリに招待していただければ時間がある時にみますよ。

> 演習課題はHTMLやCSS，JavaScriptができる前提です。
> これらについてわからないことがあれば自身で調べてください。
> *`blade`と`html`は若干違います。*

### 演習課題

1. `resources/views/welcome.blade.php`を編集し，編集が反映されていることをブラウザで確認しなさい。
2. `routes/web.php`を編集し，[http://localhost/welcome](http://localhost/welcome)で[http://localhost/](http://localhost)と同様のページを表示しなさい。
3. `resources/views/welcome.blade.php`を編集し，`@for`を用いて1から10まで表示しなさい。
4. `resources/views/welcome.blade.php`を編集し，`@if`を用いて午前中なら「午前中」，午後なら「午後」と表示しなさい。
