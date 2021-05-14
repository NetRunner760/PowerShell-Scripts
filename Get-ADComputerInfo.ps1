# Get-ADComputerInfo
# Juan Parra
# 05/13/21
<#
.Synopsis
    GUI script that gets specific Computer properties from Active Directory.
.Description
    Simple, fast, and effective script to get useful Computer information from Active Directory with a nice GUI touch.
        Can copy an individual value from the output, simply select it and click "Copy Value".
#>
function Write-ScriptTitle {
$Title = 'Get-ADComputerInfo'
Clear-Host 
Write-Host `n$('>' * ($Title.length))`n$Title`n$('<' * ($Title.length))`n -ForegroundColor Red
} <#
.Description
Write-ScriptTitle
Displays script title on script start.
#>
function Write-ScriptEnd {
$End = 'Script has Ended'
Write-Host `n$('>' * ($End.length))`n$End`n$('<' * ($End.length))`n -ForegroundColor Red
Exit
} <#
.Description
Write-ScriptEnd
Displays script completion message.
#>
#---------------------------------------------------------------------------------------------------------------------------------------------------------#
# Menu Formatting to set the $Computer Variable
Write-ScriptTitle
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
#---------------------------------------------------------------------------------------------------------------------------------------------------------#
# Form Formatting
$form = New-Object System.Windows.Forms.Form
$form.Size = New-Object System.Drawing.Size(750,200)
$form.Text = "Get Active Directory Computer Information"
$form.StartPosition = 'CenterScreen'
$form.MaximumSize = $form.Size
$form.MinimumSize = $form.Size
$Image = [System.Drawing.Image]::FromFile("C:\Program Files\Scripts\J-Tools Script Menu\Source Files\Blue.png")
$form.BackgroundImage = $Image
$form.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon("C:\Program Files\Scripts\J-Tools Script Menu\Source Files\icon.ico")
#---------------------------------------------------------------------------------------------------------------------------------------------------------#
# Label Formatting
$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(80,40)
$label.Size = New-Object System.Drawing.Size(558,30)
$label.Text = 'Enter Computer Name:'
$label.BackColor = 'Teal'
$label.ForeColor = 'White'
$label.Font = 'Arial,18'
$form.Controls.Add($label)
#---------------------------------------------------------------------------------------------------------------------------------------------------------#
# Ok Button Formatting
$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(190,115)
$okButton.Size = New-Object System.Drawing.Size(95,38)
$okButton.Text = 'Enter'
$okButton.BackColor = 'Black'
$okButton.ForeColor = 'White'
$okButton.Font = 'Arial,18'
$okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $okButton
$form.Controls.Add($okButton)
#---------------------------------------------------------------------------------------------------------------------------------------------------------#
# Cancel Button Formatting
$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Point(415,115)
$cancelButton.Size = New-Object System.Drawing.Size(95,38)
$cancelButton.Text = 'Close'
$cancelButton.BackColor = 'Black'
$cancelButton.ForeColor = 'White'
$cancelButton.Font = 'Arial,18'
$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $cancelButton
$form.Controls.Add($cancelButton)
#---------------------------------------------------------------------------------------------------------------------------------------------------------#
#Input Text Box Formating
$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(80,75)
$textBox.Size = New-Object System.Drawing.Size(558,120)
$textBox.Font = 'Arial, 18'

