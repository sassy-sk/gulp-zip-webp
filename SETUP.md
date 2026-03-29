# 新しいPCへのセットアップ手順

gitでクローン後、以下の手順を順番に実施してください。

---

## 1. npm パッケージのインストール

プロジェクトのルートディレクトリで実行してください。

```bash
cd _gulp
npm i
cd ..
```

---

## 2. スクリプトに実行権限を付与

プロジェクトのルートディレクトリで実行してください。

```bash
chmod +x webp-convert.sh
chmod +x zip-convert.sh
```

---

## 3. シンボリックリンクを作成

クローンした場所のパスに合わせて実行してください。

```bash
ln -sf /Users/<ユーザー名>/<クローン先のパス>/webp-convert.sh /usr/local/bin/webp-convert
ln -sf /Users/<ユーザー名>/<クローン先のパス>/zip-convert.sh /usr/local/bin/zip-convert
```

**例（デスクトップの `app` フォルダにクローンした場合）:**
```bash
ln -sf /Users/<ユーザー名>/Desktop/app/gulp-zip-webp/webp-convert.sh /usr/local/bin/webp-convert
ln -sf /Users/<ユーザー名>/Desktop/app/gulp-zip-webp/zip-convert.sh /usr/local/bin/zip-convert
```

ユーザー名は以下で確認できます：
```bash
whoami
```

---

## 4. 動作確認

```bash
which webp-convert
which zip-convert
```

それぞれ `/usr/local/bin/webp-convert`、`/usr/local/bin/zip-convert` と表示されれば成功です。

---

## 各スクリプトの使い方

```bash
# WebP変換（ファイル指定）
webp-convert ~/Downloads/sample.png

# WebP変換（フォルダ指定）
webp-convert ~/Downloads/sample-folder/

# ZIP変換（フォルダ指定）
zip-convert ~/Downloads/sample-folder/
```

| スクリプト | 入力 | 出力先 |
|---|---|---|
| `webp-convert` | 画像ファイル or フォルダ（.png/.jpg/.jpeg） | 入力と同じフォルダ内の `dist-images/` |
| `zip-convert` | フォルダ | `~/Downloads/` にzipファイル |
