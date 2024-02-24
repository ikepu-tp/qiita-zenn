---
title: 'Laravelの`storage:link`のシンボリックリンクがうまくできなかった話'
tags:
  - Laravel
  - Docker
  - WSL2
  - Sail
private: false
updated_at: '2023-11-16T20:17:01+09:00'
id: 11a50078c15eaa880e26
organization_url_name: null
slide: false
ignorePublish: false
---

ご覧いただき，ありがとうございます。
Laravelの`storage:link`を張ったのに画像が表示されない問題でつまずいたので，その解決方法を共有します。
いつも通り，シンボリックリンクを張ったのですが，画像が表示されませんでした。
答えは単純です。
`storage`ディレクトリの権限が`777`になっていなかったのです。
ということで，以下のコマンドを実行して権限を変更しましょう。

```bash
chmod -R 777 storage/app/public
```

権限設定は難しいですね。
