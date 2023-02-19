# ### Feature
# - todo detail
# 
# ### Dependency
# - PowerShell 7.3.1
#
# ### usage
# ./todo/detail.ps1 -absoluteDir <絶対パス>
# ./todo/detail.ps1 -absoluteDir <絶対パス> -keyword xxxx

Param(
  [Parameter(Mandatory=$true)] [string] $absoluteDir,
  [string] $keyword = ""
)

# main
$corePath = join-path ($MyInvocation.MyCommand.path | Split-Path -Parent | Split-Path -Parent) core
$todo = . (join-path $corePath todolist.ps1) -absoluteDir $absoluteDir

if ($keyword -ne "") {
  $todo | where { $_.line -like "*${keyword}*" -or $_.path -like "*${keyword}*"}
} else {
  $todo
}
