---
title: 簡単なレジシステムを開発してみた
tags:
  - Laravel
  - SSE
  - React
private: false
updated_at: '2023-10-11T10:03:59+09:00'
id: 6fd3e09000a3a6b8ac0b
organization_url_name: null
slide: false
ignorePublish: false
---

こんにちは，ご覧いただきありがとうございます。
来月，うちの大学で学祭があるのですが，その際に出店される方からレジシステムの開発をお願い？されました。
時間があまりなかったので簡単なものになりましたが，一応リリースにこぎつけたのでよければ使ってください！！

https://github.com/ikepu-tp/unifestill

Qiitaでの投稿なので一応，技術的なお話もしましょう。

## 使用技術

- Laravel 10
- React.js 18
- MySQL(MariaDB)

毎度同じの使い慣れた子たちです。
ちなみにReact.jsにおいて，Atomicの考え方になかなか馴染めず，結果的にMVC的にしました。

## 要望

- レンタルサーバで動く
- iPad等のタブレットでも利用しやすい
- オーダー画面がある（注文を受けたら注文内容が別の画面に表示される）
- 既存システムでもいいが，機能が多いし，お金を払ってまで使いたいわけではない

要望は特になかったのでざっくりとこんなものでした。
3つ目のオーダー画面はちょっとあれですが…

## システム名

システム名も勝手に決めればいい感じだったのでChatGPTにお世話になりました。
最終的に「大学"University"＋祭り"Festival"＋レジ"TilL"」を組み合わせて"UniFesTill"となりました。
ロゴはCanvaで適当に作りました。
これぞ，ザ・適当ですね。

## 機能

- ユーザー管理
- プロジェクト管理
- メンバー管理
- 支払方法管理
- 商品カテゴリー管理
- 商品管理
- 会計管理
- レジ打ち
- オーダー管理

それぞれの機能について簡単に説明します。

### ユーザー管理

ユーザーの作成，ログイン等の通常の機能です。
お馴染みのLaravel Breezeで実装しています。
毎回なのですが，フロントはBootstrapベースで作成するのでプロフィール画面をどうするか問題があるんですよね。
今回はそのまま`tailwindcss`を使用しました。
Bootstrapとスタイルが競合するところは上書きしてやりました。（強引）
ただ，今回は時間がなかったため，個人でアカウント作成し，団体に紐づけ，という方法ではなく，団体で1アカウントを作成し，それの共有という形にしました。

### プロジェクト管理

今回は学祭での利用がメインだったため，プロジェクト管理という方式にしました。
毎回同じメニューなわけでもないので年度ごとにプロジェクトを作成し，管理できたほうがよいかなと思いまして。
（来年以降も複数回使ってくれるかはわかりませんが…）
プロジェクト名と備考を設定するだけのシンプルなものになります。

### メンバー管理

レジ打ちをするときに担当者を選択するためのメンバー管理です。
特に担当者選択の必要性がなければ適当に1つ登録し，それで登録すればいいですね。

### 支払方法管理

支払方法（現金や前売り券等）と備考を設定するだけのシンプルなものです。
レジ打ちの際に使用します。

### 商品カテゴリー管理

商品のカテゴリーと備考を設定するだけのシンプルなものです。
当初は商品をカテゴリー別に表示しようと思って作ったものだったのですが，結局時間がなくそこまでたどり着けていません(-_-;)
ただの負の遺産です。

### 商品管理

商品を設定するものです。
商品カテゴリーや商品名，金額を設定できます。
当初は親商品，子商品を設定できるようにしようと思ったのですが，これも時間がなくたどり着けていません。

:::note info
親商品と子商品という言い方が正しいかはわかりませんが，例えば親商品「セットメニュー」を注文すると子商品「ドリンク」を選択するといった感じです。
:::

### 会計管理

会計を管理するシンプルなものです。
会計内容の表示や削除ができます。
削除後の会計内容の表示や会計レポートの出力もしたいのですが，これも時間がなく取り組めていません。
特にレポートは絶対いりますよね。

### レジ打ち

レジ打ちをする機能です。
UniFesTillのメインですね！（笑）
基本的には普通のレジだと思います。
工夫した点はiPad等のタブレットでも操作しやすいようにソフトウェアテンキーを作っているところでしょうか。
今回は工数削減のためにパーツの使いまわしをかなりしていますが，できれば，特にレジ打ちの画面はUIもこだわりたいですね。

### オーダー管理

個人的には一番推しの機能になります。
レジ打ちをすると，オーダー画面に注文内容が表示されます。
こんな感じです。
「注文済み」や「準備中」，「完了・引き渡し済み」を押せば状態の変更ができます。

![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/1089552/e529a216-e3d6-15ca-9d66-528e2849c982.png)

レンタルサーバの利用なため，WebSocketを使えません。
そのため，今回はSSEを利用し，リアルタイムチックな通信を実現しています。

https://developer.mozilla.org/ja/docs/Web/API/Server-sent_events/Using_server-sent_events

## とりあえず作り終えての感想

時間がない中とりあえずリリースするとこまでいけた自分を褒めたいですね。（笑）
そうはいっても気に入らないところ等はたくさんあるのでこれからもつついていきたいと思っています。
皆さんもぜひ利用してください！また，プルリクもお待ちしています！！
