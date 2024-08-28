# Copyright © 2023 Mohamed El Morabity
# Copyright © 2024 Ophios GmbH
# SPDX-License-Identifier: GPL-3.0-or-later

[CmdletBinding()]
Param(
    # Analyze options
    [Parameter(Mandatory = $true, ParameterSetName = 'Check', Position = 0)]
    [Switch]$Check,
    [Parameter(ParameterSetName = 'Check')]
    [String[]]$CustomRulePath,
    [Parameter(ParameterSetName = 'Check')]
    [String[]]$ExcludeRule,
    [Parameter(ParameterSetName = 'Check')]
    [Switch]$Fix,
    [Parameter(ParameterSetName = 'Check')]
    [Switch]$IncludeDefaultRules,
    [Parameter(ParameterSetName = 'Check')]
    [String[]]$IncludeRule,
    [Parameter(ParameterSetName = 'Check')]
    [Switch]$IncludeSuppressed,
    [Parameter(ParameterSetName = 'Check')]
    [Switch]$RecurseCustomRulePath,
    [Parameter(ParameterSetName = 'Check')]
    [Switch]$SaveDscDependency,
    [Parameter(ParameterSetName = 'Check')]
    [String[]]$Severity,
    # Format options
    [Parameter(Mandatory = $true, ParameterSetName = 'Format', Position = 0)]
    [Switch]$Format,
    [Parameter(ParameterSetName = 'Format')]
    [Int32[]]$Range,
    # Common options
    [Parameter(Mandatory = $true, ValueFromRemainingArguments = $true)]
    [String[]]$Path,
    [Parameter()]
    [String]$Settings
)

if ([Environment]::GetEnvironmentVariable('PRE_COMMIT_PWSH_VERBOSE')) {
    $VerbosePreference = 'Continue'
}
$ErrorActionPreference = 'Stop'

Set-StrictMode -Version Latest

# Install PSScriptAnalyzer if not available
if (-not (Get-InstalledModule PSScriptAnalyzer -ErrorAction SilentlyContinue)) {
    Install-Module -Name PSScriptAnalyzer -Scope CurrentUser -Force -AllowClobber
}

[void]$PSBoundParameters.Remove($PsCmdlet.ParameterSetName)
[void]$PSBoundParameters.Remove('Path')

switch ($PsCmdlet.ParameterSetName) {
    'Check' {
        $Path | Invoke-ScriptAnalyzer -EnableExit @PSBoundParameters
    }
    'Format' {
        $Path | ForEach-Object {
            $content = (Get-Content -Raw -Path $_).Trim()
            Invoke-Formatter -ScriptDefinition $content @PSBoundParameters | Out-File -FilePath $_
        }
    }
}
