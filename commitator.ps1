# PowerShell version for Windows

# Setting repository
$repo = Read-Host "Enter your repository link"
Write-Host "Your link is $repo"

# Folder creation
$folder = Read-Host "Enter the name you wish the repo folder to be"
Write-Host "Making repo..."
New-Item -Path . -Name $folder -ItemType "directory" 2>&1
Set-Location -Path $folder 2>&1

# Max commits per day
$max = Read-Host "Enter the max number of commits you'd like in a day"

# Days application
[int]$days = Read-Host "Please, specify the number of days to be applied"
$date = [DateTimeOffset]::Now.ToUnixTimeSeconds()

# GIT initialization
Write-Host "Initialize git..."
git init

# Contribution generation
Write-Host "Generating fake contributions..."

for ($i = $days; $i -ge 0; $i--){
    $rand = (Get-Random) % $max +1
    foreach ($j in (1..$rand)){
        $filename="${i}_${j}"

        $new_date = $date - ($i * 60*60*24)

        New-Item -Path . -Name $filename -ItemType "file"
        git add $filename
        git commit --date="$new_date" -m "$filename" 2>&1
    }
}

git remote add origin $repo
git push origin master