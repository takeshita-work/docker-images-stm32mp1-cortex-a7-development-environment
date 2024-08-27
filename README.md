# docker-images_stm32mp1_cortex-a7_development-environment

- [STM32MP157D-DK1](https://www.st.com/en/evaluation-tools/stm32mp157d-dk1.html) の開発を行う Ubuntu環境
    - STM32MP157D-DK1 の cortex-a7 で動作させる C, C++ のSDK, コンパイルツール が導入される
    - STM32MP157D-DK1 のcortex-a7 は OS (OpenSTLinux) をカスタマイズ ができる環境

## Ubuntu環境 の構築について
- 公式のドキュメントを参考に構築
    - [st.com - wiki - STM32MP157x-DK2](https://wiki.st.com/stm32mpu/wiki/Getting_started/STM32MP1_boards/STM32MP157x-DK2)
        - [st.com - wiki - PC prerequisites](https://wiki.st.com/stm32mpu/wiki/PC_prerequisites) 開発を行うホストPC の要件、ソフトウェアについて
        - [st.com - wiki - STM32MP157x-DK2 - Install the SDK](https://wiki.st.com/stm32mpu/wiki/Getting_started/STM32MP1_boards/STM32MP157x-DK2/Develop_on_Arm%C2%AE_Cortex%C2%AE-A7/Install_the_SDK) に記載のある環境を構築している


## ビルド

```
.
|-- dockerfile
|   `-- stm32mp1_cortex-a7_development-environment
|       |-- Dockerfile
|       `-- en.SDK-x86_64-stm32mp1-openstlinux-6.1-yocto-mickledore-mpu-v24.06.26.tar.gz
|-- scripts
|   `-- dockerfile
|       |-- stm32mp1_cortex-a7_development-environment
|       |   |-- build.ps1
|       |   |-- push.ps1
|       |   `-- __config.ps1
|       `-- __config.ps1
```

1. dockerfile/stm32mp1_cortex-a7_development-environment 以下に tar.gz を追加
    - en.SDK-x86_64-stm32mp1-openstlinux-6.1-yocto-mickledore-mpu-v24.06.26.tar.gz をダウンロードして設置する
        - [STM32MP1 OpenSTLinux Developer Package](https://www.st.com/en/embedded-software/stm32mp1dev.html)
            - `MP1-DEV-x86` をダウンロード
            - en.sdk-x86_64-stm32mp1-openstlinux-6.1-yocto-mickledore-mpu-v24.06.26.tar.gz
            - SDK や ツールのソースなど

1. scripts/dockerfile/stm32mp1_cortex-a7_development-environment/build.ps1 を実行

# docker-images_template

- Docker イメージ を作成するときのテンプレート

[Docker Hub](https://hub.docker.com/explore)

## 開発について

```
docker-images_template
|-- docker-compose
|   `-- compose.yml                     ... 作成した docker image をコンテナ
|-- dockerfile
|   `-- {software}
|       |-- {version}
|       |   `-- Dockerfile              ... Dockerfile: {software}{version} で管理する場合
|       `-- Dockerfile                  ... Dockerfile: {software} で管理する場合
|-- scripts
|   |-- docker-compose
|   |   |-- access
|   |   |   `-- {software}{version}.ps1 ... docker/compose.yml に定義したコンテナにアクセス
|   |   |-- __config.ps1
|   |   |-- down.ps1                    ... docker/compose.yml に定義したコンテナを削除
|   |   |-- start.ps1                   ... docker/compose.yml に定義したコンテナを起動
|   |   `-- stop.ps1                    ... docker/compose.yml に定義したコンテナを停止
|   `-- dockerfile
|       |-- {software}
|       |   |-- {version}
|       |   |   |-- build.ps1           ... Dockerfile: {software}{version} をビルド
|       |   |   |-- push.ps1            ... Dockerfile: {software}{version} のイメージを docDocker Hub にプッシュ
|       |   |   `-- __config.ps1
|       |   |-- build.ps1               ... Dockerfile: {software} をビルド
|       |   |-- push.ps1                ... Dockerfile: {software} のイメージを docDocker Hub にプッシュ
|       |   `-- __config.ps1
|       `-- __config.ps1
`-- README.md
```

### docker イメージ

ディレクトリ名, ファイル名, ファイル内の `{software}`, `{version}` を適切に変更する

#### リポジトリ名の 設定

- docker イメージ の名称の設定

    ./scripts/dockerfile/__config.ps1 で行う

    - Docker Hub に プッシュする場合
        ```
        $global:repositoryName = "organization/repository"
        ```
        ※ 設定したものが Docker Hub のリポジトリ名になる

    - ローカルのみで利用する場合
        ```
        $global:repositoryName = "repository"
        ```

#### Dockerfile の定義

- ソフトウェアとバージョンごとで管理する場合
    - Dockerfile の定義
        - dockerfile/{software}/{version}/Dockerfile に定義する

    - 設定
        - scripts/dockerfile/{software}/__config.ps1 に ソフトウェア名を定義する
        - scripts/dockerfile/{software}/{version}/__config.ps1 に バージョンを定義する

- ソフトウェアごとで管理する場合
    - Dockerfile の定義
        - dockerfile/{software}/Dockerfile に定義する

    - 設定
        - scripts/dockerfile/{software}/__config.ps1 に ソフトウェア名を定義する

#### 操作

- ソフトウェアとバージョンごとで管理する場合
    - ビルド
        ```
        ./scripts/dockerfile/{software}/{version}/build.ps1
        ```

        ローカルに docker イメージ がビルドされる
        - イメージ名は `リポジトリ名` になる
        - タグは、`{software}{version}`, `{software}{version}_yyyymm` になる. タグを変更修正する場合は ps1 ファイルを修正.

    - プッシュ
        ```
        ./scripts/dockerfile/{software}/{version}/push.ps1
        ```

        ローカルの docker イメージ が Docker Hub にプッシュされる
        - イメージ名は `リポジトリ名` になる
        - タグは、`{software}{version}`, `{software}{version}_yyyymm` になる. タグを変更修正する場合は ps1 ファイルを修正.

- ソフトウェアごとで管理する場合
    - ビルド
        ```
        ./scripts/dockerfile/{software}/build.ps1
        ```

        ローカルに docker イメージ がビルドされる
        - イメージ名は `リポジトリ名` になる
        - タグは、`{software}`, `{software}_yyyymm` になる. タグを変更修正する場合は ps1 ファイルを修正.

    - プッシュ
        ```
        ./scripts/dockerfile/{software}/push.ps1
        ```

        ローカルの docker イメージ が Docker Hub にプッシュされる
        - イメージ名は `リポジトリ名` になる
        - タグは、`{software}`, `{software}_yyyymm` になる. タグを変更修正する場合は ps1 ファイルを修正.

### コンテナでのテスト

#### 設定

- コンテナプロジェクト の名称の設定

    ./scripts/docker-compose/__config.ps1 で行う
    ```
    $global:composeProjectName = ""
    ```

#### テストの実施

1. `./docker-compose/compose.yml` にテスト対象のコンテナを定義
    ```
    services:
      container-name_software-version:
        image: repository:software-version
    ```
    - ローカルにビルドされた docker イメージ を指定する

1. コンテナ の起動
    ```
    ./scripts/docker-compose/start.ps1
    ```

    - `./docker-compose/compose.yml` に定義したすべてのコンテナが起動

1. 動作を確認する

    - コンテナに接続して動作を確認する

        ```
        ./scripts/docker-compose/access/{software}{version}.ps1
        ```

1. コンテナを停止する
    ```
    ./scripts/docker-compose/stop.ps1
    ```

1. コンテナを削除する
    ```
    ./scripts/docker-compose/down.ps1
    ```
