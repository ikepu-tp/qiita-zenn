---
title: Laravelの`Collection`におけるPhpDocの設定
tags:
  - PHP
  - Laravel
  - PHPDoc
private: false
updated_at: '2023-11-13T17:51:47+09:00'
id: 25f80de0e272789133d0
organization_url_name: null
slide: false
ignorePublish: false
---

こんにちは，ご覧いただきありがとうございます。


## はじめに

Laravelをお使いの皆さんはプログラミングする際にPhpdocを使われていますか？
私はいつも使っているのですが，`Collection`の際の使い方がいまいちわかっておりませんでした。
ググってもほしい情報はヒットしませんでした（キーワードの問題？）

今回，プログラミング中にたまたま書き方がわかったので共有します。
といってもシンプルに`array`と同様でした。笑

## `Collection`におけるPhpdoc

```php
/** @var \Illuminate\Database\Eloquent\Collection<, \App\Models\Model> */
// あるいは
/** @var \Illuminate\Database\Eloquent\Collection<int, \App\Models\Model> */
```

## 結論

ものは試しですね！
