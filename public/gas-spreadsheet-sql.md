---
title: GASでスプレッドシートをSQL風に操作したい！！
tags:
  - GAS
  - spreadsheet
private: false
updated_at: '2024-09-23T19:53:42+09:00'
id: bc7fee3593a6479d0af6
organization_url_name: null
slide: false
ignorePublish: false
---

# GASでスプレッドシートをSQL風に操作したい！！

## はじめに

こんにちは，ご覧いただきありがとうございます！
皆さんは仕事でGoogle SpreadSheetを使いますか？
GAS（Google Apps Script）を使ってスプレッドシートを操作することはありますか？
私の職場（学校）はGoogle Workspaceを利用しており，スプレッドシートを使う機会が多いです。
そのため，業務効率化のためにGASを使うことが多々あります。
しかしながら，SQLを使っている身からすると，スプレッドシートの操作は少し煩雑ですよね。
おそらく多くの方がスプレッドシートのデータをSQL風に扱いたいと思われているのではないでしょうか？
そこで，GASでスプレッドシートをSQL風に操作する方法をまとめたいと思います。

## 既存のライブラリ

当たり前ですが，SQLライクに操作できるライブラリを調べました。
以下の方が作成されているライブラリがありました。

https://qiita.com/roana0229/items/fea931fcabc57f193620

しかしながら，このライブラリはメンテナンスが終了しているようです。
そこで，新たに似たようなライブラリを作りました。

## ライブラリ

GitHub: [https://github.com/ikepu-tp/spreadsheets-sql](https://github.com/ikepu-tp/spreadsheets-sql)
Documentation: [https://script.google.com/macros/library/d/1RV4noVBniL1qVgNX0gqHM2qM_I2L-1dE8uSmuqyEklbBBgYw9eodmV65/2](https://script.google.com/macros/library/d/1RV4noVBniL1qVgNX0gqHM2qM_I2L-1dE8uSmuqyEklbBBgYw9eodmV65/2)
Scirpt ID: `1RV4noVBniL1qVgNX0gqHM2qM_I2L-1dE8uSmuqyEklbBBgYw9eodmV65`

### 使い方

GASプロジェクトに上記のスクリプトIDからライブラリを追加してください。
SQLライクに取得，保存，更新，削除ができます。

#### スプレッドシートの設定

シート=テーブル，1行目=カラム名となるようにシートを作成してください。

#### スプレッドシートを開く

```javascript
const sql = SpreadsheetSQL.SQL('spreadsheetId', "sheetName");
```

#### データの取得

```javascript
sql.get();
```

##### データのフィルタリング

データをフィルタリングしたい場合，`where`，`orWhere`， `whereIn`が使用できます。

###### `where`の使用

```javascript
sql.where(
  [
    "name", //カラム名
    "=", //関係子
    "John" //値
  ]
);
```

関係子は`=`， `!=`， `>`， `<`， `>=`，`<=`が使用できます。
`=`の時は省略出来ます。

```javascript
sql.where(
  [
    "name", //カラム名
    "John" //値
  ]
);
```

複数の条件がある場合は，配列をネスト化してください。

```javascript
sql.where(
  [
    [
      "name", //カラム名
      "=", //関係子
      "John" //値
    ],
    [
      "age", //カラム名
      ">", //関係子
      20 //値
    ]
  ]
);
```

###### `orWhere`の使用

```javascript
sql.orWhere(
  [
    "name", //カラム名
    "=", //関係子
    "John" //値
  ]
);
```

###### `whereIn`の使用

```javascript
sql.whereIn(
  [
    "name", //カラム名
    ["John", "Mike"] //値
  ]
);
```

##### 特定の列の選択

特定の列を選択するには、`select`メソッドを使用します。

```javascript
sql.select(["name", "age"]);
```

##### 最初のレコードの取得

最初のレコードのみを取得するには、`first`メソッドを使用します。

```javascript
sql.first();
```

##### 最後のレコードの取得

最後のレコードのみを取得するには、`last`メソッドを使用します。

```javascript
sql.last();
```

##### 特定のレコードの検索

特定のIDのレコードを検索するには、`find`メソッドを使用します。

```javascript
sql.find(1);
```

カスタムキー名を設定するには、`setKeyName`メソッドを使用します。

```javascript
sql.setKeyName('id');
sql.find(1);
```

#### 新しいデータの保存

```javascript
sql.fill({name: 'John', age: 20});
sql.save();
```

#### 既存データの更新

```javascript
sql.find(1);
sql.fill({name: 'John', age: 21});
sql.save();
```

#### 既存データの削除

```javascript
sql.find(1);
sql.deleteRecord();
```

## 最後に

スプレッドシートをGASでSQLライクに扱うためのライブラリはいかがでしょうか？
イシューやプルリクも歓迎しております！
皆様のお力添えを頂ければと思いますので，よろしくお願いいたします！！
