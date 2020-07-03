<#
    .SYNOPSIS
     Manage Azure AD - Daily Tasks
	
    .NOTES
     Script is provided as an example, it has no error handeling and is not production ready. App name and permissions is hard coded.
	 We Will Keep enhancing it and will inform you once it's ready to use in production environment
	 
	.ABOUTUS
	 Author  : Azure-Heroes (Mohammad Al Rousan)
	 Date    : 01-07-2020
	 Version : 0.2
#>


$ErrorActionPreference="SilentlyContinue"
Stop-Transcript | out-null
$ErrorActionPreference = "Continue"
Start-Transcript -path "aadlogs.txt" -append

Set-ExecutionPolicy Unrestricted -Force

$ErrorActionPreference = "Continue"

# connecting to Azure Ad
Import-Module AzureRM
Import-Module AzureAD


###
### Variables
###
$conneted= $False
$NotFound = 0
$NotLic = 0
$AddLic = 0
$AlreadyLic = 0
$NotAbletoLic = 0
$CsvFilePath = "users.csv"
$Directory = "azure-heroes.com"

function Connect-ToAD
{

###
### Create a PowerShell connection to my directory. If you do not want to specify the password in the script, you can simply replace this with "Connect-AzureAD", which will prompt for a username and password.
###


## -- Uncommnet this code if you want to save your credintals --##
#$Admin = "Admin@azuer-heroes.com"
#$AdminPassword = "my password"
#$SecPass = ConvertTo-SecureString $AdminPassword -AsPlainText -Force
#$Cred = New-Object System.Management.Automation.PSCredential ($Admin, $SecPass)

$UserCredential = Get-Credential -Message "Please enter your Azure AD Credentials"
Connect-AzureAD -Credential $UserCredential
$conneted= $True
}

function Add-User
{


###
### Import the csv file. You will need to specify the path and file name of the CSV file in this cmdlet
###
$PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
$NewUsers = import-csv -Path $CsvFilePath

###
### Loop through all new users in the file. We'll use the ForEach cmdlet for this.
###

Foreach ($NewUser in $NewUsers) { 

##Note: DisplayName, UPN and MailNickName are optional in CSV you can keep them blank


###
### Construct the UserPrincipalName, the MailNickName and the DisplayName from the input data in the file 
###

	$PasswordProfile.Password = $NewUser.Password
	
	
	if([string]::IsNullOrEmpty($NewUser.UserPrincipalName))
	{	
		$UPN = $NewUser.Firstname + "." + $NewUser.LastName + "@" + $Directory
	} else {
		
		$UPN = $NewUser.UserPrincipalName
	}
    
	$DisplayName = $NewUser.Firstname + " " + $NewUser.Lastname
	
	
   
	
	if([string]::IsNullOrEmpty($NewUser.MailNickName))
	{	
		$MailNickName = $NewUser.Firstname + "." + $NewUser.LastName
	} else {
	 
	 $MailNickName = $NewUser.MailNickName
	}

###
### Now that we have all the necessary data for to create the new user, we can execute the New-AzureADUser cmdlet  
###

    New-AzureADUser -UserPrincipalName $UPN -AccountEnabled $true -DisplayName $DisplayName -GivenName $NewUser.FirstName -MailNickName $MailNickName -Surname $NewUser.LastName -Department $Newuser.Department -JobTitle $NewUser.JobTitle  -Country $NewUser.Country -Mobile $NewUser.Mobile -PasswordProfile $PasswordProfile

###
### End the Foreach loop
###
    }
}


function Delete-User
{

###
### Import the csv file. You will need to specify the path and file name of the CSV file in this cmdlet
###

$delteUsers = import-csv -Path $CsvFilePath

###
### Loop through all new users in the file. We'll use the ForEach cmdlet for this.
###

Foreach ($delUser in $delUsers) { 

##Note: DisplayName, UPN and MailNickName are optional in CSV you can keep them blank


###
### Construct the UserPrincipalName, the MailNickName and the DisplayName from the input data in the file 
###

	
	
	if([string]::IsNullOrEmpty($delUser.UserPrincipalName))
	{	
		
		Remove-AzureADUser -ObjectId $delUser.MailNickName+ "@" + $Directory
	} else {
		Remove-AzureADUser -ObjectId $delUser.UserPrincipalName
		
	}
###
### End the Foreach loop
###
    }
}


