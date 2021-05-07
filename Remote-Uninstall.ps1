# Remote Uninstall
# Juan Parra
# 04/20/21
<# #---------------------------------------------------------------------#
.SYNOPSIS
    Generates a list of installed programs on target computer, includes optional uninstall.

.DESCRIPTION
    Silently connects to the target computer, generates an installed programs list, and provides the option to uninstall the selected program if desired.

.INPUTS
    Target Computer
    Select program
    Answer Yes or No prompt to run uninstall function.
    Confirm you want to uninstall your selection

.OUTPUTS
    Installed programs list

#---------------------------------------------------------------------#
.NOTES
    Update the import path below to reflect the location of the Master Functions File for Remote-Uninstall
        (Remote-Uninstall_MSTR.ps1).
#>
# Imports Master Functions file.
. "C:\Users\SysAdmin\Desktop\Scripts\Master Functions\Remote-Uninstall_MSTR.ps1"
#> #---------------------------------------------------------------------#
#                             *StartScript*                              #
Write-ScriptTitle
$Computer = Get-Computer
Show-Info
$App = Set-App
Request-Uninstall
Write-ScriptEnd
