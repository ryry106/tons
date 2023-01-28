# ### Feature
# - todo集計スクリプト
# 
# ### Dependency
# - PowerShell 7.3.1

Param(
    [Parameter(Mandatory=$true)] [string] $d_or_u,
    [string] $searchKeyword
)

$config = @{
  target = "misc"
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
    [string] $d_or_u
  )
  process {
    $expr = "- *"
    if ($d_or_u -eq "d") {
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


$all = get-alltodo $config.target

$res = filter-status $all $d_or_u

$res = filter-keyword $res $searchKeyword

$res




foreach ($i in ($all | group-object -property filename | select name)) {
  $tmp = $all | where {$_.filename -eq $i.name}
  $tmpAllCount = ($tmp | measure).count
  $tmpUnDoneCount = ($tmp  | where {$_.line -like "- *"} | measure).count
  $tmpUnDoneCount, $tmpAllCount, $i.name -join " | "
}

