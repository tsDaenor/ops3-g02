### Script: Maken van een back-up op Windows Server 2012

```
# Uses Windows Server Backup Feature

# Creates a Bare Metal Restoreable and Full VSS Backup

# Saves Backup to \\ServerName\ShareName\ComputerName\Current

# Allows for retaining older backups, you can set how many

# If the $MaxBackup variable is set to anything greater than 0 and the previous backup was successful,
# the script copies the current backup folder to \\ServerName\ShareName\ComputerName\Archive\<CurrentDate>
# before starting a new backup
cls
$ComputerName = $env:computername
 
#------------------------------------------------------------------ 
# User Provided Variables 
#------------------------------------------------------------------  
 
# Path to store Backup, no backslash at end.
# Example: "\\servername\ShareName\Folder"
# The Computer Name will be appended to the path
# If you used the example above, the script will create a folder like this: \\servername\ShareName\Folder\ComputerName 
$BackupRootPath = "\\PFSV1\BackUp"

# Number of backups to retain (value of "0" equals disable rotation, keep no backups) 
$MaxBackup = 1

##### **********************************
##### Functions and Main Script Routine
##### **********************************

$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition

#------------------------------------------------------------------  
# Function to check if the Windows Backup Features are installed 
# Installs if not and loadds the Snapin 
#------------------------------------------------------------------  

function CheckForFeatures()
{
echo ""
echo "Checking to see if Windows Server Backup Features are installed"
echo ""
Import-Module ServerManager

$WSBBackupFeature = Get-WindowsFeature | Where-Object {$_.Name -eq "Windows-Server-Backup"} 
$WSBBackupFeatureTools = Get-WindowsFeature | Where-Object {$_.Name -eq "Windows-Server-Backup"}

If ($WSBBackupFeature.Installed -and $WSBBackupFeatureTools.Installed -eq "True")

    {
       echo ""
       echo "Loading Windows Server Backup"
       echo ""
       if ( (Get-PSSnapin -Name Windows.ServerBackup -ErrorAction SilentlyContinue) -eq $null ) { }
    }

else

    {
    echo ""
    echo "Installing Windows Server Backup Features"
    echo ""
    $InstallWSB = Add-WindowsFeature -Name Windows-Server-Backup -IncludeAllSubFeature
    If ($InstallWSB.Success) 
    	{
    	echo ""
    	echo "Windows Backup Features installed successfully"
    	echo ""
    	echo ""
	   	}
    	
    else {
            echo ""
            echo "Windows Backup Features not installed successfully"
            echo ""
            exit
         }
    }
}
  
#------------------------------------------------------------------  
# Function to compare the number of folders to retain with 
# $MaxBackup (Not called if $MaxBackup equals 0) 
#------------------------------------------------------------------  

function Rotation() 
	{
	echo ""
	echo "Starting Backup Rotation and Cleanup"
	echo ""
	$BackupFolderNameArchiveName = Get-Date -Format yyyy-MM-dd_hhmmss;
	$BackupFolderNameArchive = ($BackupRootPath+"\$ComputerName\Archive") 
	# Backup Archive folder creation 
	if(!(Test-Path -Path $BackupFolderNameArchive )){
		New-Item $BackupFolderNameArchive -Type Directory | Out-Null 
		}
	
	if ((Test-Path -path $FullBackupPath) -eq $True){
		Move-Item -Path $FullBackupPath $BackupFolderNameArchive | Out-Null
		Rename-Item $BackupFolderNameArchive"\Current" $BackupFolderNameArchiveName
		}        

	# List all backup folders 
	$Backups = @(Get-ChildItem -Path $BackupFolderNameArchive\*)

	#Number of backups folders
	$NbrBackups = $Backups.count
	echo ""
	echo "Number of existing backups at $BackupFolderNameArchive is $NbrBackups" 
	echo ""
		
	$i = 0
		 
	#Delete oldest backup folders
	while ($NbrBackups -gt $MaxBackup)
		{
		$Backups[$i] | Remove-Item -Force -Recurse -Confirm:$false
		$NbrBackups -= 1
		$i++
		}
	} 
  
#------------------------------------------------------------------ 
# Main Backup Routine
#------------------------------------------------------------------  

$LogFile = $scriptPath+"\FullBackup.log"

Start-Transcript -path $LogFile

# Check to see if Windows Server Backup Features are installed
CheckForFeatures

# Volumes to backup, defaults to All Volumes
# Reference: http://technet.microsoft.com/en-us/library/ee706679.aspx
# If you only want Critical Volumes, such as the System Reserved and C:, you could use Get-WBVolume -CriticalVolumes
$Volumes = Get-WBVolume -AllVolumes

# Example, to backup just Critical Volumes
# $Volumes = Get-WBVolume -CriticalVolumes

# Backup folder 
$FullBackupPath = ($BackupRootPath+"\$ComputerName\Current") 

# Execute rotation if enabled 
if ($MaxBackup -ne 0) 
	{ 
    	# If last backup was successful, execute the rotation function
		$jobs = Get-WBJob -Previous 1
		if ($jobs.HResult -eq 0)
			{
			Rotation
			}
	} 

# Backup folder creation 
if(!(Test-Path -Path $FullBackupPath )){
    New-Item $FullBackupPath -Type Directory | Out-Null 
}

$WBPolicy = New-WBPolicy 

Add-WBVolume -Policy $WBPolicy -Volume $Volumes

Add-WBSystemState -Policy $WBPolicy | Out-Null 
  
# Enable BareMetal functionnality (system state included)
# Reference: http://technet.microsoft.com/en-us/library/ee706681.aspx
Add-WBBareMetalRecovery -Policy $WBPolicy | Out-Null 
  
# Add Network Backup target 
$BackupLocation = New-WBBackupTarget -network ($FullBackupPath)
echo ""
echo "Backup Location is $BackupLocation"
echo ""
Add-WBBackupTarget -Policy $WBPolicy -Target $BackupLocation -force -WarningAction:SilentlyContinue | Out-Null 
  
# Make this a full VSS backup as opposed to a copy backup. 
# Reference: http://blogs.technet.com/b/filecab/archive/2008/05/21/what-is-the-difference-between-vss-full-backup-and-vss-copy-backup-in-windows-server-2008.aspx
Set-WBVssBackupOptions -policy $WBPolicy -vssfullbackup | Out-null

# Pause before continuing
echo ""
echo "Sleeping for 30 seconds, CTRL+C to abort"
echo ""
Start-Sleep 30

# Start capturing output
# Determine where the Script is being ran from for the log (start-transcript) file


# Backup folder creation 
if (!(Test-Path -path $BackupLocation))
	{
		New-Item $BackupLocation -type directory | Out-Null
	}

# Displays the backup settings prior to running the job.
echo ""
echo "Starting Backup Job with the following properties:"
$WBPolicy
echo ""

# Runs the backup task.
echo ""
echo "Starting Backup"
echo ""
Start-WBBackup -Policy $WBPolicy

# Stop capturing output
Stop-Transcript
```
