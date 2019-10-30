function lookup {
    param([string]$username)
    Write-Host $username':'
        try {Get-ADUser $username -Properties * | Select-Object -Property EmailAddress, EmployeeType, extensionAttribute1, Department, PasswordLastSet | Format-List}
        catch {Write-Warning -Message "User not found" }
    }

$useTxtFile = Read-Host -Prompt 'Use a text file? Y/N'

If ($useTxtFile -ieq 'Y') { 
    Write-Host "Enter the file path - " -NoNewline
    $file = $Host.UI.ReadLine() 
    foreach($line in Get-Content $file) { lookup $line } 
    }
     
Else{
    $list = New-Object Collections.Generic.List[string]
    Write-Host 'Enter user name(s) or enter no data to start look up`n'
    $count = 1
    Do{
        $userIn = Read-Host -Prompt "Username $count"
        if($userIn -ne "") {$list.Add($userIn)}
        else{break}
        $count++
        }While($true)
     
     write-host "`n"
     For($i=0; $i -lt $list.count; $i++) {lookup $list[$i]} 
    } 


