# ### Feature
# - 全てのtodoのMicrosoft.PowerShell.Commands.MatchInfoを取得
# 
# ### Dependency
# - PowerShell 7.3.1
#
# ### usage
# ./core/todolist.ps1 -dir tests
# ./core/todolist.ps1 -dir tests -exclude ep1

Param(
  [Parameter(Mandatory=$true)] [string] $absoluteDir,
  [string[]] $excludeDirList = @()
)
if (test-path $absoluteDir) {
  get-childitem -dir $absoluteDir -exclude $excludeDirList | get-childitem -recurse | select-string -pattern "^[-x].*"
}
