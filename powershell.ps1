Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key Tab -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-Alias -Name npp -Value notepad++

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

Remove-Item Alias:\rm -ErrorAction SilentlyContinue
function global:rm {    
    $force = $false
    $recurse = $false
    $targets = @()
    $stopOptions = $false
    
    foreach ($arg in $args) {
        if (-not $stopOptions -and $arg -eq '--') { $stopOptions = $true; continue }
        if (-not $stopOptions -and $arg -like '-*') {
            if ($arg -match 'f') { $force = $true }
            if ($arg -match 'r') { $recurse = $true }
            continue
        }
        $it = Get-Item -LiteralPath $arg -Force
        if ($it) { $targets += $it }
    }
    
    $cpu = [Environment]::ProcessorCount
    
    foreach ($t in $targets) {
        if (-not $t.PSIsContainer -or -not $recurse) {
            Remove-Item -LiteralPath $t.FullName -Force
            continue
        }
        
        $children = @(Get-ChildItem -LiteralPath $t.FullName -Force)
        
        $children | ForEach-Object -ThrottleLimit $cpu -Parallel {
            Remove-Item -LiteralPath $_.FullName -Recurse -Force 
        } | Out-Null
        
        Remove-Item -LiteralPath $t.FullName -Force
    }
}
