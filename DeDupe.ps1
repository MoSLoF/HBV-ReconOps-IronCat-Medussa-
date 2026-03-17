<#
.Synopsis
    Finds duplicate files in a directory by comparing MD5 hashes.
.Description
    Scans a directory recursively, hashes all files, and identifies
    files with identical hashes (exact duplicates).
.Parameter searchpath
    Directory to scan for duplicates.
.Example
    .\DeDupe.ps1
#>

param(
    [string]$searchpath,
    [string]$scrutiny
)

function Remove-DuplicateFiles {
    param([string]$Path)

    $files = Get-ChildItem $Path -Recurse -File
    $hashGroups = $files | ForEach-Object {
        [PSCustomObject]@{
            Hash = (Get-FileHash -Path $_.FullName -Algorithm MD5).Hash
            File = $_.FullName
        }
    } | Group-Object Hash | Where-Object { $_.Count -gt 1 }

    foreach ($group in $hashGroups) {
        Write-Host "Duplicate hash: $($group.Name)" -ForegroundColor Yellow
        $group.Group | ForEach-Object { Write-Host "  $($_.File)" }
    }

    return $hashGroups
}

Write-Host "Welcome to the Data Deduplication PowerShell script."
Write-Host "This script searches the selected directory for files with the same hash."

if (-not $searchpath) {
    $searchpath = Read-Host "Input the full path of the directory you wish to run DeDupe"
}

if (Test-Path $searchpath) {
    Remove-DuplicateFiles -Path $searchpath
} else {
    Write-Warning "Path not found: $searchpath"
}
