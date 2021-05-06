# Switch-AutoLogon
# Juan Parra
# 04/30/2021
<# #---------------------------------------------------------------------#
.SYNOPSIS
    Switches AutoLogon Registry key values between 0 and 1, per your needs.

.DESCRIPTION
    Eliminates and simplifies the monotonous task of navigating to the needed registry keys to temporarily disable AutoLogon.
        Work smarter not harder :)

.INPUTS
    User Credentials
    Target Computer
    Answer Yes or No prompt to run Enable function.

.OUTPUTS
    AutoAdminLogon value set to "CURRENT VALUE"
    ForceAutoLogon value set to "CURRENT VALUE"

#---------------------------------------------------------------------#
.NOTES
    Update the path below to reflect the location of the Master Functions File for Toggle-AutoLogon
        (Switch-AutoLogon_MSTR.ps1).
#>
# Imports Master Functions file.
. "C:\Users\SysAdmin\Desktop\Scripts\Master Functions\Switch-AutoLogon_MSTR.ps1"
#> #---------------------------------------------------------------------#
#                             *StartScript*                              #
Write-ScriptTitle
$Creds = Get-Creds
$Computer = Get-Computer
$Session = Set-PSSession
Test-Computer
Disable-AutoLogon
Switch-EnableAutoLogon
Write-ScriptEnd