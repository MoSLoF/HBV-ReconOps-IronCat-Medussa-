# External Connection Test
# Queries DC list for a domain and pings each DC, exporting results to CSV.

$domain = Read-Host "Enter FQDN"
$path   = Read-Host "What path and filename do you want the CSV saved to?"

# Capture nltest output and extract DC names
$nltestOutput = nltest /dclist:$domain 2>&1
$DCList = $nltestOutput |
          Where-Object { $_ -match '\\\\' } |
          ForEach-Object { ($_ -split '\\\\')[-1].Trim().Split()[0] }

if (-not $DCList) {
    Write-Warning "No DCs found for domain: $domain"
    exit 1
}

$results = foreach ($dc in $DCList) {
    $ping = Test-Connection -ComputerName $dc -Count 2 -ErrorAction SilentlyContinue
    [PSCustomObject]@{
        DC          = $dc
        Reachable   = ($null -ne $ping)
        AvgLatencyMs = if ($ping) { ($ping | Measure-Object -Property ResponseTime -Average).Average } else { $null }
    }
}

$results | Export-Csv -Path $path -NoTypeInformation
Write-Host "Results saved to: $path" -ForegroundColor Green
$results | Format-Table -AutoSize
