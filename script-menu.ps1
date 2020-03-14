[CmdletBinding()]Param(
    [string]$action
)

$title = 'title'
$message = 'Please select one'
$10 = New-Object System.Management.Automation.Host.ChoiceDescription "&10", "Number 10"
$20 = New-Object System.Management.Automation.Host.ChoiceDescription "&20", "Number 20"
$duck = New-Object System.Management.Automation.Host.ChoiceDescription "&Duck", "Duck"

$options = [System.Management.Automation.Host.ChoiceDescription[]]($10, $20, $duck)
$result = $host.ui.PromptForChoice($title, $message, $options, 1)

switch ($result) {
    0 { "10" }
    1 { "20" }
    2 { "Why?" }
}
<#
Function ShowMenu {
    Write-Host '*** Menu ***'
    Write-Host 'test: dotnet test'
}

Function GetMenuItem {
    do {
        $action = Read-Host 'Select option? '
    } until ($action -ne '')
    return $action
}

If ($action -eq '') {
    ShowMenu
    $action = GetMenuItem
}

Switch ($action) {
    'test' {
        Write-Host "You have selected $action"
    }
}
#>