# ### Feature
# - todo集計スクリプト
# 
# ### Dependency
# - PowerShell 7.3.1
#
# ### usage
# pwsh todo.ps1 s
# pwsh todo.ps1 d

Param(
  [string] $mode = "s", # samary / detail
  [string] $adu = "a", # all / done / undoneを指定
  [string] $searchKeyword
)

$config = @{
  dir = "misc"
}

function get-alltodo {
  param(
    [string] $path
  )
  process {
    return select-string -path "${path}/*" -pattern "^[-x].*"
  }
}

function filter-status {
  param(
    [Parameter(Mandatory=$true)] [object] $todo,
    [string] $adu
  )
  process {
    if ($adu -eq "a") {
      return $todo
    }

    $expr = "- *"
    if ($adu -eq "d") {
      $expr = "x *"
    }
    return $todo | where {$_.line -like $expr}
  }
}


function filter-keyword {
  param(
    [Parameter(Mandatory=$true)] [object] $todo,
    [string] $keyword
  )
  process {
    if ($keyword -ne "") {
      return $todo | where {$_.line -like "*${keyword}*" -or $_.filename -like "*${keyword}*"}
    }
    return $todo
  }
}

function display-detail {
  param(
    [Parameter(Mandatory=$true)] [object] $todo
  )
  process {
    $todo
  }
}

function display-summary {
  param(
    [Parameter(Mandatory=$true)] [object] $todo
  )
  process {
    foreach ($i in ($todo | group-object -property filename | select name)) {
      $tmp = $todo | where {$_.filename -eq $i.name}
      New-Object -TypeName PSObject -Property @{
        undone = ($tmp  | where {$_.line -like "- *"} | measure).count
        all = ($tmp | measure).count
        name = $i.name
      } | select undone, all, name
    }
  }
}

function main {
  param(
    [Parameter(Mandatory=$true)] [object] $mode
  )
  $all = get-alltodo $config.dir

  $filtedKw = filter-keyword $all $searchKeyword
  $filted = filter-status $filtedKw $adu

  if ($mode -eq "s") {
    display-summary $filtedKw
  } else {
    display-detail $filted
  }
}

main $mode
