
- [Modern Method to Get the Full Filepath without scripts.xlsx](./Modern%20Method%20to%20Get%20the%20Full%20Filepath%20without%20scripts.xlsx)

note: These formulas say `filename` but don't change it. It literally uses the name `filename` to lookup the real filename.

## Raw Name


```sql
= @CELL("filename",A1)
```
Example:

> c:\pwsh\ExcelAnt\Examples\[Modern Method to Get the Full Filepath without scripts.xlsx]Info

## Name

```sql
= TEXTBEFORE(
    TEXTAFTER(@CELL("filename",A1),  "[" ),
    "]"
)
```
Example:
> Modern Method to Get the Full Filepath without scripts.xlsx

## Directory

```sql
= TEXTBEFORE(@CELL("filename",A1),  "\[" )
```
Example:

> c:\pwsh\ExcelAnt\Examples\

## Worksheet

```sql
= TEXTAFTER(@CELL("filename",A1),  "]" )
```
Example:
> Info
