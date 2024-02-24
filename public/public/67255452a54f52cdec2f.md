---
title: GitからクローンしたLaravelをDockerのみでパッケージをインストールする
tags:
  - Git
  - Laravel
  - Docker
  - Sail
private: false
updated_at: '2023-09-12T05:06:57+09:00'
id: 67255452a54f52cdec2f
organization_url_name: null
slide: false
ignorePublish: false
---

## はじめに

こんにちは。
最近，`sail`を用いた開発をすることが多くなりましたね。（自分だけじゃないはず）
自分はパソコン3台（Windows11\*2，MacM1\*1）を使っており，色々なリポジトリをクローンしまくってます。
リポジトリをクローンしたら初めにパッケージが必要になりますが，パッケージをインストールしていないため，`sail`が使えません。
そのパッケージをインストールするためにローカルに`composer`等を入れるのはイヤです。
そこで`composer`等をインストールしなくてもできる方法をまとめておきます。

## `composer install`の実行

とても簡単でした。

```bash:composer install
docker run --rm \
    -u "$(id -u):$(id -g)" \
    -v "$(pwd):/var/www/html" \
    -w /var/www/html \
    laravelsail/php82-composer:latest \
    composer install
```

| オプション | 意味                                 |
| ---------- | ------------------------------------ |
| `-u`       | コマンドが実行されるユーザーの設定   |
| `--rm`     | コマンドの実行完了時，コンテナの破棄 |
| `-v`       | ボリュームの設定                     |
| `-w`       | コンテナ内の作業ディレクトリを指定   |

## 参考

https://laravel.com/docs/10.x/sail

https://qiita.com/TaaaZyyy/items/4ecf21f23e6730faf696

https://minegishirei.hatenablog.com/entry/2023/05/09/095603
