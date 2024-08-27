$global:repositoryName = "takeshitawork/stm32mp1_cortex-a7_development-environment" #  "organization/repository" or "repository"
$global:date           = Get-Date -UFormat "%Y%m"


if (-not $global:repositoryName) {
    Throw "'repositoryName' is not set."
}
