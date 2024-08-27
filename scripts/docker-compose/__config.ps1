$global:composeProjectName = "takeshitawork_stm32mp1_cortex-a7_development-environment"


if (-not $global:composeProjectName) {
    Throw "'composeProjectName' is not set."
}
