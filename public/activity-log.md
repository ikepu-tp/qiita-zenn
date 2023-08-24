---
title: Laravel用アクティビティログライブラリを作りました！！
tags:
  - Laravel
private: false
updated_at: '2023-08-24T22:16:19+09:00'
id: 47228f97d056fe05fbd9
organization_url_name: null
slide: false
---

こんにちは，ご覧いただきありがとうございます。

Laravel用のアクティビティログライブラリを作成しました。

https://github.com/ikepu-tp/laravel-activity-log

## 機能

- ユーザーのアクティビティを記録
- ログイン中ユーザーのアクティビティを表示

## インストール

### 1.composerでインストール

```bash
composer require ikepu-tp/laravel-activity-log
```

### 2.設定ファイルの設定

```bash
php artisan vendor:publish --tag=ActivityLog-config
```

### 3.マイグレーション

```bash
php artisan migrate
```

### 4.ミドルウェアを追加

```diff_php:app\Http\Kernel
    protected $middleware = [
        // \App\Http\Middleware\TrustHosts::class,
        \App\Http\Middleware\TrustProxies::class,
        \Illuminate\Http\Middleware\HandleCors::class,
        \App\Http\Middleware\PreventRequestsDuringMaintenance::class,
        \Illuminate\Foundation\Http\Middleware\ValidatePostSize::class,
        \App\Http\Middleware\TrimStrings::class,
        \Illuminate\Foundation\Http\Middleware\ConvertEmptyStringsToNull::class,
+       \ikepu_tp\ActivityLog\app\Http\Middleware\ActivityLogMiddleware::class,
    ];
```

これでインストールは終了です。
[http://localhost/activity-log](http://localhost/activity-log)にアクセスしてみてください。
あなたのアクティビティが表示されていると思います。

:::note info
もし`/activity-log`を変更したい場合，ルーティングを変更してください。

```php:/route/activity-log.php
Route::group([
    "middleware" => "auth"
], function () {
    Route::get("activity-log", [ActivityLogController::class, "index"])->name("activity-log.index");
                // ↑ここを変更してください。
});
```

:::

### 5. アクティビティの登録

設定ファイル(`/config/activity-log.php`)の`activities`を編集し，アクティビティを設定してください。

## 今後の更新予定

とりあえず公開したという感じなので今後も機能追加していきたいと思います。
よければGithubのスターやフォローをお願いします！
もちろん，プルリクもお待ちしています！！
