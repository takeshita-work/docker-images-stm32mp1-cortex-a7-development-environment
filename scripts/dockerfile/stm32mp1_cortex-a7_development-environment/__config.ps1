${global:softwareName} = "stm32mp1_cortex-a7_development-environment"
$global:version        = "latest"

if (-not $global:softwareName) {
    Throw "'softwareName' is not set."
}
if (-not $global:version) {
    Throw "'version' is not set."
}
