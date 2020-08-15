    Add-Type -Path 'C:\Users\skaur\Desktop\Microsoft.SharePoint.Client.dll'
    Add-Type -Path 'C:\Users\skauro\Desktop\Microsoft.SharePoint.Client.Runtime.dll'
$userName = "savitej@username0609.onmicrosoft.com"
$passWord = "**********"
$encPassWord = convertto-securestring -String $passWord -AsPlainText -Force
$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $userName, $encPassWord
Connect-PnPOnline -Url "https://username0609-admin.sharepoint.com/" -Credentials $cred

New-PnPTenantSite `
  -Title "PNP PowerShell" `
  -Url "https://username0609.sharepoint.com/sites/PNPPowerShell" `
  -Description "PNPPowerShell Site" `
  -Owner "savitej@username0609.onmicrosoft.com" `
  -Lcid 1033 `
  -Template "STS#3" `
  -TimeZone 10 `
  -Wait
Write-Host "The modern team site has been created successfully."
Get-PnPTenantSite -Template GROUP#0
Write-Host "Retrieved all Modern Team Sites."
New-PnPSite -Type CommunicationSite -Title 'Demo Communication Site' -Url "https://username0609.sharepoint.com/sites/DemoCommunicationSite" -SiteDesign "Showcase"
Write-Host "The communication site has been created successfully"
Get-PnPTenantSite -Template SITEPAGEPUBLISHING#0
Write-Host "Retrieved all Communication Sites."
Get-PnPSiteCollectionAdmin
Write-Host "Retrieved Site Collection Administrator."
Get-PnPTenantSite
Write-Host "Retrieved all Site Collections."
$siteURL= "https://username0609.sharepoint.com/sites/PNPPowerShell"
Connect-PnPOnline -Url $siteURL -Credentials $cred
Get-PnPSubWebs
Write-Host "All the Sub Sites are retrieved from SharePoint Online."
$ctx = New-Object Microsoft.SharePoint.Client.ClientContext($siteUrl)
$credentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($username, $password)
$ctx.Credentials = $credentials
$web = $ctx.Web
$lists = $web.Lists
$ctx.Load($lists)
$ctx.ExecuteQuery()
$lists| select -Property Title, ID
$ListName ="DemoList"
Add-PnPListItem -List $ListName -Values @{"Title" = "Item 1"; "Description"="Description"}



