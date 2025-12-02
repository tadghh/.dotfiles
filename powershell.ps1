Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key Tab -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

function Invoke-SmartKill {
    param(
        [Parameter(ValueFromRemainingArguments = $true)]
        $Target
    )

    if ($Target -as [int]) {
        Stop-Process -Id $Target -Force -ErrorAction SilentlyContinue
        return
    }

    $proc = Get-Process -Name "$Target*" -ErrorAction SilentlyContinue
    if ($proc) {
        $proc | Stop-Process -Force
    }
    else {
        Write-Host "No process matched: $Target" -ForegroundColor Yellow
    }
}

Set-Alias -Name kill -Value Invoke-SmartKill -Force
