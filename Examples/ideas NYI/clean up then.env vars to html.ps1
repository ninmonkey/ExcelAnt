
& { 'iter2'
    function b.Html.Table.FromHashtable {
        param(
            [hashtable]$InputHashtable
        )
        $renderBody = $InputHashTable.GetEnumerator() | %{
            '<tr><td>{0}</td><td>{1}</td></tr>' -f @(
                $_.Key ?? '?'
                $_.Value ?? '?'
            )

        } | Join-String -sep "`n"
        $renderFinal = @(
            '<table>'
            $renderBody
            '</table>'
        ) | Join-String -sep "`n"
        return $renderFinal
        # '<table>'
        # '</table>'

    }

    $selectEnvVarKeys = 'TMP', 'TEMP', 'windir'
    $selectKeysOnlyHash = @{}
    ls env: | ?{
        $_.Name -in @($selectEnvVarKeys)
    } | %{ $selectKeysOnlyHash[$_.Name] = $_.Value}

    b.Html.Table.FromHashtable -InputHashtable $selectKeysOnlyHash
}

& {
    'iter1'

$selectEnvVarKeys = 'TMP', 'TEMP', 'windir'
$select = ls env: | ?{ $_.Name -in @($selectEnvVarKeys)  }
$select.GetEnumerator() | %{ @(
   @(
      '<td>key: '; $_.Key ; '</td>'
      '<td>val: '; $_.Value; '</td>'
   ) |Join-String -op "`n<tr>" -os "`n</tr>" -sep "`n    "

) | Join-String -sep "" }
  | Join-String -sep "`n`n"
  | Join-String -op "<table>`n`n" -os "`n`n</table>"

}