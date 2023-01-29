# ### Feature
# - todo集計スクリプト
# 
# ### Dependency
# - PowerShell 7.3.1

Param(
    [string] $adu = "a", # all / done / undoneを指定
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

function display-todolist {
  param(
    [Parameter(Mandatory=$true)] [object] $todo
  )
  process {
    echo ""
    echo "-- todo list ---"

    $todo
  }
}

function display-summary {
  param(
    [Parameter(Mandatory=$true)] [object] $todo
  )
  process {
    echo ""
    echo "-- summary ---"
    foreach ($i in ($all | group-object -property filename | select name)) {
      $tmp = $all | where {$_.filename -eq $i.name}
      $tmpAllCount = ($tmp | measure).count
      $tmpUnDoneCount = ($tmp  | where {$_.line -like "- *"} | measure).count

      $tmpUnDoneCount, $tmpAllCount, $i.name -join " | "
    }
  }
}

function main {
  $all = get-alltodo $config.target

  $res = filter-status $all $adu
  $res = filter-keyword $res $searchKeyword

  display-todolist $res
  display-summary $all
}

main