function Recover-object
{
# https://docs.microsoft.com/en-us/powershell/azure/active-directory/recovering-deleted-data?view=azureadps-2.0

$deletedObjec = Get-AzureADDeletedApplication

$i=0
write-host "Please Select Object you want to recover"
foreach($delObj in $deletedObjec)
{
$i = $i + 1
write-host $i + ':' + $delObj.DisplayName
}

 $userinput = Read-Host "Please make a selection"
 Restore-AzureADMSDeletedDirectoryObject -DisplayName $deletedObjec[$userinput].DisplayName
 
 write-host "Object Restored Successfully!"
 
}



function Add-User2Group
{

$azGroups = Get-AzureADGroup

$i=0
write-host "Please Select Object you want to Add member into it"
foreach($group in $azGroups)
{
$i = $i + 1
write-host $i + ':' + $group.DisplayName
}

 $userinput = Read-Host "Please make a selection"


$users = import-csv -Path $CsvFilePath

###
### Loop through all new users in the file. We'll use the ForEach cmdlet for this.
###

Foreach ($user in $users) { 

	if([string]::IsNullOrEmpty($delUser.UserPrincipalName))
	{	
		Add-AzureADGroupMember -ObjectId $azGroups[$userinput].DisplayName -RefObjectId  $user.MailNickName+ "@" + $Directory
	} else {
		Add-AzureADGroupMember -ObjectId $azGroups[$userinput].DisplayName -RefObjectId  $user.UserPrincipalName
		
	}
###
### End the Foreach loop
###
    }
	
 
 write-host "User Added Successfully!"
 
}


function Remove-UserFromGroup
{

$azGroups = Get-AzureADGroup

$i=0
write-host "Please Select Object you want to remove a member from it"
foreach($group in $azGroups)
{
	$i = $i + 1
	write-host $i + ':' + $group.DisplayName
}

 $userinput = Read-Host "Please make a selection"


$users = import-csv -Path $CsvFilePath

###
### Loop through all new users in the file. We'll use the ForEach cmdlet for this.
###

Foreach ($user in $delUsers) { 

	if([string]::IsNullOrEmpty($delUser.UserPrincipalName))
	{	
		Remove-AzureADGroupMember -ObjectId $azGroups[$userinput].DisplayName -MemberId  $user.MailNickName+ "@" + $Directory
	} else {
		Remove-AzureADGroupMember -ObjectId $azGroups[$userinput].DisplayName -MemberId  $user.UserPrincipalName

	}
###
### End the Foreach loop
###
    }
	
 
 write-host "Member Removed Successfully!"
 
}

function Get-LicenseList
{

			Write-Host "Checking all avaialble Licenses license..." -ForegroundColor White
			$Consumed = Get-MsolAccountSku | Where-Object { $_.AccountSkuId -like "*$License*" } | Select-Object -ExpandProperty ConsumedUnits
			$Active = Get-MsolAccountSku | Where-Object { $_.AccountSkuId -like "*$License*" } | Select-Object -ExpandProperty ActiveUnits
			$AvailLic = $active - $Consumed

Write-Host "
             END STATS
----------------------------------

Active Licenses: $Active
Consumed Licenses: $Consumed
Available Licenses: $AvailLic
-----------------------------------
" 

}


function Assign-License
{

Write-Host "Checking all avaialble Licenses license..." -ForegroundColor White
			$Consumed = Get-MsolAccountSku | Where-Object { $_.AccountSkuId -like "*$License*" } | Select-Object -ExpandProperty ConsumedUnits
			$Active = Get-MsolAccountSku | Where-Object { $_.AccountSkuId -like "*$License*" } | Select-Object -ExpandProperty ActiveUnits
			$AvailLic = $active - $Consumed
			If ($AvailLic -gt 0)
			{
				Write-Host "Setting $($Present.DisplayName)'s usage location to $CountryCode..." -ForegroundColor Yellow
				Set-MsolUser -UserPrincipalName ($Present).UserPrincipalName -UsageLocation $CountryCode
				Write-Host "licensing $($Present.DisplayName)..." -ForegroundColor Yellow
				Set-MsolUserLicense -UserPrincipalName ($Present).UserPrincipalName -AddLicenses $License
				$AddLic++
				
				#updateDB
				UpdateSQlTable(($Present).UserPrincipalName)
				
			}
			Else
			{
				$NotAbletoLic++
				Write-Warning -Message "Please purchase for $License licenses, there are $AvailLic left"
			}		
}

