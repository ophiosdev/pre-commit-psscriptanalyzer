FROM mcr.microsoft.com/powershell:lts-alpine-3.14

COPY PSScriptAnalyzer-wrapper.ps1 /usr/local/bin/
RUN chmod 0755 /usr/local/bin/PSScriptAnalyzer-wrapper.ps1 && \
    pwsh -Command \
    "Set-PSRepository -ErrorAction Stop -InstallationPolicy Trusted -Name PSGallery -Verbose; \
    Install-Module -ErrorAction Stop -Name PSScriptAnalyzer -Scope AllUsers"

ENTRYPOINT ["/usr/local/bin/PSScriptAnalyzer-wrapper.ps1"]
