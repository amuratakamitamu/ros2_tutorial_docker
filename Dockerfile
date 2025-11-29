# ベースイメージ: ROS 2 Humble Desktop Full (Ubuntu 22.04ベース)
FROM osrf/ros:humble-desktop-full

# 対話モードを防止
ENV DEBIAN_FRONTEND=noninteractive
ENV USER=root

# パッケージのインストール
# - MATEデスクトップ (軽量版)
# - TigerVNC (VNCサーバー)
# - noVNC & websockify (ブラウザ用クライアント)
RUN apt-get update && apt-get install -y \
    mate-desktop-environment-core \
    mate-terminal \
    tigervnc-standalone-server \
    tigervnc-common \
    novnc \
    websockify \
    net-tools \
    curl \
    && rm -rf /var/lib/apt/lists/*

# noVNCのデフォルトページを設定
RUN ln -s /usr/share/novnc/vnc.html /usr/share/novnc/index.html

# 作業用ディレクトリ(Dev)の作成
WORKDIR /Dev

# コンテナログイン時にROS 2環境を自動読み込み
RUN echo "source /opt/ros/humble/setup.bash" >> /root/.bashrc

# 起動スクリプトの作成
# VNCサーバーとnoVNCを起動し、MATEセッションを開始します
RUN echo '#!/bin/bash\n\
export DISPLAY=:1\n\
rm -rf /tmp/.X11-unix /tmp/.X1-lock\n\
# VNCサーバー起動 (パスワードなし、セキュリティタイプなし)\n\
vncserver :1 -geometry 1280x800 -depth 24 -SecurityTypes None -xstartup /usr/bin/mate-session\n\
# noVNC起動 (ポート8080)\n\
/usr/share/novnc/utils/launch.sh --vnc localhost:5901 --listen 8080 --sh-command "bash"\n\
' > /start.sh && chmod +x /start.sh

# ポート公開 (Web用: 8080, VNC用: 5901)
EXPOSE 8080 5901

# コンテナ起動時のコマンド
CMD ["/start.sh"]
