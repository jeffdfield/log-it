<#

.SYNOPSIS

  Function writes to log files so CMTrace can read them

.DESCRIPTION

  Function writes to log files so CMTrace can read them

.PARAMETER message

    The message you want to write to the log

.PARAMETER component

    The component that wrote to the log

.PARAMETER path

    The path of the log file, written like "c:\temp"

.PARAMETER logname

    The name of the log, wirrent like "test.log"

.INPUTS

  None

.OUTPUTS

  Log file stated in the commandlet

.NOTES

  Version:        1.0

  Author:         Jeffery Field

  Creation Date:  July 13th 2020

  Purpose/Change: Initial script development

  

.EXAMPLE

  log-it -message "message testing" -component "One-X-Script" -path "C:\Temp\" -logname "test.log"

#>

Function log-it {

[CmdletBinding()]

param(

[Parameter(Mandatory=$true)]

[string]$message,

[Parameter(Mandatory=$true)]

[string]$component,

[Parameter(Mandatory=$true)]

[string]$path,

[Parameter(Mandatory=$true)]

[string]$logname,

$thread = "0", $file = "N/A"
)

#Tests the folder path and creates it. If it can't create it we stop the script

$Pathexists = test-Path $path

if($Pathexists -eq $false){

    try{

    New-Item -Path $path -ItemType directory -Force

       }catch{

        Write-Host "unable to make log path"

        Start-Sleep -Seconds 15

        exit

        }

}

[string]$time = Get-Date -format "HH:mm:ss.fff+300"

[string]$date = Get-Date -Format "MM-dd-yyyy"

$a = "<![LOG["

$b = "]LOG]!>"

$carrot = "<"

$closecarrot = ">"

$c = "time=""$time"" date=""$date"" component=""$component"" context="""" type=""1"" thread=""$thread"" file=""$file"""

$logentry =  $a+$message+$b+$carrot+$c+$closecarrot

Add-Content -Path $path\$logname -Value $logentry

}