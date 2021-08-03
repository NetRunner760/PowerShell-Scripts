# Bulk-WinVersion
# Juan Parra
# 07/28/21
<#
.Synopsis
    Gets specific Windows Version info from $Computer(s)
.Description
    Imports Computer list, gets Windows Version info, formats into a nice pretty table :)
.Notes
        **** READ ME! ****
    Place the computer list file in the Source folder that this script is located in. The script will automatically find it via the black magic known as $PSScriptRoot. 
        Name the file ComputerList.txt then just run the script, nothing else is needed from your end.
            Thank you internet, source code: https://smsagent.blog/2017/05/18/find-the-full-windows-build-number-with-powershell/ . Modified to fit my needs of course.
    
    08/02/21: Script now automatically checks imported computers, determines their Network Status, and filters out any in a troublesome state. Processing only accessible machines.
#>
function Set-PSBG {
# Sets Powershell Background to Black, Helps with Custom Foreground Coloring. THANKS JESUS :)
    $Host.UI.RawUI.BackgroundColor = 'Black'
    $Host.UI.RawUI.ForegroundColor = 'White'
}
function Write-ScriptTitle {
# Calls Set-PSBG Function
    Set-PSBG
    Clear-Host
# Message: Get-Computer_Info
    $Title = 'Bulk-WindowsVersion'
    Write-Host $('_' * ($Title.length))`n$Title`n$('_' * ($Title.length))`n -ForegroundColor Magenta
}
function Get-WindowsInfo {
# This function gets the data from the specified registry keys below and formats them into a pretty table!
    Param
    (
        [Parameter(Mandatory=$false,
                    ValueFromPipelineByPropertyName=$true,
                    ValueFromPipeline=$true
                    )]
        [string[]]$ComputerName = $env:COMPUTERNAME
    )
    
    
    Begin
    {
        $Table = New-Object System.Data.DataTable
        $Table.Columns.AddRange(@("ComputerName","Network Status","Windows Edition","Version"))
    }
    Process
    {
        Foreach ($Computer in $ComputerName)
        {
            Write-Host "Gathering $Computer" -ForegroundColor Magenta
                $Code = {
                    $NetworkStatus = "Online"
                    $ProductName = (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion' -Name ProductName).ProductName
                    Try
                    {
                        $Version = (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion' -Name ReleaseID -ErrorAction Stop).ReleaseID
                    }
                    Catch
                    {
                        $Version = "N/A"
                    }
    
                    $TempTable = New-Object System.Data.DataTable
                    $TempTable.Columns.AddRange(@("ComputerName","Network Status","Windows Edition","Version"))
                    [void]$TempTable.Rows.Add($env:COMPUTERNAME,$NetworkStatus,$ProductName,$Version)
                
                    Return $TempTable
                }

                If ($Computer -eq $env:COMPUTERNAME)
                {
                    $Result = Invoke-Command -ScriptBlock $Code
                    [void]$Table.Rows.Add($Result.Computername, $Result.'Network Status',$Result.'Windows Edition',$Result.Version)
                }
                Else
                {
                    Try
                    {   
                        $Result = Invoke-Command -ComputerName $Computer -ScriptBlock $Code -ErrorAction Stop
                        [void]$Table.Rows.Add($Result.Computername,$Result.'Network Status',$Result.'Windows Edition',$Result.Version)
                    }
                    Catch
                    {
                        $_
                    }
                }
    
            }
    
        }
        End
    {
        "Howdy $CurrentUser! this output is located in:", "$PSScriptRoot\Bulk_Windows_Version_Output.txt`n"
        "`nShowing Windows data for $CompNum Accessible Computers.`n"


        Return ,$Table
    }
}
function Set-Timeout {
# Creates a timeout function that runs with the Test-Path command. The goal here was to ping the remote computer's registry but timeout if the computer takes too long to respond.
# Computers taking too long to respond (if they ever did) was adding major delays / hanging the script. This function resolves that problem.
    $sleepDuration = Get-Random 2,3
    $ps = [powershell]::Create().AddScript("Start-Sleep -Seconds $sleepDuration; 
    Invoke-Command -ComputerName $Computer -ScriptBlock { Test-Path -Path 'HKLM:\SOFTWARE\'}")
     
    # execute it asynchronously
    $handle = $ps.BeginInvoke()
     
    # Wait milliseconds for it to finish 1000m = 1 second
    if(-not $handle.AsyncWaitHandle.WaitOne(5000)){
        Write-Output "Remote Registry Error"
    }
}
# -------------------------------------------------------------------- #
#                            *StartScript*                             #
Write-ScriptTitle
# Define paths for Good / Bad Computers 
$Success_Path = "$PSScriptRoot\Source\Good_Computers.txt"
$Error_Path = "$PSScriptRoot\Source\Bad_Computers.txt"

# Gets current user's name for the output message
$CurrentUser = (Get-ADUser -Identity $ENV:USERNAME.Trim("a"," ") -Property Name).Name

# Imports Computers and counts them for output information
$Computers = Get-Content -Path "$PSScriptRoot\Source\ComputerList.txt"
$CompNum = ($Computers).Length
Write-Host "Imported $CompNum Computers`n" -ForegroundColor Green

# Resets existing Text Files
Out-File $Success_Path -Force
Out-File $Error_Path -Force

# Check network and WinRM statuses, filter Good/Bad Computers into separate lists
foreach ($Computer in $Computers) {
    Write-Host "Checking Status of $Computer"
    if (!(Test-Connection -ComputerName $Computer -Count 1 -Quiet -ErrorAction SilentlyContinue)) {
        Write-Output "$Computer --- Offline" | Out-File $Error_Path -Append
    } else {
        if (!(Test-WSMan -ComputerName $Computer)) {
            Write-Output "$Computer --- WinRM error" | Out-File $Error_Path -Append
        } else {
            if (Set-Timeout -eq "Remote Registry Error") {
                Write-Output "$Computer --- Remote Registry Error" | Out-File $Error_Path -Append
            } else {
                Write-Output $Computer | Out-File $Success_Path -Append
            }

             
        }
    }
}
# Gets Bad Computer list for output data
$Bad_Computers = Get-Content -Path $Error_Path -Raw
Write-Host "`nComputers in bad states have been filtered out" -ForegroundColor Yellow

# Imports Computers that are accessible (respond to Network ping, WinRM is in a good state, registry pings back).
# Counts total Computers for output data
$Computer = Get-Content -Path $Success_Path
$CompNum = ($Computer).Length

# Start Get-WindowsInfo function on Good Computers and export to txt file.
Write-Host "Gathering Windows data for $CompNum Accessible Computers.`n" -ForegroundColor Green
Start-Sleep -Seconds 2
$Bulk_Output = Get-WindowsInfo $Computer

# Get time for file naming purposes
$Time = Get-Date -Format HH:mm:ss | ForEach-Object { $_ -replace ":", "." }
$BulkFileName = "$Time-WinVer_Output.txt"
$Bulk_OutPath = "$PSScriptRoot\Outputs\$BulkFileName"

# Output gathered data to specified location, append Bad Computers, and show output.
Write-Output $Bulk_Output | Out-File -FilePath $Bulk_OutPath
Write-Output "`nComputers in Error States:`n$Bad_Computers" | Out-File -FilePath $Bulk_OutPath -Append
Invoke-Item $Bulk_OutPath
