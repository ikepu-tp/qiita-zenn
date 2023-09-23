---
title: NPMライブラリの作成方法
tags:
  - npm
  - yarn
  - typescript
  - vite
  - npmjs
private: false
updated_at: null
id: null
organization_url_name: null
slide: false
ignorePublish: false
---

こんにちは。
ご覧いただきありがとうございます。
今回，npmのライブラリを作ってみようと思ったので記録も兼ねて，ライブラリの作り方をまとめます。

## 作ったもの

React.js（に限らないが）をMVCのように使いたいと思い，そのようなライブラリを作ることにしました。

https://github.com/ikepu-tp/react-mvc

https://www.npmjs.com/package/@ikepu-tp/react-mvc

```bash
npm install @ikepu-tp/react-mvc
```

## 環境構築

- 開発環境は`Docker`
- `typescript`で作成
- ビルド等は`Vite`
- フォーマットは`Prettier`

### `docker-compose.yml`を作成

```yaml:docker-compose.yml
version: "3.7"
services:
  app:
    image: node:lts
    working_dir: /usr/src/app
    tty: true
    ports:
      - "3000:3000"
    volumes:
      - ./:/usr/src/app
    stdin_open: true
```

### `package.json`の作成

`npm init`を実行すると，対話形式で`package.json`が作成できる
作成された`package`に以下の内容を追記。（一部省略）

```diff_json:package.json
{
+  "type": "module",
+  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1",
+    "format": "prettier -w \"./src/**/*.{js,css,ts}\"",
+    "build": "yarn format && vite build && tsc"
+  },
+  "files": [
+    "dist",
+    "types"
+  ],
+  "exports": {
+    ".":{
+      "require": "./dist/index.cjs.js",
+      "import": "./dist/index.es.js",
+      "types":"./types/index.d.ts"
+    },
+  },
}
```

### ライブラリのインストール

```bash
yarn add -D typescript vite prettier
```

### `tsconfig.json`の作成

`typescript`を使うので`tsconfig.json`を作成。

```json:tsconfig.json
{
  "compilerOptions": {
    "noImplicitReturns": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "baseUrl": ".",
    "target": "es6",
    "lib": ["dom", "dom.iterable", "esnext"],
    "allowJs": true,
    "skipLibCheck": true,
    "esModuleInterop": true,
    "allowSyntheticDefaultImports": true,
    "strict": true,
    "forceConsistentCasingInFileNames": true,
    "noFallthroughCasesInSwitch": true,
    "module": "esnext",
    "moduleResolution": "node",
    "resolveJsonModule": true,
    "isolatedModules": true,
    "emitDeclarationOnly": true,
    "declaration": true,
    "declarationDir": "./types"
  },
  "include": ["src"],
  "exclude": [],
  "references": []
}
```

### `vite.config.js`の作成

Viteでビルドをするので作成。

```js:vite.config.jsimport { resolve } from 'path';
import { defineConfig } from 'vite';

export default defineConfig({
  build: {
    lib: {
      entry: {
        "": resolve(__dirname, "src/index.ts"),
      },
      name: 'index',
      fileName: (format, entryName) => {
        return `${entryName ? `${entryName}/` : ""}index.${format}.js`;
      },
      formats: ["cjs", "es"],
    },
      ollupOptions: {
      output: {
        sourcemap: true
      }
    }
  },
});
```

`build.lib`でライブラリモードになるようです。
`build.lib.entry`でビルドするファイルを指定します。
`build.lib.fileName`で出力先を設定できます。

:::note info
`build.lib.fileName`は文字列で指定もできますが，ディレクトリを分けること等ができません。
そのため，上記の例では関数を使ってディレクトリを分けるようにしています。
:::

## NPMJSでの公開

### 1. NPMJSのアカウント作成

[https://www.npmjs.com/](https://www.npmjs.com/)にアクセスし，アカウントを作成してください。

https://www.npmjs.com/

### 2. `npm`でログイン

`npm login`を実行し，指示に従ってログインしてください。

### 3. ライブラリの公開

`npm publish --access=public`でNPMJSに公開されます。

## 参考

https://zenn.dev/s_takashi/articles/20ecebd0a42010

https://zenn.dev/k0kishima/articles/d75f4dc5bd1a26

https://ja.vitejs.dev/guide/build.html#%E3%83%A9%E3%82%A4%E3%83%95%E3%82%99%E3%83%A9%E3%83%AA%E3%83%A2%E3%83%BC%E3%83%88%E3%82%99
