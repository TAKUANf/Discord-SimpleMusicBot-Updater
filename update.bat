@echo off
chcp 65001 > nul

:: --- 設定 ---
set "REPO_DIR=Discord-SimpleMusicBot"

:: --- リポジトリに移動 ---
cd /d "%REPO_DIR%"
if errorlevel 1 (
    echo エラー: '%REPO_DIR%' ディレクトリに移動できませんでした。
    echo update.bat と同じディレクトリでこのスクリプトを実行していること、
    echo およびリポジトリがクローンされていることを確認してください。
    pause
    exit /b 1
)

:: --- 1. 最新情報を取得 ---
echo リポジトリから最新の変更を取得しています...
git fetch --tags
if errorlevel 1 (
    echo エラー: git fetch --tags に失敗しました。インターネット接続と Git の設定を確認してください。
    pause
    exit /b 1
)

:: --- 2. 更新するかどうか確認 ---
set /p "CONFIRM=ボットを更新しますか？ (y/n): "
if /i not "%CONFIRM%"=="y" (
    echo 更新をキャンセルしました。
    pause
    exit /b 0
)

:: --- 3. 最新リリースを取得 ---
echo 最新リリースに更新しています...

:: 最新のタグを取得
FOR /F "tokens=*" %%a IN ('git tag --sort=-version:refname') DO (
  SET "LATEST_TAG=%%a"
  goto :tag_found
)
:tag_found

if "%LATEST_TAG%"=="" (
    echo エラー: タグが見つかりませんでした。リポジトリにリリースが存在することを確認してください。
    pause
    exit /b 1
)

echo 最新リリース: %LATEST_TAG%
git reset --hard "%LATEST_TAG%"

if errorlevel 1 (
    echo エラー: git reset に失敗しました。
    pause
    exit /b 1
)

:: --- 4. 依存関係の更新 ---
echo 依存関係を更新しています...
call npm install 
if errorlevel 1 (
    echo エラー: npm install に失敗しました。
    pause
    exit /b 1
)

:: --- 5. トランスパイル ---
echo トランスパイルしています...
call npm run build
if errorlevel 1 (
    echo エラー: npm run build に失敗しました。代替手段として 'npm run build:bundled' を試すことができます。
    pause
    exit /b 1
)

:: --- 6. 完了 ---
echo.
echo ==================================
echo 更新が完了しました！
echo ==================================
echo 何かキーを押すと終了します。
pause > nul
cmd /k
