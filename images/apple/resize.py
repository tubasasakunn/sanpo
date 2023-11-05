from PIL import Image
import os

# 定数の定義
WIDTH = 1242
HEIGHT = 2208
OUTPUT_DIR = "55inch"

#WIDTH = 1284
#HEIGHT = 2778
#OUTPUT_DIR = "65inch"

def resize_images(directory):
    # 出力ディレクトリが存在しない場合は作成
    if not os.path.exists(OUTPUT_DIR):
        os.makedirs(OUTPUT_DIR)

    # ディレクトリ内のファイルを取得
    for filename in os.listdir(directory):
        filepath = os.path.join(directory, filename)

        # ファイルが画像の場合
        if filepath.lower().endswith(('.png', '.jpg', '.jpeg')):
            with Image.open(filepath) as img:
                # 画像のリサイズ
                img_resized = img.resize((WIDTH, HEIGHT))
                # 保存先のパスを設定
                save_path = os.path.join(OUTPUT_DIR, filename)
                img_resized.save(save_path)
                print(f"Resized and saved {filename} to {OUTPUT_DIR}")

if __name__ == "__main__":
    # 現在のディレクトリ内の画像をリサイズ
    resize_images(".")


