# Toggle-AutoLogon
# Juan Parra
# 04/30/2021
<# #---------------------------------------------------------------------#
.DESCRIPTION
Toggles AutoLogon Registry key values between 0 and 1, per your needs.
    Work smarter not harder :)
.NOTES
    Version 1.0: ------- 04/30/21
        Version 1 completed and tested.

    Version 1.1: ------- 05/01/21
        Combined enable and disable key scripts. 
        Added in shell Yes or No prompt function to tie in enable key function.
        Created a capture function to check, capture, and display the current key value.

    Version 1.2: ------- 05/03/21
        Corrected and finalized Show-Result functions.
        Cleaned up formating, revised function order, and aliases. 
        Implemented introductional comment block.
        Moved functions onto a separate "Master Functions File". Which imports before StartScript, enabling the calling of said functions.
        Imported Write-ScriptTitle function.
#> #---------------------------------------------------------------------#
#> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * #
#> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * #
#> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * #
#> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * #
# Imports Master Functions file.
. "C:\Users\Rick James\SysAdmin\Scripts\FUNCTIONS\Master Functions\Toggle-AutoLogon_MSTR.ps1"
<# 
    .NOTES
        Update the path above to reflect the location of the Master Functions File for Toggle-AutoLogon
        (Toggle-AutoLogon_MSTR.ps1).
#> #---------------------------------------------------------------------#
#                             *StartScript*                              #
Write-ScriptTitle
$Creds = Get-Creds
$Computer = Get-Computer
Test-Computer
$Session = Set-PSSession
Disable-AutoLogon
Switch-EnableAutoLogon
Write-ScriptEnd