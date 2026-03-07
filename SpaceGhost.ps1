<#
SpaceGhost

Mode Redirect

Monitor Sensors and Alert

#>

Write-Host "Hello, how may I help you?"
Write-Verbose "Hello, how may I help you?"

#categories
$global:cat = $null
function change-mode{
    $c = read-host "Choose a Mode`n                 1 -->Local System Diagnosis"
    Set-Variable -Name cat -Value ($c) -Scope Global

    #cat 1 local system launch

    switch ($cat)
    {
        1 {start-process F:\WorkBench\PowerShell\SpaceGhost\Mode\LocalSys-Diag.ps1; change-mode }
        2 {start-process}
        3 {start-process}
        4 {start-process}
        default{Mode-Main}
    }

}

#When you choose nothing monitor mode to sensors.
function Mode-Main {
   $hasError = $false

   While($hasError -eq $false) {
                                #Check Sensor 1
                                #Check Sensor 2
                                #Check Sensor 3
                                #Check Sensor 4
                                #Check Sensor 5
                                #if message -match $triggers $hasError = $true  & $finding = $check#


                            }

   Write-Error -Message "I have found a problem" -RecommendedAction "I recommend you run error-report"
   Write-Warning -Message "I have found an anomaly that may require your attention"
}

#cat 2 launch


#cat 3 launch


#cat 4 launch


#Helpful functions

function Report-localSystems {
    #current computer domain
    Get-WmiObject -class win32_computersystem | Select-Object Domain
    #current windows operating version
    Get-WmiObject -class win32_operatingsystem | Select-Object version
    #current ip configuration
    Get-NetAdapter | Where-Object -property Status -eq Up
}



function Report-serverSystems {}



function Report-externalSystems {
    $a = 001
    $b = 254
    $baseIp = "172.20.0."

    $i = $a
    while($i -lt $b){
        $ip = $baseIp + $i
        $ip
        Test-Connection -Count 1 $ip -Quiet
        $i++
    }
}
