[CmdletBinding()]Param(
    [Parameter(Mandatory = $true)]
    [ValidateSet('clean', 'del-results', 'test', 'test-publish', 'publish', 'about')]
    [string]$action
)

$TestFilter = 'Name=GivenSeleniumWhenSearchThenPageTitleVerified'

$CurrentFolder = $PSScriptRoot
$Configuration = 'Release'
$TargetFramework = 'netcoreapp3.1'
$TestProjectName = 'MyTester.Test'
$TestResultsFolder = "$CurrentFolder\$TestProjectName\TestResults"
$TestBinFolder = "$CurrentFolder\$TestProjectName\bin\$Configuration\$TargetFramework"
$PublishFolder = "$TestBinFolder\publish"
$DependencyFiles = @('chromedriver.exe')

# Get-Variable

Switch ($action) {
    'test' {
        dotnet test -l trx --filter $TestFilter
    }
    'test-publish' {
        dotnet test "$PublishFolder\$TestProjectName.dll" -l trx --results-directory $TestResultsFolder --filter $TestFilter
    }
    'clean' {
        dotnet clean
        dotnet clean -c Release
    }
    'del-results' {
        If (Test-Path -Path $TestResultsFolder) {
            Remove-Item $TestResultsFolder -Include * -Recurse -Force
            Write-Host "Remove all files from $TestResultsFolder"
        }
    }
    'publish' {
        dotnet clean
        dotnet clean -c Release
        dotnet publish $TestProjectName -c $Configuration
        $DependencyFiles | ForEach-Object { Copy-Item "$TestBinFolder\$_" -Destination $PublishFolder }
    }
    'about' {
    }
}