---
title: "Laraveファイルライブラリをアップデートしました！！"
tags:
  - "Laravel"
  - "OSS"
  - "Composer"
  - "Library"
private: false
updated_at: ''
id: null
organization_url_name: null
slide: false
ignorePublish: false
---
## はじめに

こんにちは，ご覧いただきありがとうございます。
前回，Laravel用のファイルライブラリを作成しました。

https://qiita.com/ikepu-tp/items/69c445a4de47f52ce6d7

前回提示していた目標は以下のとおりでした。

1. 機能感はWordPressのメディアライブラリに近い
2. 特に設定をしなくても使える
   1. アップロードしたファイルの一覧等をデフォルトで表示できる
   2. ファイルのアップロードフォームをデフォルトで使用できる
3. ファイルのアップロードや情報の取得，編集をAPIを通じて行うことができる
4. ファイルのアップロードや情報の取得，編集をインスタンスで行うことができる

これらのうち，1，2の目標を達成しています。
そこで今回は残りの2つの目標を達成するためにアップデートを行いました。

## アップデート内容

- API対応
- ファイルのアップロード処理のインスタンス化
- ダウンロードリンクの追加

の3点です。

### API対応

API対応について，以下のリソースでAPIを利用することができます。

```json:API Resource
{
  "fileId": "string",
  "name": "string",
  "url": "string",
  "mime_type": "string",
  "created_at": "string",
  "updated_at": "string"
}
```

### ファイルのアップロード処理のインスタンス化

ファイルのアップロード処理のインスタンス化については，以下のように使用できます。

```php:UploadFileController
class FileController extends Controller
{
    public function store(Request $request)
    {
        $guard = config("file-library.guard");
        $files = \ikepu_tp\FileLibrary\app\Services\FileLibraryService::upload(
            $guard, 
            $request->file("files", []), 
            $request->input("names", [])
        );

        return back()->with("status", "File uploaded.");
    }
}
```

### ダウンロードリンクの追加

ダウンロードリンクは`http://your-project.com/file/lib/{fileId}/download`となっています。

## 最後に

これで当初の目標を達成することができました。
加えて，リスト表示やまとめて処理の機能を付与することもいいかもしれないと考えております。
ぜひ皆様のご意見をお聞かせいただければと思います。
