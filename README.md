# Azure-AD-Daily Admin Tasks
## Azure Active Directory automation PowerShell scripts.
## This repository contains automation PowerShell scripts for common Azure AD management scenarios such as:
  1.	Connect to Azure AD
  2.	Create New Users
  3.	Delete Existing Users
  4.	Add User to Group
  5.	Remove user from Group
  6.	Get Current License Status
  7.	Assign License
  8.	Remove License
  9.	Add Azure Application
  10.	Remove Azure Application
  11.	Enable MFA/ Force MFA For Users
  12.	Recover Deleted Object
Will Explain each Option:

### Connect to Azure AD
The script will connect to Azure AD and here you have two option
•	Uncomment the 4 lines code and store you credentials if you don’t like to keep entering them every time
•	do not change the function and you will be able to connect with new credential every time

### Create New Users
The Script Will create one or multiple users in Azure AD as per data filled in CSV file
The CSV has the below columns:
•	Firstname, MiddleInitials, Lastname, Department, JobTitle, Country, Mobile, Password, UserPrincipalName, MailNickName

UserPrincipalName, are MailNickName optional fields
You need just to fill the CSV file and confirm on shell before you start the operation

### Delete Existing Users
You can delete single or multiple users thru the CSV file, you just have to fill either UserPrincipalName or MailNickName

### Add User to Group
You can add single or multiple users into the specific group thru the CSV file, you just have to fill either UserPrincipalName or MailNickName, the script will list all group you have and then you  can select the desire group

### Remove User from Group
You can remove single or multiple users from the specific group thru the CSV file, you just have to fill either UserPrincipalName or MailNickName, the script will list all group you have and then you can select the desire group

### Get Current License Status
The script will list the available and the consumed licenses

### Assign License
You can assign license for single or multiple users thru the CSV file, you just have to fill either UserPrincipalName or MailNickName, the script will list all licenses  you have and then you  can select the desire license you want to assign

### Unassign License
You can unassign license for single or multiple users thru the CSV file, you just have to fill either UserPrincipalName or MailNickName, the script will remove all licenses you assigned for them

### Add Azure Application
Create an Azure AD application that can access resources

### Remove Azure Application
The Script will list all Azure AD application and then you can select which one you want to remove 

### Enable MFA/ Force MFA For Users
You can Enable and enforce MFA for single or multiple users thru the CSV file, you just have to fill either UserPrincipalName or MailNickName, the script will enable or enforce based on that

### Recover Deleted Object
The script will list all deleted object from Azure AD and then you can select which object you which to recover
