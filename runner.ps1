# ### Feature
# - runner
# 
# ### Dependency
# - PowerShell 7.3.1
#
# ### usage
# ./runner.ps1 s
# ./runner.ps1 d xxx

Param(
  [Parameter(Mandatory=$true)] [string] $mode = "s",
  [string] $opt = ""
)

$config = ./config.ps1

if ( $mode -eq "s" ) {
  ./todo/summary.ps1 -absoluteDir $config.workDir
} elseif ($mode -eq "d") {
  ./todo/detail.ps1 -absoluteDir $config.workDir -keyword $opt
} else {
  "no mode"
}
