#!/bin/bash
# WebP変換スクリプト
# 使い方: ./webp-convert.sh <画像パス1> [画像パス2] ...
#         ./webp-convert.sh <ディレクトリパス>
# 例: ./webp-convert.sh ~/Downloads/chif-img/matsuda-san.png ~/Downloads/chif-img/kikuchi-san.png
#     ./webp-convert.sh ~/Downloads/chif-img/

set -e

# シンボリックリンク経由で実行された場合も実際のスクリプトのディレクトリを取得
SELF="$0"
if [ -L "$SELF" ]; then
  SELF="$(readlink "$SELF")"
fi
GULP_DIR="$(cd "$(dirname "$SELF")" && pwd)"
IMAGES_DIR="$GULP_DIR/images"
DIST_DIR="$GULP_DIR/dist-images"

# 引数チェック
if [ $# -eq 0 ]; then
  echo "エラー: 画像ファイルまたはディレクトリを指定してください"
  echo "使い方: $0 <画像パス1> [画像パス2] ..."
  echo "        $0 <ディレクトリパス>"
  exit 1
fi

# ディレクトリが指定された場合、中の画像ファイルを収集
FILES=()
if [ $# -eq 1 ] && [ -d "$1" ]; then
  SOURCE_DIR="$(realpath "$1")"
  echo "ディレクトリ指定: $SOURCE_DIR"
  while IFS= read -r -d '' FILE; do
    FILES+=("$FILE")
  done < <(find "$SOURCE_DIR" -maxdepth 1 -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" \) -print0 | sort -z)

  if [ ${#FILES[@]} -eq 0 ]; then
    echo "エラー: 対象の画像ファイル（.png/.jpg/.jpeg）が見つかりません: $SOURCE_DIR"
    exit 1
  fi
  echo "対象ファイル数: ${#FILES[@]}"
else
  # ファイルが直接指定された場合
  for FILE in "$@"; do
    if [ ! -f "$FILE" ]; then
      echo "エラー: ファイルが見つかりません: $FILE"
      exit 1
    fi
    FILES+=("$(realpath "$FILE")")
  done
  SOURCE_DIR=$(dirname "${FILES[0]}")
fi

echo "元ディレクトリ: $SOURCE_DIR"

# imagesディレクトリをクリーン
echo "imagesディレクトリをクリア中..."
rm -f "$IMAGES_DIR"/*

# 画像をimagesディレクトリにコピー
echo "画像をコピー中..."
for FILE in "${FILES[@]}"; do
  cp "$FILE" "$IMAGES_DIR/"
  echo "  コピー: $(basename "$FILE")"
done

# gulp webp を実行
echo "gulp webp を実行中..."
cd "$GULP_DIR/_gulp"
npx gulp webp

# dist-imagesの存在確認
if [ ! -d "$DIST_DIR" ]; then
  echo "エラー: dist-images ディレクトリが見つかりません: $DIST_DIR"
  exit 1
fi

# dist-imagesフォルダごと元ディレクトリにコピー
echo "dist-imagesフォルダを元ディレクトリにコピー中..."
rm -rf "$SOURCE_DIR/dist-images"
cp -r "$DIST_DIR" "$SOURCE_DIR/dist-images"
echo "  コピー: dist-images → $SOURCE_DIR/dist-images"

# imagesディレクトリの画像を削除
echo "imagesディレクトリをクリア中..."
rm -f "$IMAGES_DIR"/*

echo "完了！dist-imagesフォルダは $SOURCE_DIR/dist-images に保存されました。"
