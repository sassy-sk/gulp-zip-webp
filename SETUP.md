# 新しいPCへのセットアップ手順

gitでクローン後、以下の手順を順番に実施してください。

---

## 1. npm パッケージのインストール

```bash
cd _gulp
npm i
```

---

## 2. スクリプトに実行権限を付与

プロジェクトのルートディレクトリで実行してください。

```bash
chmod +x webp-convert.sh
chmod +x zip-convert.sh
```

---

## 3. エイリアスを設定

`~/.zshrc` に以下を追記してください。
※ パスはクローンした場所に合わせて変更してください。

```bash
# WebP変換スクリプトのエイリアス
alias webp-convert="<クローン先のパス>/webp-convert.sh"

# ZIP変換スクリプトのエイリアス
alias zip-convert="<クローン先のパス>/zip-convert.sh"
```

**例（デスクトップにクローンした場合）:**
```bash
alias webp-convert="/Users/<ユーザー名>/Desktop/app/gulp-zip-webp/webp-convert.sh"
alias zip-convert="/Users/<ユーザー名>/Desktop/app/gulp-zip-webp/zip-convert.sh"
```

追記後、設定を反映します：
```bash
source ~/.zshrc
```

---

## 4. 動作確認

```bash
# WebP変換（ファイル指定）
webp-convert ~/Downloads/sample.png

# WebP変換（フォルダ指定）
webp-convert ~/Downloads/sample-folder/

# ZIP変換（フォルダ指定）
zip-convert ~/Downloads/sample-folder/
```

---

## 各スクリプトの概要

| スクリプト | 入力 | 出力先 |
|---|---|---|
| `webp-convert` | 画像ファイル or フォルダ（.png/.jpg/.jpeg） | 入力と同じフォルダ内の `dist-images/` |
| `zip-convert` | フォルダ | `~/Downloads/` にzipファイル |
