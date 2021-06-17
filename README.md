# Set-ipv4Overipv6.ps1

Sets a registry value that makes a computer perfer IPv4 over IPv6.


*Created By

victor.storsjo@crayon.com

*Version

0.1 - 2021-06-17 Created

*Description

Updates the registry key DisabledComponents under
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters 
to Value 0x20

*Example

Run script with default values:

.\set-ipv4overipv6.ps1 

Removes the predefined values from the registry

.\set-ipv4overipv6.ps1 -Remove
