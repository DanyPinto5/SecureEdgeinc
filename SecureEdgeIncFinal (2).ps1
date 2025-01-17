Import-Module ActiveDirectory

$users = Import-Csv -Path "C:\Users\Administrator\Desktop\teste.csv"

$users | ForEach-Object {

    $FirstName = $_.FirstName
    $LastName = $_.LastName
    $Username = $_.Username
    $Password = $_.Password
    $Department = $_.Department
    $Jobrole = $_.Jobrole

    $OU = "OU=$Department,DC=SecureEdgeInc,DC=local" 
            
Try {
    Get-ADUser -SearchBase "DC=SecureEdgeInc,DC=local" -Filter * | ForEach-Object {
    New-ADUser -SamAccountName $Username -UserPrincipalName "$Username@SecureEdgeInc.local" -Name "$FirstName $LastName" -GivenName "$FirstName" -Surname "$LastName" -AccountPassword (ConvertTo-SecureString $Password -AsPlainText -Force) -Department "$Department" -Title "$Jobrole" -Path "$OU" -Enabled $true -ChangePasswordAtLogon $true 
    }
}

Catch {
    if ($username -eq $true){
         }
}

        Write-Host "Created user: $FirstName $LastName $Username in $OU : $Department $Jobrole"
    }
