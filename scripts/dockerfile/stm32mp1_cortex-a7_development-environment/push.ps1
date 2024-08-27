try {
    # 設定ファイルの読み込み
    . $PSScriptRoot/../__config.ps1  # repository setting
    . $PSScriptRoot/__config.ps1     # version setting

    # タグ の生成
    $imageTagLatest = "${global:repositoryName}:${global:version}"
    $imageTagDate   = "${global:repositoryName}:${global:version}_${global:date}"

    # 生成値の出力
    echo $imageTagLatest
    echo $imageTagDate

    # プッシュの実行
    docker push $imageTagLatest
    docker push $imageTagDate
} catch {
    echo "Error: $_"
    exit 1
}
