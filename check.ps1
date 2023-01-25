Param(
    [Parameter(Mandatory=$true)] [string] $d_or_u,
    [string] $searchKeyword
)

$config = @{
  target = "misc"
}

function get-searchStatusExpr{
  param(
    [string] $d_or_u
  )
  process {
    $res = "^-.*"
    if ($d_or_u -eq "d") {
      $res = "^x.*"
    }
    return $res
  }
}

$searchStatusExpr = get-searchStatusExpr $d_or_u
foreach ($obj in (get-childitem -Path $config.target))
{
  $res = select-string -path $obj.fullname -pattern $searchStatusExpr
  if ($searchKeyword -ne "") {
    $res = $res | where {$_.line -like "*${searchKeyword}*" -or $_.filename -like "*${searchKeyword}*"}
  }
}

$res
