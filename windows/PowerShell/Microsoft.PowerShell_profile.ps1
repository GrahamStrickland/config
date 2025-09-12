# PSRreadLine - https://github.com/PowerShell/PSReadLine
if ($host.Name -eq 'ConsoleHost')
{
    Import-Module PSReadLine

    # Binding for moving through history by prefix
    Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
    Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
}

# PSFzf - https://github.com/kelleyma49/PSFzf and https://github.com/junegunn/fzf
Import-Module PSFzf

# Override PSReadLine's history search
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' `
                -PSReadlineChordReverseHistory 'Ctrl+r'

# Override default tab completion
Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }

# Oh My Posh - https://ohmyposh.dev/docs/installation/prompt
oh-my-posh init pwsh --config "$env:USERPROFILE\config\windows\PowerShell\grahamstrickland.omp.json" | Invoke-Expression
