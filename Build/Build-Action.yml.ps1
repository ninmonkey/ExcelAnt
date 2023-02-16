# template # generate action.yml

$newGitHubActionSplat = @{
    Name = "Name Of Action"
    Description = 'Action Description'
    Action = 'MyAction'
    Icon = 'minimize'
    ActionOutput = ([Ordered]@{
        SomeOutput = [Ordered]@{
            description = "Some Output"
            value = '${{steps.MyAction.outputs.SomeOutput}}'
        }
    })
}

New-GitHubAction @newGitHubActionSplat