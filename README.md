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
Will Explain each Option: -
1. 1. ###	Connect to Azure AD
The AzureADGroupsfolder has 2 scripts:
* createAzureADGroups.ps1
This script will create a new Azure AD Group.
The following are the script parameters:
•	userName = name of the subscription & AD admin account
•	password = password of the subscription & AD admin
•	subscriptionName = password of the azure subscription
•	ADGroupName = name of the Azure AD group
•	ADGroupDescription = description of Azure AD group
On executing the script the a new AD Group will be created with desired name and description in the tenant.
This script will map an AD group as role to existing AD app role. Useful if you want users in a certain group to be mapped to a certain role associated to an AD application.
The following are the script parameters:
•	AppName= name of the azure AD App
•	userName = name of the subscription & AD admin account
•	password = password of the subscription & AD admin
•	subscriptionName = password of the azure subscription
•	AppRoleName= name of the Azure AD app role
•	ADGroupName= name of the Azure AD group
On executing the script the group will be configured to mapped to the given role existing in the provided AD application.
2. ### Create New Users
The AzureSQLAdApp has 2 scripts:
* SqlAdminSetup.sql
This SQL script will create a new db owner member from an existing AD application.
The following are the script parameters:
•	sqladappname = name of the desired AD application
The script will be executed by the SqlAuthADAppAutomation.ps1 and the AD app created by the PowerShell script will be registered as a db owner member at the target database by executing this SQL script against it.
* SqlAuthADAppAutomation.ps1
This Script will generate an AD application protected by a secret key, grant permissions to authenticate AD users and generate a service principal for the same. The AD application will be added as an administrator role on the target databases. Also if the drSqlServer flag is set to true then for configured target databases, the SqlAdminSetup.sql will be run against each of the database and the created AD application will be added to the db as the db owner member.
The following are the script parameters:
•	SqlADAppName = name of the desired AD application
•	SqlADAppUri = app id uri of the desired AD application
•	SqlADAppReplyUrl = reply url of the desired AD application
•	SqlResourceGroupName = resource group name where the sql server belongs to
•	SqlServerName = name of the sql server
•	SqlADGroupName = name of the desired AD group to grant administrator access against the SQL server
•	userName = user name of the azure subscription owner
•	password = password of the azure subscription owner
•	subscriptionName = name of the azure subscription
•	drSqlServer = flag to enable the azure ad application to be added as an administrator on the target sql servers
On executing the script the desired AD application is created, the desired AD group is configured to give admin access to only group members against the target sql server and the AD application is added as db owner member at the target sql databases.
3. ### Delete Existing Users
The Azure-AD-Automation has 2 scripts:
* AzureServicePrincipal.ps1
This script will generate an Azure service principal account and assign owner role to the azure subscription.
The following are the script parameters:
•	subscriptionName = name of the azure subscription
•	password = password to protect the service principal
•	spnRole = name of the permission to be granted
•	environmentName = name of the azure environment
On executing the script a new azure AD application is created with the provided configurations and protected by the given password. Post this a service principal is created against the same and granted owner permission to azure subscription. This service principal can now be used to connect securely to the azure subscription and manage resources.

