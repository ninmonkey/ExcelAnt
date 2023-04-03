
quick test using
```ps1
build
impo ExcelAnt -Force -Verbose -PassThru
Export-PipeScript -InputPath 'foo.ps.md'
```

~~~pipescript{

get-date 
}~~~


```ps1
Format-ExcelAntExactModuleVersions -OutputType RequiredImportString
```


~~~pipescript{
Format-ExcelAntExactModuleVersions -OutputType RequiredImportString
}~~~


```ps1
Format-ExcelAntExactModuleVersions -OutputType Basic
```


~~~pipescript{
Format-ExcelAntExactModuleVersions -OutputType Basic
}~~~

```ps1
Format-ExcelAntExactModuleVersions -OutputType MdTable
```


~~~pipescript{
Format-ExcelAntExactModuleVersions -OutputType MdTable
}~~~



```ps1
Format-ExcelAntExactModuleVersions -OutputType Json
```


~~~pipescript{
Format-ExcelAntExactModuleVersions -OutputType Json
}~~~

