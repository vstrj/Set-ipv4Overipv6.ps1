# Set-ipv4Overipv6.ps1

Sets a registry value that makes a computer perfer IPv4 over IPv6. With a log function that logs everything under the application log in eventviewer.


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

  .\set-ipv4overipv6.ps1 -RemoveRegKey


To run from Intune:

Install:

powershell.exe -noprofile -executionpolicy bypass -file .\Set-ipv4Overipv6.ps1

Uninstall


powershell.exe -NoProfile -Executionpolicy bypass -Command "& Set-ipv4Overipv6.ps1 -RemoveRegKey"


Select "Intune will force a mandatory device restart" since the effect of the script will not apply until a reboot has occured.

Detection rule:

HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters 

DisabledComponents

0x20



![image](https://user-images.githubusercontent.com/51228126/122414983-d241e300-cf87-11eb-8a4c-305a00469d9c.png)
