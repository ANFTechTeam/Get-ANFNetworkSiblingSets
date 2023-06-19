# Get-ANFNetworkSiblingSets

## Perform a Pre-Check on Basic &lt;--> Standard Network Upgrade for a Subscription

### In Preperation for Upgrading volume(s), from Basic <--> Standard Networking, Run the PrecheckScript
###	Get-ANFNetworkSiblingSets which will identify your volumes and group them into networkSiblings

** ** 

#### Each networkSiblingSet will upgrade all the volumes within that set at the same time

#### Running the script ahead of time allows you to view how the volumes are grouped into networkSiblingSets, and plan for your upgrade prior to executing the Change Network Feature in the portal.  The output can also be saved to a CSV file, by specifiying a command line option (see below)



### We recommend referring to these documentation links prior to performing any upgrade
-	https://learn.microsoft.com/en-us/azure/azure-netapp-files/configure-network-features#edit-network-features-option-for-existing-volumes 
-	https://learn.microsoft.com/en-us/azure/azure-netapp-files/azure-netapp-files-network-topologies#constraints

** **    

###		Usage : 
###         Get-ANFNetworkSiblingSets -subscriptionId <subscription{Id | Name}> [-csvFile filename]

     
### Download the Powerhsell script:
-	Ensure you are authenticated to your azure tenant, prior to executing
-	Confirm the PowerShell Modules Az.Accounts and Az.NetAppFiles are installed

    
