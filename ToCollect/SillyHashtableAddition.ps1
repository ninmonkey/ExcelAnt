# silly dict math for fun
$App = @{
    Root = get-item $PSScriptRoot } + @{
    ExportRoot = Join-Path $App.Root 'output' } + @{
        Exports = @{} } + @{
        LogMetaData = Join-Path $App.Exports
    }


## maybe configuration module can do this:
# silly dict math for fun
$App = @{
    Root        = Get-Item  $PSScriptRoot
    Export      = Join-Path $_.Root   'export'
    Config      = Join-Path $_.Root   'config'
    Filepath    = Join-Path $_.Export 'exports.xlsx'
    Preferences = Join-Path $_.Config 'user.json'
}

