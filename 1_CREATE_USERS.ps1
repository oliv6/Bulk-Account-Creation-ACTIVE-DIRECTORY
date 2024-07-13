# Passwords for all accounts will be the same#
$OnePasswordForAll   = "Gooduser@3"
$UserAccountList = Get-Content .\Account-Users.txt

$password = ConvertTo-SecureString $OnePasswordForAll -AsPlainText -Force
New-ADOrganizationalUnit -Name _FORUSERS -ProtectedFromAccidentalDeletion $false

#User Count
$count = 1

foreach ($f in $UserAccountList) {

    $first = $f.Split(" ")[0].ToLower()
    $last = $f.Split(" ")[1].ToLower()
    $user = "$($first)$($last.Substring(0,1).ToUpper())"
    
    Write-Host "User-Account #$($count) : $($user)" -BackgroundColor Black -ForegroundColor Green
    
    New-AdUser -AccountPassword $password ` -GivenName $first ` -Surname $last `
               -DisplayName $user ` -Name $user ` -EmployeeID $user `
               -PasswordNeverExpires $true `
               -Path "ou=_FORUSERS,$(([ADSI]`"").distinguishedName)" `
               -Enabled $true
    $count = ($count) + 1
    
}