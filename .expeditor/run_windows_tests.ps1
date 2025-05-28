# Stop script execution when a non-terminating error occurs
$ErrorActionPreference = "Stop"

# This will run ruby test on windows platform

Write-Output "--- Bundle install and MSYS setup for Ruby on Windows"

Write-Output "--- Deleting the old gems, we keep getting caching errors"
gem uninstall --all --executables --force

# Start-Process -FilePath "c:\ruby31\msys64\msys2_shell.cmd" -ArgumentList "-defterm -no-start -c exit"
# Start-Sleep -Seconds 90 # Wait for MSYS to finish setting up
Write-Output "--- Where is my MSYS2 shell?"
$msysPath = gci -path c:\ -file msys2_shell.cmd -recurse -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Fullname
Write-Output "MSYS Ruby Path: $msysPath"
Write-Output "--- Setting up MSYS so it stops throwing missing keyring errors"
Start-Process -FilePath "$msysPath" -ArgumentList "-defterm -no-start -c exit" -Wait
Write-Output "--- Now Updating MSYS2"
$parentPath = Split-Path -Parent $msysPath
Start-Process -FilePath "$parentPath\usr\bin\pacman" -ArgumentList " -Suu --noconfirm" -Wait

Write-Output "--- Bundle Config"
bundle config --local path vendor/bundle
If ($lastexitcode -ne 0) { Exit $lastexitcode }

Write-Output "--- Bundle Install"
bundle install --jobs=7 --retry=3
If ($lastexitcode -ne 0) { Exit $lastexitcode }

Write-Output "--- Bundle Execute"

bundle exec rake
If ($lastexitcode -ne 0) { Exit $lastexitcode } 