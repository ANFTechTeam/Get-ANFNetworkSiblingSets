#
#DISCLAIMER
#
# This powershell script (Get-ANFNetworkSiblingSets.ps1) is provided as is and is not supported by NetApp or Microsoft. You
# are encouraged to modify to fit your specific environment and/or requirements. It is strongly recommended
# to test the functionality before deploying to any business critical or production environments.
#

#
# This Script will identify and group your volumes into networkSiblingSets, to prepare for the upgrade 
#       from Basic<-->Standard Networking
#       

#
#   Usage : Get-ANFNetworkSiblingSets -subscriptionId <subscription{Id | Name}> [-csvFile filename]
#


param (
    [string]$subscriptionId = "",
    [string]$csvFile = "",
    [switch]$verbose = $false
)

$usage = "Usage : Get-ANFNetworkSiblingSets -subscriptionId <subscription{Id | Name}> [-csvFile filename]"


if ($subscriptionId -eq "" ) {
        Write-Host $usage -foregroundcolor magenta
        exit 
}

try {
     $trysub=set-azcontext -subscription $subscriptionId -ErrorAction Stop
    }
catch [System.Management.Automation.RuntimeException] {
    Write-Host "Error : Invalid subScriptionId:" $subscriptionId -foregroundcolor Red
    Exit
    }



$NetAppAccounts=Get-AzResource | Where-Object {$_.ResourceType -eq "Microsoft.NetApp/netAppAccounts"}


$volumeData = @{}


Foreach ($account in $NetAppAccounts) {

    if ($verbose -eq $true) {
        write-Output "Discovered NetApp Account: " $account.name
    }


    $CapacityPools=get-AZNetAppFilesPool -ResourceGroupName $account.ResourceGroupName -AccountName $account.Name


    Foreach ($pool in $CapacityPools) {

        if ($verbose -eq $true) {
            write-Output "Discovered Pool: " $pool.Name.Split("/")[1]
        }


        $Volumes=get-AZNetAppFilesVolume -ResourceGroupName $account.ResourceGroupName -PoolName $pool.Name.Split("/")[1] -AccountName $account.Name
        

        Foreach ($vol in $Volumes) {
            
            $VolResourceId = $vol.Id

            $resturi = 'https://management.azure.com' + $VolResourceId  + '?api-version=2022-11-01'

            $response = ""
            
            $response = Invoke-AzRestMethod -method GET -Uri $restUri

            [object] $VolProperties = ConvertFrom-Json $response.Content
            $VNetAndSubNet = $VolProperties.properties.subNetId.Split("/")[8]+ "/" + $VolProperties.properties.subNetId.Split("/")[10] 
            $VnetSubNet = $VolProperties.properties.subNetId.Split("/")[8]+ "/" + $VolProperties.properties.subNetId.Split("/")[10] + "-" + $VolProperties.properties.networkSiblingSetId

            $volumeData[$VNetSubNet] += @($Vol.Name, $Vol.mountTargets.ipAddress)
              
        }
    }
}

if ($csvFile -ne "") { 
        $csvHeader = "Sibling Set,Full Volume Identifier,Volume IP "
        Write-Output $csvHeader | Out-File -FilePath $csvFile -Append
}


$setnumber=0

Foreach ($upgradeSet in $VolumeData.keys) {
    $setnumber +=1
    
    $upgradelength = $volumeData[$upgradeset].Count

    Write-Host "Upgrade networkSibling Set " $setnumber -ForegroundColor Blue

    if ($csvFile -ne "") { 
        $csvSibSet = "Upgrade networkSibling Set " + $setnumber
        Write-Output $csvSibSet | Out-File -FilePath $csvFile -Append
    }

    For ($index = 0; $index -lt $upgradelength; $index=$index+2) {
        $indexplusone=$index+1
        Write-Host "`t" $volumeData[$upgradeset][$index] ": ("$volumeData[$upgradeset][$indexplusone]")"

        if ($csvFile -ne "") {
            $csvEntry = "," + $volumeData[$upgradeset][$index] + "," + $volumeData[$upgradeset][$indexplusone]
            Write-Output $csvEntry | Out-File -FilePath $csvFile -Append
        }
    }

    Write-Host ""
}

Exit     
