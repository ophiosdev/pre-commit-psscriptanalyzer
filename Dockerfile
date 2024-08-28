# Copyright © 2023 Mohamed El Morabity
# Copyright © 2024 Ophios GmbH
# SPDX-License-Identifier: GPL-3.0-or-later

FROM mcr.microsoft.com/powershell:lts-alpine

RUN pwsh -Command \
    "Set-PSRepository -ErrorAction Stop -InstallationPolicy Trusted -Name PSGallery -Verbose; \
    Install-Module -ErrorAction Stop -Name PSScriptAnalyzer -Scope AllUsers"

COPY --chmod=755 PSScriptAnalyzer-wrapper.ps1 /usr/local/bin/

ENTRYPOINT ["pwsh", "-Command", "/usr/local/bin/PSScriptAnalyzer-wrapper.ps1"]
