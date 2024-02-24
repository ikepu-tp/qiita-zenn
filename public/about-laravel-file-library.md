---
title: "Laravel用ファイルライブラリの作成"
tags:
  - "Laravel"
  - "FileLibrary"
private: false
updated_at: null
id: null
organization_url_name: null
slide: false
ignorePublish: false
---

## はじめに

今回，Laravel用のファイルライブラリを作成しました。
このライブラリは，ファイルのアップロード，表示，編集，削除を行うことができます。

本ライブラリの他に，

- Laravel-medialibrary
- laravel-filemanager

等があるようです。

https://qiita.com/MINORI_Ta/items/7d40329590efb053b14a

https://unisharp.github.io/laravel-filemanager/

これらのライブラリも素晴らしいものですが，少しばかり高機能なように感じました。
自分があったらいいなと思うファイルライブラリはWordPressのメディアライブラリのようなものです。
そのため，今回は，ファイルのアップロード，表示，編集，削除の機能を持つファイルライブラリを作成しました。

## ファイルライブラリの目標

ファイルライブラリを作成するにあたって以下を目標とします。

1. 機能感はWordPressのメディアライブラリに近い
2. 特に設定をしなくても使える
   1. アップロードしたファイルの一覧等をデフォルトで表示できる
   2. ファイルのアップロードフォームをデフォルトで使用できる
3. ファイルのアップロードや情報の取得，編集をAPIを通じて行うことができる
4. ファイルのアップロードや情報の取得，編集をインスタンスで行うことができる

:::note
現在は，1，2の目標を達成しています。
:::

## 作成したファイルライブラリ

リポジトリは以下のGitHubにあります。

https://github.com/ikepu-tp/laravel-file-library

また，Packagistにも登録しています。

https://packagist.org/packages/ikepu-tp/laravel-file-library

## 使い方

### インストール

```bash
composer require ikepu-tp/larave-file-library
```

### 設定等のpublish

```bash
php artisan vendor:publish --provider="ikepu_tp\FileLibrary\FileLibraryServiceProvider"
```

### ルーティング

| HTTPメソッド | URI                     | アクション | ルート名             | 簡単な説明                                                   |
| ------------ | ----------------------- | ---------- | -------------------- | ------------------------------------------------------------ |
| GET          | /file/lib               | index      | file-library.index   | ファイルライブラリの一覧を表示します。                       |
| GET          | /file/lib/create        | create     | file-library.create  | 新しいファイルをアップロードするためのフォームを表示します。 |
| POST         | /file/lib               | store      | file-library.store   | ファイルをアップロードします。                               |
| GET          | /file/lib/{fileId}      | show       | file-library.show    | 特定のファイルの詳細を表示します。                           |
| GET          | /file/lib/{fileId}/edit | edit       | file-library.edit    | 特定のファイルの編集フォームを表示します。                   |
| PUT/PATCH    | /file/lib/{fileId}      | update     | file-library.update  | 特定のファイルを更新します。                                 |
| DELETE       | /file/lib/{fileId}      | destroy    | file-library.destroy | 特定のファイルを削除します。                                 |

:::note
`{fileId}` はUUIDです。
:::

#### ファイルのアップロード

```bash
POST http://your-project.com/file/lib
```

| Key   | Type               | Accepted Values | Required |
| ----- | ------------------ | --------------- | -------- |
| files | Array<int, File>   |                 | Y        |
| names | Array<int, string> | max length: 250 | Y        |

#### ファイルの編集

```bash
PUT http://your-project.com/file/lib/{fileId}
```

| Key  | Type   | Accepted Values | Required |
| ---- | ------ | --------------- | -------- |
| name | string | max length: 250 | Y        |

## 今後の機能追加等

まずは目標の3と4を達成することを目指します。
その次に，どういったものを追加するかは，使っている方の要望を聞きながら進めていきたいと思います。
また，Google Classroomのようにファイル選択フォームの追加もいいかもしれないとも考えています。
ただ，高機能になればなるほど既存ライブラリに近づいてしまうのであくまでもシンプルにデフォルトから使えるようにしていきたいと思います。
何か機能の提案等があれば，コメントやGitHubのIssueに投稿していただけると嬉しいです！！
