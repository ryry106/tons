# ### Feature
# - inputObjのプロパティにkeyを含んでいるオブジェクトを返却する
# 
# ### Dependency
# - PowerShell 7.3.1
#
# ### usage
# ./filter.ps1 $inputObj "this"

Param(
  [Parameter(Mandatory=$true)] [object] $inputObj,
  [Parameter(Mandatory=$true)] [string] $key,
  [string[]] $properties
)

if ($properties.length -eq 0) {
  $properties = $inputObj | gm  | where { $_.MemberType -eq "NoteProperty" } | foreach { $_.name }
}

$inputObj | where { 
  $cat = ""
  foreach($prop in $properties) { $cat += $_.$prop }
  $cat -like "*${key}*"
}
