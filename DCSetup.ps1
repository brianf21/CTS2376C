New-NetIPAddress -IPAddress 10.0.0.2 -PrefixLength 24 -DefaultGateway 10.0.0.1 -InterfaceAlias Ethernet
Install-WindowsFeature -Name ad-domain-services -IncludeManagementTools -Restart
Rename-Computer -NewName dc -Restart

# After the reboot, run these commands
$pwd = ConvertTo-SecureString 'Pa11word' -AsPlainText -Force
Install-ADDSForest -DomainName contoso.com -SafeModeAdministratorPassword $pwd -Force
Add-DnsServerPrimaryZone -NetworkID 10.0.0/24 -ReplicationScope Forest
Register-DnsClient
