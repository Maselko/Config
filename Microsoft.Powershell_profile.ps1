function prompt {
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = [Security.Principal.WindowsPrincipal] $identity
    $adminRole = [Security.Principal.WindowsBuiltInRole]::Administrator

    ## PSversion
    $psver = 10 * $PSVersionTable.PSVersion.Major + $PSVersionTable.PSVersion.Minor

    ## User
    $usr = $(if($principal.IsInRole($adminRole)) { "Admin" }
	 else { "$env:USERNAME" })

    ## Path
    $path = switch -Wildcard ($executionContext.SessionState.Path.CurrentLocation.Path) {
         "$HOME" { "-" }
         default { Split-Path -Path $executionContext.SessionState.Path.CurrentLocation.Path -Leaf }
    }

    Write-Host -Object "PS$psver " -NoNewLine -ForegroundColor Cyan
    Write-Host -Object "$usr[" -NoNewLine -ForegroundColor White
    Write-Host -Object "$path" -NoNewLine -ForegroundColor Gray
    return "] > "
}
