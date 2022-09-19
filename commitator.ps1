# PowerShell version for Windows

$repo = Read-Host "Enter your repository link"
Write-Host "Your link is $repo"

$folder = Read-Host "Enter the name you wish the repo folder to be"

# Folder creation
Write-Host "Making repo..."
New-Item -Path . -Name $folder -ItemType "directory" 2>&1
Set-Location -Path $folder 2>&1

# git initialization
Write-Host "Initialize git..."
git init

$date = [DateTimeOffset]::Now.ToUnixTimeSeconds()

# Contribution geneGet-Date -Secondration
Write-Host "Generating fake contributions..."

for ($i = 365; $i -ge 0; $i--){
    $rand = (Get-Random) % 3 +1
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