function Create-AzureADApp
{

$dname = $input = Read-Host "Please Enter App Name e.g (Azure Heroes App)"
$idUrl = $input = Read-Host "Please Enter IdentifierUris e.g (https://localhost/Azure-heroesApp)"
$HPage = $input = Read-Host "Please Enter Home Page URL (https://localhost/Azure-HeroesApp)"
$appValidity = $input = Read-Host "Please Enter Validity for the Credential e.g (2)"

$appName = "TailwindTradersSalesApp"
$appURI = "https://tailwindtraderssalesapp.twtmitt.onmicrosoft.com"
$appHomePageUrl = "http://www.tailwindtraders.com/"
#$appReplyURLs = @($appURI, $appHomePageURL, "https://localhost:1234")

if(!($AzApp = Get-AzureADApplication -Filter "DisplayName eq '$($dname)'"  -ErrorAction SilentlyContinue))
{
	$Guid = New-Guid
	$startDate = Get-Date
	
	$PassCred 				= New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordCredential
	$PassCred.StartDate 		= $startDate
	$PassCred.EndDate 		= $startDate.AddYears($appValidity)
	$PassCred.KeyId 			= $Guid
	$PassCred.Value 			= ([System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes(($Guid))))+"="

	$AzApp = New-AzureADApplication -DisplayName $dname -IdentifierUris $idUrl -HomePage $HPage	-PasswordCredentials $PassCred
	
	$AppDet = "Application Details for the $AADApplicationName application:
=========================================================
Application Name: 	$dname
Application Id:   	$($AzApp.AppId)
Secret Key:       	$($PasswordCredential.Value)
"
	Write-Host
	Write-Host $AppDet
}
else
{
	Write-Host
	Write-Host -f "Yellow Azure AD Application $appName already exists."
}
Write-Host
Write-Host -f Green "Finished"
Write-Host


}


function Delete-AzureADApp
{

$azApps = Get-AzureADApplication 

$i=0
write-host "Please Select App you want to remove"
foreach($Appid in $azApps)
{
	$i = $i + 1
	write-host $i + ':' + $Appid.DisplayName
}

 $userinput = Read-Host "Please make a selection"


Get-AzureRmADApplication -ObjectId $azApps[$userinput].ObjectId | Remove-AzureRmADApplication


	
 
 write-host "Member Removed Successfully!"
  
 
 
}

function Show-Menu
{
     param (
           [string]$Title = 'Managing Azure AD'
     )
     cls
     Write-Host "================ $Title ================"
	 Write-Host "1: Press 'C' Connect To Azure AD"
     Write-Host "1: Press '1' Create New Users"
     Write-Host "2: Press '2' Delete Existing Users"
     Write-Host "3: Press '3' Add User To Group"
     Write-Host "4: Press '4' Remove user from Group"
     Write-Host "5: Press '5' Get Current License Status"
     Write-Host "6: Press '6' Assign License"
     Write-Host "7: Press '7' Remove License"
     Write-Host "8: Press '8' Add Azure Application"
     Write-Host "9: Press '9' Remove Azure Application"
     Write-Host "M: Press 'M' Enable MFA/ Force MFA For Users"
	 Write-Host "R: Press 'R' Recover Deleted Object"
	

     Write-Host "Q: Press 'Q' to quit."
}


do
{
     Show-Menu
     $input = Read-Host "Please make a selection"
     switch ($input)
     {
           'C' {
                cls
                'Option C Connect To Azure AD'
				 write-host "Connecting to Azure AD..."
				 Connect-ToAD
           } '1' {
                cls
                '#1 Creating Users'
				 write-host "Please make sure to fill the CSV File with the required Data..."
				   $ReadUserInput = Read-Host "If you are ready enter (Y) or (y)"
				   
				   if($ReadUserInput -eq 'y' -Or $ReadUserInput -eq 'Y')
					{
						Add-User
					}
					else
					{
					 write-host "End the Porcess..."
					}
				   
           } '2' {
                cls
                '#2 Delete Existing Users'
				Delete-User
           } '3' {
                cls
                '#3 Add User to Group'
				Add-User2Group
           } '4' {
                cls
                '#4 Remove User From Group'
				Remove-UserFromGroup
           } '5' {
                cls
                '#5 Get Current License Status'
				Get-LicenseList
           } '6' {
                cls
                '#6 Assign License'
				Assign-License
           } '7' {
                cls
                '#7 Remove License'
           } '8' {
                cls
                '#8 Add Azure Application'
           } '9' {
                cls
                '#9 Remove Azure Application'
           }'M' {
                cls
                'Option M: Enable MFA/ Force MFA For Users'
           } 'R' {
                cls
                'Option R: Recover Deleted Object'
				Recover-object
           }

	    'q' {
                return
           }
     }
     pause
}
until ($input -eq 'q')
