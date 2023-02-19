# 文字列の分割と取得
"this,is,a,pen".split(",")[2]
"this,is,a,pen".split(",")[1]

# filter
../tests/example-obj.ps1 | where { $_.head -eq "h2" }

# map
../tests/example-obj.ps1 | foreach { $_.body + "add" }

# file hash
(get-filehash tableparser.html).hash

# date format
$18 = [DateTime]::ParseExact("02/18","MM/dd", $null);
$19 = [DateTime]::ParseExact("02/19","MM/dd", $null);

# date compare
if ($18.CompareTo($19) -lt 0) { echo "比較元 < 比較先 の場合は負の値" }
if ($19.CompareTo($18) -gt 0) { echo "比較元 > 比較先 の場合は正の値" }
if ($19.CompareTo($19) -eq 0) { echo "比較元 = 比較先 の場合は0" }
