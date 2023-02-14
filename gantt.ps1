# ### Feature
# - 以下の要素を持ったオブジェクト配列からガントチャートのhtmlを作成する
# @{
#     name = "task1"
#     start = "2014-01-01"
#     end = "2014-01-02"
#   }
# 
# ### Dependency
# - PowerShell 7.3.1
#
# ### usage
# ./gantt.ps1 -in $testobj -title sample > result.html

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
    $res += "  title " + $ganttTitle + $eol
    $res += "  dateFormat " + $datetimeFormat + $eol
    $res += "  section Section" + $eol
    $res += $eol
    foreach($task in $tasks) {
      $res += $task.name + ":" + $task.name + "," + $task.start + "," + $task.end + $eol
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
