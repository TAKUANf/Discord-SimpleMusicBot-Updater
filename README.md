## Discord-SimpleMusicBot-updater

手動での更新作業を自動化するためのものです！！

**前提条件**

*   `Update.bat` が Discord-SimpleMusicBot のリポジトリクローンと同じディレクトリに配置されていること

**使い方:**

1.  ダウンロードして batを実行するだけ！！　簡単！！

**よくあるエラーと対処法:**

*   **`'REPO_DIR' ディレクトリに移動できませんでした。`**:  `Update.bat` がリポジトリのルートディレクトリにない可能性があります。配置場所を確認してください。
*   **`git fetch --tags に失敗しました。`**: インターネット接続や Git の設定を確認してください。
*   **`npm install に失敗しました。`**: Node.js/npm のインストール、ネットワーク接続を確認してください。
*   **`npm run build に失敗しました。`**:  `npm run build:bundled` を試してみてください。
