# マウント用のディレクトリを作成
mkdir -p Dev

# コンテナ起動
docker run -it --rm \
  -p 8080:8080 \
  -v $(pwd)/Dev:/Dev \
  --name my-ros2-container \
  ros2-mate-novnc