$form.Controls.Add($textBox)
$form.Topmost = $true
$form.Add_Shown({$textBox.Select()})
$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
    $Computer = $textBox.Text
}
if ($result -eq [System.Windows.Forms.DialogResult]::Cancel) {
    Write-ScriptEnd
}
#---------------------------------------------------------------------------------------------------------------------------------------------------------#
#---------------------------------------------------------------------------------------------------------------------------------------------------------#
#---------------------------------------------------------------------------------------------------------------------------------------------------------#
# Variables for target Active Directory properties
$Name = (Get-ADComputer -Identity $Computer -Property Name).Name
$OU = (Get-ADComputer -Identity $Computer -Property CanonicalName).CanonicalName
$Desc = (Get-ADComputer -Identity $Computer -Property Description).Description 
$IP = (Get-ADComputer -Identity $Computer -Property IPv4Address).IPv4Address
$Status = (Get-ADComputer -Identity $Computer -Property Enabled).Enabled
$OS = (Get-ADComputer -Identity $Computer -Property OperatingSystem ).OperatingSystem 
#---------------------------------------------------------------------------------------------------------------------------------------------------------#
# Menu Formatting for Active Directory property outputs
Write-ScriptTitle
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
#---------------------------------------------------------------------------------------------------------------------------------------------------------#
# Form Formatting
$form = New-Object System.Windows.Forms.Form
$form.Size = New-Object System.Drawing.Size(750,425)
$form.Text = "Active Directory Computer Information"
$form.StartPosition = 'CenterScreen'
$form.MaximumSize = $form.Size
$form.MinimumSize = $form.Size
$Image = [System.Drawing.Image]::FromFile("C:\Program Files\Scripts\J-Tools Script Menu\Source Files\Blue.png")
$form.BackgroundImage = $Image
$form.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon("C:\Program Files\Scripts\J-Tools Script Menu\Source Files\icon.ico")
#---------------------------------------------------------------------------------------------------------------------------------------------------------#
# Label Formatting
$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(80,40)
$label.Size = New-Object System.Drawing.Size(559,30)
$label.Text = "Active Directory Information for $Computer :"
$label.BackColor = 'Teal'
$label.ForeColor = 'White'
$label.Font = 'Arial,18'
$form.Controls.Add($label)
#---------------------------------------------------------------------------------------------------------------------------------------------------------#
# Ok Button Formatting
$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(190,320)
$okButton.Size = New-Object System.Drawing.Size(95,38)
$okButton.Text = 'Copy Value'
$okButton.BackColor = 'Black'
$okButton.ForeColor = 'White'
$okButton.Font = 'Arial,18'
$okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $okButton
$form.Controls.Add($okButton)
#---------------------------------------------------------------------------------------------------------------------------------------------------------#
# Cancel Button Formatting
$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Point(415,320)
$cancelButton.Size = New-Object System.Drawing.Size(95,38)
$cancelButton.Text = 'Close'
$cancelButton.BackColor = 'Black'
$cancelButton.ForeColor = 'White'
$cancelButton.Font = 'Arial,18'
$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $cancelButton
$form.Controls.Add($cancelButton)
#---------------------------------------------------------------------------------------------------------------------------------------------------------#
# List Box Formatting
$listBox = New-Object System.Windows.Forms.ListBox
$listBox.Location = New-Object System.Drawing.Point(80,70)
$listBox.Size = New-Object System.Drawing.Size(560,250)
$listBox.BackColor = 'Black'
$listBox.ForeColor = 'Lime'
$listBox.Font = 'Arial,12'
$listBox.HorizontalScrollbar = $True

[void] $listBox.Items.Add("Computer Name: $Name")
[void] $listBox.Items.Add("IP Address: $IP")
[void] $listBox.Items.Add("Computer Enabled: $Status")
[void] $listBox.Items.Add("AD Description: $Desc")
[void] $listBox.Items.Add("Operating System: $OS")
[void] $listBox.Items.Add("OU Location: $OU")

$form.Controls.Add($listBox)
$form.Topmost = $true
$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::Cancel) {
    Write-ScriptEnd
}
if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
    if ($listBox.SelectedItems -eq "Computer Name: $Name") {
        Set-Clipboard -Value "$Name"
    }
}
if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
    if ($listBox.SelectedItems -eq "Computer Name: $IP") {
        Set-Clipboard -Value "$IP"
    }
}
if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
    if ($listBox.SelectedItems -eq "Computer Name: $Status") {
        Set-Clipboard -Value "$Status"
    }
}
if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
    if ($listBox.SelectedItems -eq "Computer Name: $Desc") {
        Set-Clipboard -Value "$Desc"
    }
}
if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
    if ($listBox.SelectedItems -eq "Computer Name: $OS") {
        Set-Clipboard -Value "$OS"
    }
}
if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
    if ($listBox.SelectedItems -eq "Computer Name: $OU") {
        Set-Clipboard -Value "$OU"
    }
}
