
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
Format-ExcelAntExactModuleVersions -OutputType PSObject
```


~~~pipescript{
Format-ExcelAntExactModuleVersions -OutputType PSObject
| ft -auto
}~~~

```ps1
Format-ExcelAntExactModuleVersions -OutputType RequiredImportString
```

```ps1
~~~pipescript{
Format-ExcelAntExactModuleVersions -OutputType RequiredImportString
}~~~
```

```ps1
Format-ExcelAntExactModuleVersions -OutputType Basic
```

```ps1
~~~pipescript{
Format-ExcelAntExactModuleVersions -OutputType Basic
}~~~
```

```ps1
Format-ExcelAntExactModuleVersions -OutputType MdTable
```

### MdTable default values

~~~pipescript{
Format-ExcelAntExactModuleVersions -OutputType MdTable
}~~~


### MdTable: Explicit JoinString


~~~pipescript{
Format-ExcelAntExactModuleVersions -OutputType MdTable | Join-String -sep "`n"
}~~~



```ps1
Format-ExcelAntExactModuleVersions -OutputType Json
```


~~~pipescript{
Format-ExcelAntExactModuleVersions -OutputType Json
}~~~

```ps1
Format-ExcelAntExactModuleVersions -OutputType JsonRoundTrip
```

```json
~~~pipescript{
Format-ExcelAntExactModuleVersions -OutputType JsonRoundTrip
}~~~
```

