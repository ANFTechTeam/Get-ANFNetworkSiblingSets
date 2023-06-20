## Disclaimer

This powershell script (Get-ANFNetworkSiblingSets.ps1) is provided as is and is not supported by NetApp or Microsoft. You are encouraged to modify to fit your specific environment and/or requirements. It is strongly recommended to test the functionality before deploying to any business critical or production environments.

** **

## Description
# Get-ANFNetworkSiblingSets

### Perform a Pre-Check on Basic &lt;--> Standard Network Upgrade for a Subscription

### In Preperation for Upgrading volume(s), from Basic <--> Standard Networking, Run the Precheck Powershell Script, Get-ANFNetworkSiblingSets, which will identify your volumes and group them into networkSiblings

#### Each networkSiblingSet will upgrade all the volumes within the networkSiblingSet set at the same time

#### Running the script ahead of time allows you to view how the volumes are grouped into networkSiblingSets, and plan for your upgrade prior to executing the Change Network Feature in the portal.  The output can also be saved to a CSV file, by specifiying a command line option (see below)

** **
## Change Log
06/20/2023 - Initial Release

** **
## Prerequisites


### We recommend referring to these documentation links prior to performing any upgrade
- [Edit Network Features](https://learn.microsoft.com/en-us/azure/azure-netapp-files/configure-network-features#edit-network-features-option-for-existing-volumes) 
- [Edit Existing Volumes Considerations](https://learn.microsoft.com/en-us/azure/azure-netapp-files/azure-netapp-files-network-topologies#constraints)

-	Ensure you are authenticated to your azure tenant, or use Cloud Shell within the Azure Portal, prior to executing
-	Confirm the PowerShell Modules Az.Accounts and Az.NetAppFiles are installed
** **    

## Installation
Install Using Git clone

** **
##		Usage : 
    ./Get-ANFNetworkSiblingSets -subscriptionId subscriptionId or -subscriptionId subscriptionName
                               [-csvFile filename]


** **
## Example Output

 - Sample Output from the script is shown [here](https://github.com/ANFTechTeam/Get-ANFNetworkSiblingSets/blob/main/Sample%20Output%20from%20Powershell%20Script.png) 

 ** **
 ## Issues and Feedback?

[ Sunmit an Issue against the repo ](https://github.com/ANFTechTeam/Get-ANFNetworkSiblingSets/issues)

    
