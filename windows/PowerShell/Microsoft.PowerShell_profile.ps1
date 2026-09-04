# PSRreadLine - https://github.com/PowerShell/PSReadLine
if ($host.Name -eq 'ConsoleHost')
{
    Import-Module PSReadLine

    # Binding for moving through history by prefix
    Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
    Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
}

# Override default tab completion
Set-PSReadLineKeyHandler -Key "Ctrl+a" -Function BeginningOfLine
Set-PSReadLineKeyHandler -Key "Ctrl+e" -Function EndOfLine

# Oh My Posh - https://ohmyposh.dev/docs/installation/prompt
oh-my-posh init pwsh --config "$PSScriptRoot\grahamstrickland.omp.json" | Invoke-Expression

function GitLog() {
    git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit
}

Set-Alias -Name glg -Value GitLog

