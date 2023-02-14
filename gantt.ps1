# ### Feature
# - 以下の要素を持ったオブジェクト配列からガントチャートのhtmlを作成する
# @{
#     section = "section1"
#     name = "task1"
#     start = "2014-01-01"
#     end = "2014-01-02"
#   }
# 
# ### Dependency
# - PowerShell 7.3.1
#
# ### usage
# ./gantt.ps1 -inputObj $testobj -title sample > result.html

Param(
  [Parameter(Mandatory=$true)] [object] $inputObj,
  [Parameter(Mandatory=$true)] [string] $title,
  [string] $datetimeFormat = "YYYY-MM-DD",
  [string] $eol = "`n"
)

function template {
  param(
    [Parameter(Mandatory=$true)] [System.Collections.ArrayList] $tasks
  )
  process {
    $res = 
  @'
<html lang="en">

<head>
  <meta charset="utf-8" />
</head>

<body>
  <div class="mermaid">
gantt
'@
    $res += $eol
    $res += "  title " + $title + $eol
    $res += "  dateFormat " + $datetimeFormat + $eol
    $res += $eol
    $sections = $tasks | format-table -hidetableheaders section | sort | unique |  where { $_ -ne "" }
    $num = 1
    foreach($section in $sections) {
      $res += "section " + $section  + $eol
      foreach($task in ($tasks | where { $_.section -eq $section })) {
        $id = Write-Output("{0:d3}" -f $num)
        $res += $task.name + ":" + $id + "," + $task.start + "," + $task.end + $eol
        echo "tsts"
        $num++
      }
    }
    $res +=  @'
  </div>
  <script type="module">
    import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid@9/dist/mermaid.esm.min.mjs';
    mermaid.initialize({startOnLoad: true});
  </script>
</body>

</html>
'@
    return $res
  }
}


function main {
  template $inputObj
}
main
