$res = [System.Collections.ArrayList]::new()
$tmp = New-Object -TypeName PSObject -Property @{
  str1 = "this is a pen"
  str2 = "xxxx"
  num = 1
}
[void]$res.add($tmp)
$tmp = New-Object -TypeName PSObject -Property @{
  str1 = "that is cat"
  str2 = "yyyy"
  num = 2
}
[void]$res.add($tmp)
$tmp = New-Object -TypeName PSObject -Property @{
  str1 = "there is place"
  str2 = "zzzz"
  num = 3
}
[void]$res.add($tmp)
$res
