
# Copyright 2025 Keita Sekiguchi
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# マウント用のディレクトリを作成
mkdir -p Dev

# コンテナ起動
docker run -it --rm -p 8080:8080 -v $(pwd)/Dev:/Dev --name my-ros2-container ros2-mate-novnc
