# ### Feature
# - todo summary
# 
# ### Dependency
# - PowerShell 7.3.1
#
# ### usage
# ./todo/summary.ps1 -absoluteDir <絶対パス>

Param(
  [Parameter(Mandatory=$true)] [string] $absoluteDir
)

function summary {
  param(
    [Parameter(Mandatory=$true)] [object] $todo
  )
  $res = [System.Collections.ArrayList]::new()
  foreach ($i in ($todo | group-object -property filename | select name)) {
    $tmp = $todo | where {$_.filename -eq $i.name}
    $resObj = New-Object -TypeName PSObject -Property @{
      undone = ($tmp  | where {$_.line -like "- *"} | measure).count
      all = ($tmp | measure).count
      name = $tmp.path.split($absoluteDir)[1]
    }
    [void]$res.add($resObj)
  }
  return $res
}

function display {
  param(
    [Parameter(Mandatory=$true)] [object] $summary
  )
  $summary | select undone, all, name
}

# main
$corePath = join-path ($MyInvocation.MyCommand.path | Split-Path -Parent | Split-Path -Parent) core
$todo = . (join-path $corePath todolist.ps1) -dir $absoluteDir
$summary = summary $todo
display $summary
