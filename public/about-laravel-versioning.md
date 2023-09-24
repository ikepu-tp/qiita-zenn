---
title: Laravelのバージョニングやリリースノートの作成を簡単にするパッケージを作ってみた
tags:
  - GitHub
  - Laravel
  - version
  - release
private: false
updated_at: null
id: null
organization_url_name: null
slide: false
ignorePublish: false
---

こんにちは，ご覧いただきありがとうございます。
タイトルの通り，Laravelにおいてバージョニングやリリースノートの作成を簡単にするパッケージを作ってみました。
ぜひぜひご利用ください！！

https://github.com/ikepu-tp/laravel-versioning

https://packagist.org/packages/ikepu-tp/laravel-versioning

## 機能

- リリースノートを対話形式のコマンドで生成
- GitHubを利用していればリリースやタグづけを自動化

## 使い方

### 1. **インストール**

```bash
composer require ikepu-tp/laravel-versioning
```

### 2. **インストールコマンド**

```bash
php artisan versioning:install
```

### 3. **リリースノートの作成**

```bash
php artisan versioning:make
```

| オプション             | 説明                                                |
| ---------------------- | --------------------------------------------------- |
| --VT / --version_type= | バージョンタイプの指定（`major`, `minor`, `patch`） |
| --J  / --major         | メジャーバージョンアップ                            |
| --M  / --minor         | マイナーバージョンアップ                            |
| --P  / --patch         | パッチバージョンアップ                              |

#### 詳細

リリースノートの作成においては対話形式のコマンドで以下の内容を記録します。

| キー            | 必須(Y/N) | 説明                                                         |
| --------------- | --------- | ------------------------------------------------------------ |
| version         | Y         | リリースノートを作成するバージョン                           |
| releaseDate     | Y         | リリース日                                                   |
| Author          | N         | リリースノート作成者名（箇条書き）                           |
| url             | N         | リリースノートに載せたいリンク（箇条書き）                   |
| description     | N         | 変更点等に関する簡潔な説明（箇条書き）                       |
| newFeatures     | N         | 新機能に関する説明（箇条書き）                               |
| changedFeatures | N         | 変更された機能に関する説明（箇条書き）                       |
| deletedFeatures | N         | 削除された機能に関する説明（箇条書き）                       |
| notice          | N         | 注意事項等ユーザーに伝えたい内容（箇条書き）                 |
| security        | N         | セキュリティに関する事柄でユーザーに伝えたい内容（箇条書き） |
| futurePlans     | N         | 今後の変更予定等（箇条書き）                                 |
| note            | N         | 備考                                                         |

上記の内容については以下の様に質問されます。

| キー            | 日本語                                         | English                                             |
| --------------- | ---------------------------------------------- | --------------------------------------------------- |
| version         | 次のバージョンは？                             | What's next version?                                |
| releaseDate     | リリース日は？                                 | When will you release?                              |
| Author          | 著者は？                                       | What's author name?                                 |
| url             | リリースノートに載せたいリンクは？             | What's links for release notes?                     |
| description     | 変更点等に関する簡潔な説明は？                 | What's description of changes, etc.?                |
| newFeatures     | 新機能に関する簡潔な説明は？                   | What's description of new features?                 |
| changedFeatures | 変更された機能に関する簡潔な説明は？           | What's description of changed features?             |
| deletedFeatures | 削除された機能に関する簡潔な説明は？           | What's description of deleted features?             |
| notice          | ユーザーに伝えたい注意事項等は？               | What's notices and important information for users? |
| security        | ユーザーに伝えたいセキュリティに関する事柄は？ | What's security-related information for users?      |
| futurePlans     | 今後の変更予定等は？                           | What's future plans and changes?                    |
| note            | 備考は？                                       | What's notes?                                       |

### 4. **リリースノートの閲覧**

[http://localhost/version](http://localhost/version)
*`http://localhost`はご自身のドメインを入力してください

## 今後の機能追加等

GitHubのリリースノートと連携できてもいいかもしれませんね。
