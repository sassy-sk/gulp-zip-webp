#!/bin/bash
# ZIP変換スクリプト
# 使い方: ./zip-convert.sh <フォルダパス>
# 例: ./zip-convert.sh ~/Downloads/chif-img/

set -e

GULP_DIR="$(cd "$(dirname "$0")" && pwd)"
ZIP_DIR="$GULP_DIR/zip"
DIST_DIR="$GULP_DIR/dist-zip"
DOWNLOADS_DIR="$HOME/Downloads"

# 引数チェック
if [ $# -eq 0 ]; then
  echo "エラー: フォルダを指定してください"
  echo "使い方: $0 <フォルダパス>"
  exit 1
fi

# ディレクトリの存在確認
SOURCE_DIR="$(realpath "$1")"
if [ ! -d "$SOURCE_DIR" ]; then
  echo "エラー: フォルダが見つかりません: $SOURCE_DIR"
  exit 1
fi

FOLDER_NAME="$(basename "$SOURCE_DIR")"
echo "対象フォルダ: $SOURCE_DIR"
echo "フォルダ名: $FOLDER_NAME"

# zipディレクトリをクリーン
echo "zipディレクトリをクリア中..."
rm -rf "$ZIP_DIR"/*

# 対象フォルダをzipディレクトリにコピー
echo "フォルダをコピー中..."
cp -r "$SOURCE_DIR" "$ZIP_DIR/$FOLDER_NAME"
echo "  コピー: $FOLDER_NAME → $ZIP_DIR"

# gulp zip を実行
echo "gulp zip を実行中..."
cd "$GULP_DIR/_gulp"
npx gulp zip

# dist-zipの存在確認
if [ ! -d "$DIST_DIR" ]; then
  echo "エラー: dist-zip ディレクトリが見つかりません: $DIST_DIR"
  exit 1
fi

# 生成されたzipをダウンロードフォルダにコピー
echo "zipをダウンロードフォルダにコピー中..."
for FILE in "$DIST_DIR"/*.zip; do
  if [ -f "$FILE" ]; then
    cp "$FILE" "$DOWNLOADS_DIR/"
    echo "  コピー: $(basename "$FILE") → $DOWNLOADS_DIR"
  fi
done

# zipディレクトリをクリーン
echo "zipディレクトリをクリア中..."
rm -rf "$ZIP_DIR"/*

echo "完了！ZIPファイルは $DOWNLOADS_DIR に保存されました。"
