# Juan Parra
# 05/08/21
<#
.Synopsis
    GUI Menu that can call various other scripts or functions.
.Description
    Created to facilitate launching my various scripts and functions when out in the field.
.Notes
    Version 1.0 ------- 05/08/21
        Created and finalized today! Lots of research, testing, and a bit of photoshop work :^).
    Version 1.1 ------- 05/13/21
        Updated logic for new script addition "Get-ADComputerInfo"
#>
#---------------------------------------------------------------------------------------------------------------------------------------------------------#
function Write-ScriptTitle {
$Title = 'J-Tools Script Menu'
    Clear-Host 
    Write-Host `n$('>' * ($Title.length))`n$Title`n$('<' * ($Title.length))`n -ForegroundColor Red
} <#
.Description: Write-ScriptTitle
    Displays script title on script start.
#>
function Write-ScriptEnd {
$End = 'J-Tools Menu has closed'
    Write-Host `n$('>' * ($End.length))`n$End`n$('<' * ($End.length))`n -ForegroundColor Red
} <#
.Description
Write-ScriptEnd
    Displays script completion message.
#>
#---------------------------------------------------------------------------------------------------------------------------------------------------------#
# Menu Formatting
Write-ScriptTitle
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
#---------------------------------------------------------------------------------------------------------------------------------------------------------#
# Form Formatting
$form = New-Object System.Windows.Forms.Form
$form.Size = New-Object System.Drawing.Size(750,425)
$form.Text = "J-Tools Script Menu"
$form.StartPosition = 'CenterScreen'
$form.MaximumSize = $form.Size
$form.MinimumSize = $form.Size
$Image = [System.Drawing.Image]::FromFile("C:\Program Files\Scripts\J-Tools Script Menu\Source Files\BG5.png")
$form.BackgroundImage = $Image
$form.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon("C:\Program Files\Scripts\J-Tools Script Menu\Source Files\icon.ico")
#---------------------------------------------------------------------------------------------------------------------------------------------------------#
# Label Formatting

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(80,40)
$label.Size = New-Object System.Drawing.Size(558,30)
$label.Text = 'Select a Function:'
$label.BackColor = 'Teal'
$label.ForeColor = 'White'
$label.Font = 'Arial,18'
$form.Controls.Add($label)
#---------------------------------------------------------------------------------------------------------------------------------------------------------#
# Ok Button Formatting
$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(190,320)
$okButton.Size = New-Object System.Drawing.Size(95,28)
$okButton.Text = 'Select'
$okButton.BackColor = 'Teal'
$okButton.ForeColor = 'White'
$okButton.Font = 'Arial,13'
$okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $okButton
$form.Controls.Add($okButton)
#---------------------------------------------------------------------------------------------------------------------------------------------------------#
# Cancel Button Formatting
$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Point(413,320)
$cancelButton.Size = New-Object System.Drawing.Size(95,28)
$cancelButton.Text = 'Close'
$cancelButton.BackColor = 'Teal'
$cancelButton.ForeColor = 'White'
$cancelButton.Font = 'Arial,13'
$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $cancelButton
$form.Controls.Add($cancelButton)
#---------------------------------------------------------------------------------------------------------------------------------------------------------#
# List Box Formatting
$listBox = New-Object System.Windows.Forms.ListBox
$listBox.Location = New-Object System.Drawing.Point(80,70)
$listBox.Size = New-Object System.Drawing.Size(560,250)
$form.StartPosition = 'CenterScreen'
$listBox.BackColor = 'Black'
$listBox.ForeColor = 'White'
$listBox.Font = 'Arial,18'

[void] $listBox.Items.Add('1: Get-ADComputerInfo')
[void] $listBox.Items.Add('2: Recreate User Profile')
[void] $listBox.Items.Add('3: Remote Restart')
[void] $listBox.Items.Add('4: Remote Uninstall')
[void] $listBox.Items.Add('5: Switch AutoLogon')

$form.Controls.Add($listBox)
$form.Topmost = $true
$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::Cancel) {
    Write-ScriptEnd
}
if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
    if ($listBox.SelectedItem -eq '1: Get-ADComputerInfo') {
        . "C:\Program Files\Scripts\J-Tools Script Menu\Main\Get-ADComputerinfo.ps1"
    } 
}
if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
    if ($listBox.SelectedItem -eq '2: Recreate User Profile') {
        . "C:\Program Files\Scripts\J-Tools Script Menu\Main\Recreate-UserProfile.ps1"
    } 
}
if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
    if ($listBox.SelectedItem -eq '3: Remote Restart') {
        . "C:\Program Files\Scripts\J-Tools Script Menu\Main\Remote-Restart.ps1"
    }
}
if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
    if ($listBox.SelectedItem -eq '4: Remote Uninstall') {
        . "C:\Program Files\Scripts\J-Tools Script Menu\Main\Remote-Uninstall.ps1"
    }
}
if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
    if ($listBox.SelectedItem -eq '5: Switch AutoLogon') {
        . "C:\Program Files\Scripts\J-Tools Script Menu\Main\Switch-AutoLogon.ps1"
    }
}