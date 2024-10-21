$departments = @("Sales", "Marketing", "IT", "Finance", "Human Resources")

$names = Get-Content -Path "randomNames.txt"
$output = @()

foreach ($name in $names) {
    $nameParts = $name -split ' '
    $firstName = $nameParts[0]
    $lastName = $nameParts[1]

    $randomDept = Get-Random -InputObject $departments

    $userEntry = "$firstName $lastName $randomDept"
    $output += $userEntry
}

$output | Out-File -FilePath "userList.txt"