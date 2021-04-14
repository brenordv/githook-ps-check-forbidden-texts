# Checking source for forbidden strings.
A simple script to check all .TS files for pre-configured strings.
It's pre-configured to check for the word ```debugger``` and ```console.*```. 

## Notes
This script was made to work with Angular (*.ts) files, but this can be easly changed.


# How to use
Add the following code to the ```pre-push``` hook:
```shell
#!/bin/sh
scriptDir=$(PWD)/ci/hooks/Check-HasForbiddenStrings.ps1
exec powershell.exe -NoProfile -ExecutionPolicy Bypass -File $scriptDir -path $(PWD)
```

The example above runs a powershell script that's located on ```<repo folder>/ci/hooks```. If yours is in a different path, feel free to change it.

In all my tests, PWD returned the repo path. I'm not sure if this will happen if it's a bare repo.

# This repo url
https://github.com/brenordv/githook-ps-check-forbidden-texts