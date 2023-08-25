---
title: Laravel用ショートリンク作成＆アクセス記録機能を公開しました！！
tags:
  - Composer
  - Laravel
private: false
updated_at: '2023-08-18T10:38:19+09:00'
id: b8aaf4e4c2a447f6f6db
organization_url_name: null
slide: false
---
こんにちは，ご覧いただきありがとうございます。

時間があって暇だったのでショートリンク作成ライブラリを作りました。
投稿が前後しちゃったのですが，ライブラリ作成の初挑戦のものです！

[https://github.com/ikepu-tp/laravel-shorter-url](https://github.com/ikepu-tp/laravel-shorter-url)

## 機能

- 任意のURLについて，自身のドメインでショートリンクの作成
- デバイスやリファラ別にアクセス集計

## インストール

### 1.composerでインストール

```bash
composer require ikepu-tp/laravel-shorter-url
```

### 2.設定ファイルの設定

```bash
php artisan vendor:publish -tags=shorterUrl-config
```

### 3.マイグレーション

```bash
php artisan migrate
```

これでインストールは終了です。
[http://localhost/shorter-url/link](http://localhost/shorter-url/link)にアクセスしてみてください。
登録リンクの一覧が表示されると思います。（空だと思いますが）

## 今後の更新予定

とりあえず公開したという感じなので今後も機能追加していきたいと思います。
よければGithubのスターやフォローをお願いします！
もちろん，プルリクもお待ちしています！！

### 追加したい機能

- APIに対応
- Reactに対応
- アクセス集計の詳細
  - 日時別
- アクセス期間の設定
  - アクセス可能開始日時の設定
  - アクセス可能終了日時の設定
