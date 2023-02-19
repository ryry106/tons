$res = [System.Collections.ArrayList]::new()
$tmp = New-Object -TypeName PSObject -Property @{
  head = "h1"
  body = "b1"
}
[void]$res.add($tmp)
$tmp = New-Object -TypeName PSObject -Property @{
  head = "h2"
  body = "b2"
}
[void]$res.add($tmp)
$tmp = New-Object -TypeName PSObject -Property @{
  head = "h3"
  body = "b3"
}
[void]$res.add($tmp)
$res
