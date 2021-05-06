# Remote-Restart
# Juan Parra
# 03/31/2021
<# #---------------------------------------------------------------------#
.SYNOPSIS
    Restarts target computer, includes optional ping prompt.

.DESCRIPTION
    Quick and simple script to restart an indivdual computer and monitor it's ping responses if you need to.
    Faster than remoting on to restart manually or typeing out long commands :)

.INPUTS
    Target Computer
    Confirm the you fully intend to restart "COMPUTERNAME"
    Answer Yes or No prompt to run ping function.

.OUTPUTS
    Ping results

#---------------------------------------------------------------------#
.NOTES
    Update the import path below to reflect the location of the Master Functions File for Remote-Restart 
        (Remote-Start_MSTR.ps1).
#>
# Imports Master Functions file.
. "C:\Users\SysAdmin\Desktop\Scripts\Remote-Restart_MSTR.ps1"
#> #---------------------------------------------------------------------#
#                             *StartScript*                              #
Write-ScriptTitle
$Computer = Get-Computer
Test-Computer
Confirm-Restart
Request-Ping
Write-ScriptEnd