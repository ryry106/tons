# 文字列の分割と取得
"this,is,a,pen".split(",")[2]
"this,is,a,pen".split(",")[1]

# filter
./misc/example-obj.ps1 | where { $_.head -eq "h2" }

# map
./misc/example-obj.ps1 | foreach { $_.body + "add" }