4. ### Add User to Group
The Azure-AD-Automation has 2 scripts:
* AzureServicePrincipal.ps1
This script will generate an Azure service principal account and assign owner role to the azure subscription.
The following are the script parameters:
•	subscriptionName = name of the azure subscription
•	password = password to protect the service principal
•	spnRole = name of the permission to be granted
•	environmentName = name of the azure environment
On executing the script a new azure AD application is created with the provided configurations and protected by the given password. Post this a service principal is created against the same and granted owner permission to azure subscription. This service principal can now be used to connect securely to the azure subscription and manage resources.
5. ### Remove user from Group
The Azure-AD-Automation has 2 scripts:
* AzureServicePrincipal.ps1
This script will generate an Azure service principal account and assign owner role to the azure subscription.
The following are the script parameters:
•	subscriptionName = name of the azure subscription
•	password = password to protect the service principal
•	spnRole = name of the permission to be granted
•	environmentName = name of the azure environment
On executing the script a new azure AD application is created with the provided configurations and protected by the given password. Post this a service principal is created against the same and granted owner permission to azure subscription. This service principal can now be used to connect securely to the azure subscription and manage resources.
6. ### Delete Existing Users
The Azure-AD-Automation has 2 scripts:
* AzureServicePrincipal.ps1
This script will generate an Azure service principal account and assign owner role to the azure subscription.
The following are the script parameters:
•	subscriptionName = name of the azure subscription
•	password = password to protect the service principal
•	spnRole = name of the permission to be granted
•	environmentName = name of the azure environment
On executing the script a new azure AD application is created with the provided configurations and protected by the given password. Post this a service principal is created against the same and granted owner permission to azure subscription. This service principal can now be used to connect securely to the azure subscription and manage resources.
7. ### Get Current License Status
The Azure-AD-Automation has 2 scripts:
* AzureServicePrincipal.ps1
This script will generate an Azure service principal account and assign owner role to the azure subscription.
The following are the script parameters:
•	subscriptionName = name of the azure subscription
•	password = password to protect the service principal
•	spnRole = name of the permission to be granted
•	environmentName = name of the azure environment
On executing the script a new azure AD application is created with the provided configurations and protected by the given password. Post this a service principal is created against the same and granted owner permission to azure subscription. This service principal can now be used to connect securely to the azure subscription and manage resources.
8. ### Assign License
The Azure-AD-Automation has 2 scripts:
* AzureServicePrincipal.ps1
This script will generate an Azure service principal account and assign owner role to the azure subscription.
The following are the script parameters:
•	subscriptionName = name of the azure subscription
•	password = password to protect the service principal
•	spnRole = name of the permission to be granted
•	environmentName = name of the azure environment
On executing the script a new azure AD application is created with the provided configurations and protected by the given password. Post this a service principal is created against the same and granted owner permission to azure subscription. This service principal can now be used to connect securely to the azure subscription and manage resources.
9. ### Remove License
The Azure-AD-Automation has 2 scripts:
* AzureServicePrincipal.ps1
This script will generate an Azure service principal account and assign owner role to the azure subscription.
The following are the script parameters:
•	subscriptionName = name of the azure subscription
•	password = password to protect the service principal
•	spnRole = name of the permission to be granted
•	environmentName = name of the azure environment
On executing the script a new azure AD application is created with the provided configurations and protected by the given password. Post this a service principal is created against the same and granted owner permission to azure subscription. This service principal can now be used to connect securely to the azure subscription and manage resources.
10. ### Add Azure Application
The Azure-AD-Automation has 2 scripts:
* AzureServicePrincipal.ps1
This script will generate an Azure service principal account and assign owner role to the azure subscription.
The following are the script parameters:
•	subscriptionName = name of the azure subscription
•	password = password to protect the service principal
•	spnRole = name of the permission to be granted
•	environmentName = name of the azure environment
On executing the script a new azure AD application is created with the provided configurations and protected by the given password. Post this a service principal is created against the same and granted owner permission to azure subscription. This service principal can now be used to connect securely to the azure subscription and manage resources.
11. ### Remove Azure Application
The Azure-AD-Automation has 2 scripts:
* AzureServicePrincipal.ps1
This script will generate an Azure service principal account and assign owner role to the azure subscription.
The following are the script parameters:
•	subscriptionName = name of the azure subscription
•	password = password to protect the service principal
•	spnRole = name of the permission to be granted
•	environmentName = name of the azure environment
On executing the script a new azure AD application is created with the provided configurations and protected by the given password. Post this a service principal is created against the same and granted owner permission to azure subscription. This service principal can now be used to connect securely to the azure subscription and manage resources.
12. ### Enable MFA/ Force MFA For Users
The Azure-AD-Automation has 2 scripts:
* AzureServicePrincipal.ps1
This script will generate an Azure service principal account and assign owner role to the azure subscription.
The following are the script parameters:
•	subscriptionName = name of the azure subscription
•	password = password to protect the service principal
•	spnRole = name of the permission to be granted
•	environmentName = name of the azure environment
On executing the script a new azure AD application is created with the provided configurations and protected by the given password. Post this a service principal is created against the same and granted owner permission to azure subscription. This service principal can now be used to connect securely to the azure subscription and manage resources.

12. ### Recover Deleted Object
The Azure-AD-Automation has 2 scripts:
* AzureServicePrincipal.ps1
This script will generate an Azure service principal account and assign owner role to the azure subscription.
The following are the script parameters:
•	subscriptionName = name of the azure subscription
•	password = password to protect the service principal
•	spnRole = name of the permission to be granted
•	environmentName = name of the azure environment
On executing the script a new azure AD application is created with the provided configurations and protected by the given password. Post this a service principal is created against the same and granted owner permission to azure subscription. This service principal can now be used to connect securely to the azure subscription and manage resources.

