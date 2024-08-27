try {
    . $PSScriptRoot/../__config.ps1  # composeProjectName setting

    # 引数を取得
    $command = $args -join " "
    if (-not $command) {
      Throw "'command' is not set."
    }

    docker-compose `
        -p "${global:composeProjectName}" `
        -f ./docker-compose/compose.yml `
        exec stm32mp1_cortex-a7_development-environment /bin/bash -c "$command"
} catch {
    echo "Error: $_"
    exit 1
}
