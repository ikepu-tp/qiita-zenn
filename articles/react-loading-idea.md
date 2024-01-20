---
title: "React.jsでAPI通信時のLoadingメッセージについて考える"
emoji: "👌"
type: "idea" # tech: 技術記事 / idea: アイデア
topics: [
  "react.js",
  "API"
]
published: true
---

こんにちは。ご覧いただきありがとうございます。
今回はReact.jsにおいて，ローディングメッセージの表示についてアイディアを書き綴ります。

## API通信

React.jsでAPI通信する際，私はモデルを通して行っています。
主に以下のライブラリを使っています。

https://github.com/ikepu-tp/react-mvc

モデルはざっくりと以下のようなものです。

```javascript:Model
export default class Model{
  async public get(params) {
    return await fetch("http://example.com");
  }
}
```

これをコンポーネント内で読み込み，データを取得します。

```javascript:Component
function Component() {
  useEffect(() => {
    const model = new Model();
    model.get();
  }, [])

  return <></>;
}
```

## ローディングメッセージの出し方

### コンポーネント内で処理

上記のようにAPI通信を実装している場合，ローディングメッセージを表示するにはコンポーネント内での処理が必要になります。
例えば，以下のような方法があります。

```diff javascript:Component
function Component() {
+ const [Loading, setLoading] = useState(false);

  useEffect(() => {
+   setLoading(true);
    const model = new Model();
-   model.get();
+   model.get().then(() => setLoading(false));
  }, [])

- return <></>;
+ return <>{Loading ? "Loading..." : ""}</>;
}
```

しかし，この方法は毎回コンポーネント内で処理を書く必要があります。
そこでモデル内に詳しい処理を含める方法もあるでしょう。

### モデル内でも処理

上記のコンポーネント内の処理を一部モデルに移してみます。

```diff javascript:Model
export default class Model{
+
+ constructor(setLoading) {
    this.setLoading = setLoading
  }
+
  async public get(params) {
+   this.setLoading(true);
+   const response = await fetch("http://example.com");
+   this.setLoading(false);
+   return response
-   return await fetch("http://example.com");
  }
}
```

```diff javascript:Component
function Component() {
+ const [Loading, setLoading] = useState(false);

  useEffect(() => {
-   const model = new Model();
+   const model = new Model(setLoading);
    model.get();
  }, [])

- return <></>;
+ return <>{Loading ? "Loading..." : ""}</>;
}
```

コンポーネント内で全て処理をすることよりも幾分シンプルになりました。
それでも各コンポーネント内で処理が必要です。
そこでHTMLを駆使する方法を考えます。

### HTMLを駆使する

処理は全てモデル内で行い，コンポーネント内では何も処理しない方法を考えます。

```diff javascript:Model
export default class Model{
+ public toggleLoading(show) {
+   document.getElementById("loading").style.display = show ? "block" : "none";
+ }
+
  async public get(params) {
+   this.toggleLoading(true);
+   const response = await fetch("http://example.com");
+   this.toggleLoading(false);
+   return response
-   return await fetch("http://example.com");
  }
}
```

```html:HTML
<body>
  <div id="root"></div>
  <div id="loading" style="display: none;">Loading...</div>
</body>
```

上記のような実装をすればモデル内で処理が完結し，コンポーネント内では何もする必要がありません。
上記のモデルを拡張してモデルを作成すればここで一元的に管理が可能です。
ここでは最低限の実装を考えていますが，変数等を工夫すればモデルごとに表示の有無を変えたり，あるいはローディングメッセージも変えたりできますね。

## 最後に

本ページではReact.jsにおけるローディングメッセージの表示方法について考察しました。
もしより良い方法があればコメントを頂けますと幸いです。
どうぞよろしくお願いいたします。
