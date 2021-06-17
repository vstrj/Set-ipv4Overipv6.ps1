<#

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
Removes the predefined valus from the registry
.\set-ipv4overipv6.ps1 -Remove

#>

#Setting script parameters
param (
    [switch]$RemoveRegKey
)
  

#Creating a function to write messages and errors to the application event log to be viewed in Event Viewer
function Write-EventLogEntry {
  
  param (
    [parameter(Mandatory, HelpMessage = 'Add help message for user', Position = 0)]
    [String]
    $Message,
    [parameter(Position = 1)]
    [string]
    [ValidateSet('Information', 'Error')]
    $type = 'Information'
  )


  Begin{
    New-EventLog -LogName Application -Source 'SetIPv4overIPv6' -ErrorAction SilentlyContinue 
  }
  
  Process{
    $log_params = @{
        Logname   = 'Application'
        Source    = 'SetIPv4overIPv6'
        Entrytype = $type
        EventID   = $(
          if ($type -eq 'Information') {
            Write-Output -InputObject 500 
          }
          else {
            Write-Output -InputObject 501 
          }
        )
        Message   = $Message
      }
      
      Write-EventLog @log_params
  }


}
  
Write-EventLogEntry -Message ('Running Script Set-IPv4OverIPv6')
  
  
  #Creatinga function to create the defined registry key
  function Set-RegKey{
    [CmdletBinding()]
    param(
      [Parameter()]
      [String] $regKeyPath = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters\",
      [Parameter()]
      [String] $regName = "DisabledComponents",
      [Parameter()]
      [String] $regValue = "0x20",
      [Parameter()]
      [String] $regType  = “DWord”,
      [Parameter(Mandatory=$false)]
      [Switch]$Remove
    )
  
    
    process {
        if ($Remove -eq $false){
            Write-EventLogEntry -Message ("Trying to set $regName in $regKeyPath to $regValue ")
            try {
                if(!(Test-Path $regKeyPath))
                {
                New-Item -Path $regKeyPath -Force | Out-Null
                New-ItemProperty -Path $regKeyPath -Name $regName -Value $regValue -Force | Out-Null
                Set-ItemProperty -Path $regKeyPath -Name $regName -Value $regValue -Type DWord -Force | Out-Null
                }
            else {
                Set-ItemProperty -Path $regKeyPath -Name $regName -Value $regValue -Type DWord -Force | Out-Null
                }
                Write-EventLogEntry -Message ("Changed $regName Value in registry to $regValue ")
            }
            
            catch {
                Write-EventLogEntry -Message ("Could not change $regName Value in $regKeyPath") -type Error
            }
        }
        elseif ($Remove -eq $True) {
            #Remove the registry key
            try{
                Remove-ItemProperty -Path $regKeyPath -Name $regName -Force | Out-Null
                Write-EventLogEntry -Message ("Removed $regName under $regKeyPath")
            }
            catch{
                Write-EventLogEntry -Message ("Could not remove $regName under $regKeyPath")
            }
        }

    }
  }


#If RemoveRegKey switch is set, reg key will be removed, otherwise it will create the key
  if ($RemoveRegKey -eq $False){
  Set-RegKey
  }
  elseif($RemoveRegKey -eq $True){
    Set-RegKey -Remove
  }