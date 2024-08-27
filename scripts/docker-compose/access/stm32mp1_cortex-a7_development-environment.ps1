try {
  . $PSScriptRoot/../__config.ps1  # composeProjectName setting

  docker-compose `
    -p "${global:composeProjectName}" `
    -f ./docker-compose/compose.yml `
    exec stm32mp1_cortex-a7_development-environment /bin/bash
} catch {
    echo "Error: $_"
    exit 1
}
