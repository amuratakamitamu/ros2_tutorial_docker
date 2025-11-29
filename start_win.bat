:: マウント用のディレクトリを作成 (存在しない場合のみ作成)
if not exist Dev mkdir Dev

:: コンテナ起動
docker run -it --rm -p 8080:8080 -v "%cd%\Dev":/Dev --name my-ros2-container ros2-mate-novnc
