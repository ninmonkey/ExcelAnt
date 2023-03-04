```ps1
$tinfo = $this.objInstance.GetType()
        return @(
            $Tinfo | Format-GenericTypeName
            $Tinfo | FOrmat-ShortSciTypeName
            $Tinfo | Format-TypeName
            $Tinfo | Format-ShortTypeName
        ) | Join.UL
```
outputs

```ps1
 String[String, String]

 [Dictionary<string, ParameterMetadata>]

 Dictionary`2

 [Collections.Generic.Dictionary`2[[System.String, System.Private.CoreLib, Version=7.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e],[System.Management.Automation.ParameterMetadata, System.Management.Automation, Version=7.3.2.500, Culture=neutral, PublicKeyToken=31bf3856ad364e35]]]
```
