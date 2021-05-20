# Get-ADUsers With Missing Attributes
# Juan Parra
# 05/20/21
<#
.Synopsis
Checks targetted OU and creates a CSV file of users missing specified AD Attributes.

.Description
Checks the targetted OU to create a list of users missing the attributes you specify below. 
Only users missing the attributes will be pulled into the list and exported at the given file path under the file name "UsersMissingAtts.CSV"
#>

# Update the OUpath with the Distinguished Name of the OU, not the Canonical Name.
# You can use the following command to get the Distinguished Name of a User in the same target OU then copy and paste into the path below, removing the CN from the path first. 
# (Get-ADUser -Identity User -Property DistinguishedName).DistinguishedName
$OUpath = 'OU=Users,OU=Floor,OU=Department,OU=Company,DC=Example,DC=DC'
# Update export path to the desired export path. Include a name for the file at the end like seen below.
$ExportPath = 'C:\Users\Juan\Desktop\Scripts\Outputs\UsersMissingAtts.csv'


# Update Where-Objects with the AD Attributes you want to search for. The last attribute should not have a -or`, this will break the function.
$MissingAtts = Get-ADUser -Filter {(enabled -eq "True")} -SearchBase $OUpath -Properties * |`
    Where-Object { 
    $_.name -eq $null -or `
    $_.office -eq $null -or`
    $_.telephoneNumber -eq $null -or`
    $_.description -eq $null }
# Update Select-Object with your target attributes as well so you can see what attribute is missing from that user.
if ($MissingAtts.count -eq 0) {
    'No Users missing the specified Attributes were found'
        Exit
    }else {
        $MissingAtts | Select-Object Name,UserPrincipalName,Description,CanonicalName | Sort-Object Name | Export-Csv -NoTypeInformation $ExportPath
    }
