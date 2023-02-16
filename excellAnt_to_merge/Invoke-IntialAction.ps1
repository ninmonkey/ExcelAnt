Install-Module PSDevOps -Scope CurrentUser -Force
Import-Module PSDevOps -Force -PassThru | Out-Host
mkdir .\github | Out-Null
mkidr .\github\workflows | Out-Null

$newGitHubWorkflowSplat = @{
    Name = "Analyze, Test, Tag, and Publish"
    On = 'Push', 'PullRequest', 'Demand'
    Job = 'PowerShellStaticAnalysis', 'TestPowerShellOnLinux', 'TagReleaseAndPublish'
}
$YamlFilename = 'github/workflows/TestAndPublish.yml'
$setContentSplat = @{
    Encoding = 'UTF8'
    PassThru = $true
    Path = Join-Path $PSScriptRoot $YamlFilename
}
New-Item -Path (Join-Path $PSScriptRoot $YamlFilename) -itemType File -Force -ea 'SilentlyContinue' | Out-Null
New-GitHubWorkflow @newGitHubWorkflowSplat
| Set-Content @setContentSplat -PassThru -Force