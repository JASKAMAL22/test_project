param (
    # Name of the Source Tag
    $SourceTag
)
git config --global user.name 'Paramjit' 
git config --global user.email 'params@cloudeqs.com'
git config pull.rebase false
git config --list
git branch
git status
Write-Host "testing the git tag list"
git tag
Write-Host "testing after git tag"

Write-Host "##change Executing git pull on $($SourceTag)"
git pull origin release

git fetch --tags --force


Write-Host "getting commit id for $($SourceTag)"

$logOutput2 = git log -n 1 $SourceTag
Write-Host $logOutput2

$commitid = (git log -n 1 $SourceTag)[0].split(" ")[-1]


Write-Host "commit id is $($commitid)"
#git show --name-only $commitid
Write-Host "git log pretty" 
git log --pretty="" --diff-filter=d --name-only $SourceTag -m -1


Write-Host "git diff tree"       #--name-only   show only names of changed files OR --name-status show names and status of changed files.
#git diff-tree
git diff-tree --no-commit-id --name-only $commitid

Write-Host "git diff tree name only NW"
git diff-tree --name-only $commitid
Write-Host "git diff tree name only -r Not working"
git rev-parse --show-cdup
git diff-tree -r --no-commit-id --name-only $commitid



$files=git diff-tree --no-commit-id --name-only -r $commitid
Write-Host "files is $($files)"
$ch=git checkout $commitid
Write-Host "Changed files:"
Write-Host $ch
#git whatchanged -1 #outputs all changes for all commits
Write-Host "Git commit -1"
git whatchanged $commitid -1



echo "ch_file==$ch" >> $env:GITHUB_ENV

# Store the changed file names in an environment variable
#$env:CHANGED_FILES = $changedFiles -join ","


echo "COMMIT_ID=$commitid" >> $env:GITHUB_ENV
