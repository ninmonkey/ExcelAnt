## 

first 
- [ ] ClampColumns `Clamp(50, 120)` because `-AutoSize` is super super crazy
- [ ] FixedColumnsWidth = mapping of names to sizes

- [ ] SelectWorksheetOrder
- [ ] HideWorksheet
- [ ] `[ExcelPackageOrFileAttribute()]$Package`
- [ ] `xlPackage` type uses `ExcelPackageOrPath` . 
  - [ ] would returning, passthru, actually break if `dispose` is used, and the type transformation arg
    - runs the ctor and the copy constructor/pop free the resource of the other? 

## first

note: 2 modes

- [ ] 1] select book based on user label (dynamic name)
- [ ] 2] select book by filename
- [ ] 3] openBook, creates a copy with a dynamic name to prevent any file IO errors

<@--

-->
an



## functions 

- [ ] Re(sort) column property naming order when using `[PSCO]`
- [ ] func to auto-convert lists to `JoinCsv` for strings like export-excel/csv
  - [ ] this is in contrast to `unpivot`/ `explodeProperties`
- [ ] drop empty properties

## todo

Loaded modules don't show functions.
Can calling export-moduleMember be an issue? or cached module data ?

- [ ] `gcm -m ExcelAnt`

To Fix:

- [ ] make `build-module` auto-export aliases into the func, or don't shadow them

check for build pipeline to generate the invoke-build script

- https://github.com/PoshCode/ModuleBuilder
- https://github.com/Jaykul/TerminalBlocks/blob/main/build.psd1
