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
# pwsh gantt.ps1 > result.html

$config = @{
  ganttTitle = "sample"
  datetimeFormat = "YYYY-MM-DD"
  eol = "`n"
}

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
    $res += $config.eol
    $res += "  title " + $config.ganttTitle + $config.eol
    $res += "  dateFormat " + $config.datetimeFormat + $config.eol
    $res += "  section Section" + $config.eol
    $res += $config.eol
    foreach($task in $tasks) {
      $res += $task.name + ":" + $task.name + "," + $task.start + "," + $task.end + $config.eol
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


function dummy {
  $res = [System.Collections.ArrayList]::new()
  $tmp = New-Object -TypeName PSObject -Property @{
    name = "task1"
    start = "2014-01-01"
    end = "2014-01-02"
  }
  [void]$res.add($tmp)
  $tmp = New-Object -TypeName PSObject -Property @{
    name = "task2"
    start = "2014-01-02"
    end = "2014-01-03"
  }
  [void]$res.add($tmp)
  return $res
}


function main {
  $tmp = dummy
  template $tmp
}
main
