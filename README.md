# pre-commit-psscriptanalyzer

![Pre-Commit](https://github.com/ophiosdev/pre-commit-psscriptanalyzer.git/actions/workflows/pre-commit.yml/badge.svg)

This project provides [pre-commit](https://pre-commit.com/) hooks to lint and
format PowerShell code, using the
[PSScriptAnalyzer](https://github.com/PowerShell/PSScriptAnalyzer/) static code
checker.

## Setup

To activate the hooks, add the following lines to the `repos` list in the
project's `.pre-commit-config.yaml` file:

```yaml
---
repos:
  - repo: https://github.com/ophiosdev/pre-commit-psscriptanalyzer.git
    rev: v2.0.0
    hooks:
      # Check PowerShell code
      - id: psscriptanalyzer-check
      # Format PowerShell code
      - id: psscriptanalyzer-format
```

These hooks require [PowerShell](https://learn.microsoft.com/powershell/scripting/install/installing-powershell) to run.

Alternatively use this to run the hooks with Docker (so no dependency on
PowerShell is needed):

```yaml
---
repos:
  - repo: https://github.com/ophiosdev/pre-commit-psscriptanalyzer.git
    rev: v2.0.0
    hooks:
      # Check PowerShell code
      - id: psscriptanalyzer-check-docker
      # Format PowerShell code
      - id: psscriptanalyzer-format-docker
```

## Supported hooks

### psscriptanalyzer-check

The `psscriptanalyzer-check` hook performs checks on PowerShell code, based on
[selected best practice
rules](https://github.com/PowerShell/PSScriptAnalyzer/tree/master/docs/Rules).
It supports the following options from the PSScriptAnalyzer function
[`Invoke-ScriptAnalyzer`](https://learn.microsoft.com/en-us/powershell/module/psscriptanalyzer/invoke-scriptanalyzer):

* [`-CustomRulePath`](https://learn.microsoft.com/en-us/powershell/module/psscriptanalyzer/invoke-scriptanalyzer#-customrulepath)
* [`-ExcludeRule`](https://learn.microsoft.com/en-us/powershell/module/psscriptanalyzer/invoke-scriptanalyzer#-excluderule)
* [`-Fix`](https://learn.microsoft.com/en-us/powershell/module/psscriptanalyzer/invoke-scriptanalyzer#-fix)
* [`-IncludeDefaultRules`](https://learn.microsoft.com/en-us/powershell/module/psscriptanalyzer/invoke-scriptanalyzer#-includedefaultrules)
* [`-IncludeRule`](https://learn.microsoft.com/en-us/powershell/module/psscriptanalyzer/invoke-scriptanalyzer#-includerule)
* [`-IncludeSuppressed`](https://learn.microsoft.com/en-us/powershell/module/psscriptanalyzer/invoke-scriptanalyzer#-includesuppressed)
* [`-RecurseCustomRulePath`](https://learn.microsoft.com/en-us/powershell/module/psscriptanalyzer/invoke-scriptanalyzer#-recursecustomrulepath)
* [`-SaveDscDependency`](https://learn.microsoft.com/en-us/powershell/module/psscriptanalyzer/invoke-scriptanalyzer#-savedscdependency)
* [`-Settings`](https://learn.microsoft.com/en-us/powershell/module/psscriptanalyzer/invoke-scriptanalyzer#-settings)
* [`-Severity`](https://learn.microsoft.com/en-us/powershell/module/psscriptanalyzer/invoke-scriptanalyzer#-severity)

The `psscriptanalyzer-check-docker` hook supports the same options.

To pass multiple values like to the `-ExcludeRule` parameter, create a
**single** string where the values are separated by a `,` (comma) **without**
any whitespaces

```yaml
---
repos:
  - repo: https://github.com/ophiosdev/pre-commit-psscriptanalyzer.git
    rev: v2.0.0
    hooks:
      # Check PowerShell code
      - id: psscriptanalyzer-check
        args:
          - '-ExcludeRule'
          - 'PSAvoidUsingConvertToSecureStringWithPlainText,PSAvoidUsingWriteHost'
```

### psscriptanalyzer-format

The `psscriptanalyzer-format` formats PowerShell code to a canonical format. It
supports the following options from the PSScriptAnalyzer function
[`Invoke-Formatter`](https://learn.microsoft.com/en-us/powershell/module/psscriptanalyzer/invoke-formatter)
:

* [`-Range`](https://learn.microsoft.com/en-us/powershell/module/psscriptanalyzer/invoke-formatter#-range)
* [`-Settings`](https://learn.microsoft.com/en-us/powershell/module/psscriptanalyzer/invoke-formatter#-settings)

The `psscriptanalyzer-format-docker` hook supports the same options.

## Copyright and license

© 2023 Mohamed El Morabity
© 2024 Ophios GmbH

Licensed under the [GNU GPL, version 3.0 or later](LICENSE).
