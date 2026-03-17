# Compares two lists and removes items in the ExclusionList from the ActionList.
# Returns only items present in both lists (intersection).

function Get-ExclusionList {
    param(
        [string]$ExclusionListPath = 'C:\SCRIPT WORKBENCH\Test Scripts\Test_Lists\ExclusionList.txt',
        [string]$ActionListPath    = 'C:\SCRIPT WORKBENCH\Test Scripts\Test_Lists\ActionList.txt'
    )

    $ExclusionList = Get-Content $ExclusionListPath
    $ActionList    = Get-Content $ActionListPath

    $newlist = Compare-Object -ReferenceObject $ActionList -DifferenceObject $ExclusionList -IncludeEqual |
               Where-Object { $_.SideIndicator -eq '==' } |
               Select-Object -ExpandProperty InputObject

    return $newlist
}
