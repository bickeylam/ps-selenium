[CmdletBinding()]Param(
    [Parameter(Mandatory = $true)]
    [ValidateSet('clean', 'del-results', 'test', 'test-publish', 'publish', 'about')]
    [string]$action
)

$CurrentFolder = $PSScriptRoot
$Configuration = 'Release'
$TargetFramework = 'netcoreapp3.1'
$TestProjectName = 'MyTester.Test'
$TestResultsFolder = "$CurrentFolder\$TestProjectName\TestResults"
$TestBinFolder = "$CurrentFolder\$TestProjectName\bin\$Configuration\$TargetFramework"
$PublishFolder = "$CurrentFolder\$TestProjectName\bin\Publish"
$DependencyFiles = @('chromedriver.exe')
$TestFilter = 'Name=GivenTwoNumbersWhenAddThenResultCalculated'
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

        If (Test-Path -Path $PublishFolder) {
            Remove-Item $PublishFolder -Include * -Recurse -Force
        }

        dotnet publish $TestProjectName -o $PublishFolder -c Release
        $DependencyFiles | ForEach-Object { Copy-Item "$TestBinFolder\$_" -Destination $PublishFolder }
    }
    'about' {
    }
}