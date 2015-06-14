# Replacer v0.1
# Copyright (c) 2015 Sebastian Brudzinski (https://github.com/sebbrudzinski)
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
# 
# Usage (Change all occurrences of 2014 to 2015 in Documents directory and all its subdirs)
# =========================================================================================
# & "C:\replacer.ps1" -directory C:\Documents -from 2014 -to 2015 -recursive 1
# =========================================================================================
# Params:
# -directory (optional) The root directory to scan in (current directory, if not provided)
# -from The word to replace from in the files
# -to The word to replace to in the files
# -recursive (optional) Whether all the subdirectories will be scanned as well (false by default)

param([string] $directory = (pwd), [string] $from, [string] $to, [boolean] $recursive = 0)
$welcome = "Hello! This is Replacer v0.1. Changing all occurences of $from to $to in $directory"
if ($recursive) {
	$welcome += " and all its subdirectories"
}
Write-Host $welcome

$directories = New-Object System.Collections.ArrayList
[void]$directories.Add($directory)

while($directories.count -gt 0) {
	$dir = $directories[0]
	Write-Host "Changed directory to $dir"
	cd $dir
	
	$files = Get-ChildItem -File $dir
	$count = $files.Count;
	
	Write-Host "$count files found"
	ForEach($file in $files) {
		Write-Host "Processing file $file"
		(gc $file) -replace $from,$to | Out-File $file
	}
	
	if ($recursive) {
		$newDirs = Get-ChildItem -Directory $dir
		ForEach($newDir in $newDirs) {
			[void]$directories.Add("$dir\$newDir")
		}
	}
	$directories.Remove("$dir")
}