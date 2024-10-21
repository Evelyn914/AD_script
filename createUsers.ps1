Import-Module ActiveDirectory

$PASSWORD_FOR_USERS   = "Password12"
$USERLIST = Get-Content .\userList.txt
$password = ConvertTo-SecureString $PASSWORD_FOR_USERS -AsPlainText -Force

foreach ($user in $USERLIST) {
    $first = $user.Split(" ")[0].ToLower()
    $last = $user.Split(" ")[1].ToLower()
    $username = "$($first.Substring(0,1))$($last)".ToLower()
    $groupName = $user.Split(" ")[2]

    New-AdUser -AccountPassword $password `
               -GivenName $first `
               -Surname $last `
               -DisplayName $username `
               -Name $username `
               -EmployeeID $username `
               -PasswordNeverExpires $true `
               -Path "ou=Users,OU=USA,$(([ADSI]`"").distinguishedName)" `
               -Enabled $true
     Write-Host "Creating user: $($username)" -BackgroundColor Black -ForegroundColor Red

     Add-ADGroupMember -Identity $groupName -Members $username 
     Write-Host "User $($username) added to group $($groupName)" -BackgroundColor Black -ForegroundColor Red
}