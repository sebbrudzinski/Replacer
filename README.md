# Replacer
Replacer is a PowerShell script that changes occurences of words in all files in the specified directory and optionally all its subdirectories

## Usage 
Change all occurrences of 2014 to 2015 in Documents directory and all its subdirectories

    & "C:\replacer.ps1" -directory C:\Documents -from 2014 -to 2015 -recursive 1

## Params:
* **-directory** *(optional)* The root directory to scan in (current directory, if not provided)
* **-from** The word to replace from in the files
* **-to** The word to replace to in the files
* **-recursive** *(optional)* Whether all the subdirectories will be scanned as well (false by default)
