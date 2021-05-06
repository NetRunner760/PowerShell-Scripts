# Remote-Restart
# Juan Parra
# 03/31/2021
<# #---------------------------------------------------------------------#
.DESCRIPTION
Restarts target computer, includes optional ping prompt.

.NOTES
    Version 1.0: ------- 03/31/21
        Initial Release.

    Version 1.1: ------- 04/06/21
        Added in shell Yes or No prompt function.

    Version 1.2: ------- 04/26/21
        Condensed $Computer variable code into Get-Computer function. 
        Added Test-Computer function to test for correct Hostname / active Network connection before doing anything else.

    Version 1.3: ------- 05/03/21
        Cleaned up formating, revised function order, and aliases. 
        Implemented introductional comment block.
        Moved functions onto a separate "Master Functions File". Which imports before StartScript, enabling the calling of said functions.
#> #---------------------------------------------------------------------#
#> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * #
#> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * #
#> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * #
#> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * #
# Imports Master Functions file.
. "C:\Users\sysadmin\Desktop\Scripts\Remote-Restart_MSTR.ps1"
<# 
    .NOTES
        Update the path above to reflect the location of the Master Functions File for Remote-Restart 
        (Remote-Start_MSTR.ps1).
#> #---------------------------------------------------------------------#
#                             *StartScript*                              #
Write-ScriptTitle
$Computer = Get-Computer
Test-Computer
Confirm-Restart
Request-Ping
Write-ScriptEnd
