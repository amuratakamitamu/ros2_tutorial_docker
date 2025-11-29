### README.md

````markdown
# ROS 2 Humble with Ubuntu MATE & noVNC

Ubuntu 22.04 をベースに、ブラウザからデスクトップ操作が可能な ROS 2 Humble 開発環境です。
軽量な MATE デスクトップ環境と noVNC を採用しており、特別なクライアントソフトなしで GUI アプリケーション（Rviz2やGazeboなど）を実行できます。

## 📦 機能・特徴

* **OS:** Ubuntu 22.04 LTS
* **ROS:** ROS 2 Humble Hawksbill (Desktop Full)
* **Desktop:** MATE Desktop Environment (Core)
* **VNC:** TigerVNC + noVNC (ブラウザアクセス)
* **Mount:** ホスト側のディレクトリをコンテナ内の `/Dev` にマウント可能

## 🚀 使い方

### 1. 準備

プロジェクトのディレクトリ構成は以下を想定しています。

```text
.
├── Dockerfile
├── README.md
└── Dev/          <-- ホスト側の作業用ディレクトリ（自動で作成または手動作成）
````

### 2\. イメージのビルド

`Dockerfile` があるディレクトリで以下のコマンドを実行してください。

```bash
docker build -t ros2-mate-novnc .
```

### 3\. コンテナの起動

以下のコマンドでコンテナを起動します。ホストの `Dev` ディレクトリがコンテナ内の `/Dev` にマウントされます。

```bash
# 作業用ディレクトリがない場合は作成
mkdir -p Dev

# コンテナ起動
docker run -it --rm \
  -p 8080:8080 \
  -v $(pwd)/Dev:/Dev \
  --name my-ros2-container \
  ros2-mate-novnc
```

  * `-p 8080:8080`: ブラウザアクセス用のポートです。
  * `-v $(pwd)/Dev:/Dev`: ホストの `Dev` フォルダをコンテナ内の `/Dev` に同期します。
  * `--rm`: コンテナ停止時に自動的に削除します（データは `Dev` フォルダに残ります）。

### 4\. 接続方法

コンテナ起動後、ブラウザで以下のURLにアクセスしてください。

  * **URL:** [http://localhost:8080](https://www.google.com/search?q=http://localhost:8080)

ページが表示されたら「接続」をクリックしてください（パスワードは設定されていません）。
MATEデスクトップが表示され、ターミナルを開くと `ros2` コマンドがすぐに使用可能です。

## 🛠 開発について

  * **ワークスペース:** `/Dev` ディレクトリを使用してください。ここで作成・保存したファイルはホスト側にも残ります。
  * **ROS環境:** ターミナル起動時に `source /opt/ros/humble/setup.bash` が自動的に読み込まれています。

## ⚠️ 注意点

  * セキュリティ設定（パスワード等）は無効化しています。ローカル開発環境として使用してください。
  * 終了する際は、ターミナルで `Ctrl+C` を押すか、Docker desktop等から停止してください。

<!-- end list -->

```
