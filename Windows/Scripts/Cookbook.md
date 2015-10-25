### All scripts from the book Windows Server 2012 automation with PowerShell cookbook


##### Vermenigvuldig getallen

Function Multiply-Numbers {  
Param($FirstNum, $SecNum)  
Try {  
Write-Host ($FirstNum * $SecNum)  
}  
Catch {   
  Write-Host "Error in function, present two numbers to multiply"  
  }   
}  


##### Bereken aantal dagen tot kerstmist

Function Get-DaysTilChristmas   
{  
<#  
$Christmas=Get-Date("25 Dec " + (Get-Date).Year.ToString() + " 7:00 AM")  
$Today = (Get-Date)  
$TimeTilChristmas = $Christmas - $Today  
Write-Host $TimeTilChristmas.Days "Days 'til Christmas"  
}
