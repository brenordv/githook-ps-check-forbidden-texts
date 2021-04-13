param (
    [string]$path
)

$sourcePath = Join-Path -Path $path -ChildPath "src"

Write-Host "Base working path:" $path -ForegroundColor Yellow
Write-Host "Source path:" $sourcePath -ForegroundColor Yellow

# Words that no TS file should have.
$forbiddenStrings = @("debugger\b", "console\.*\b")

# Exit code. Zero means success!
$LASTEXITCODE = 0 

# Recursively looking for every .ts file, starting from informed path.
Get-ChildItem -Path $sourcePath -Filter *.ts -Recurse -File | ForEach-Object {
    # Getting file content
    $fileContent = Get-Content $_.FullName

    # Saving results for that file in this variable.
    $fileResults = @()
    foreach ($word in $forbiddenStrings) {
        # Adding to file result if it contains any of the forbidden words.
        $fileResults += $fileContent | ForEach-Object{ $_ -match $word }
    }

    # If any of filrResults is True, than this file has a forbidden text...
    if ($fileResults -contains $true) {        
        # Notifying user
        Write-Host "The following file contains a forbidden string:" $_.FullName -ForegroundColor Red

        # Changing exit code to error.
        $LASTEXITCODE = 1
    }
}

# Exiting script.
exit $LASTEXITCODE