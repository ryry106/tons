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
$res
