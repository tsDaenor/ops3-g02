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
