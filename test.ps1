# core/todolist.ps1
if (((./core/todolist.ps1 -dir tests).Length) -ne 9 -or ((./core/todolist.ps1 -dir tests -exclude ep1).Length -ne 3) -or ((./core/todolist.ps1 -dir tests -exclude dummy,ep2).Length -ne 6) -or ((./core/todolist.ps1 -dir dummy).length -ne 0)) {
  echo "todolist is fail."
}

# filter.ps1
$exampleObjA = ./misc/example-obj-a.ps1
if ((./filter.ps1 $exampleObjA "is").Length -ne 3 -or (./filter.ps1 $exampleObjA "s i").Length -ne 1 -or (./filter.ps1 $exampleObjA "2").Length -ne 1 -or (./filter.ps1 $exampleObjA "y" -properties str1).Length -ne 0 -or (./filter.ps1 $exampleObjA "y" -properties str2).Length -ne 1) { echo "filter is fail." }

# gantt.ps1
$dummyGanttInput = ./misc/dummy-gantt-input.ps1
$actual = ./gantt.ps1 -inputObj $dummyGanttInput -title testgantt
if ($actual.Split("section1").length -ne 2 -or $actual.Split("section2").length -ne 2 -or $actual.Split("task1:001,2014-01-01,2014-01-02").length -ne 2 -or $actual.Split("task2:002,2014-01-02,2014-01-03").length -ne 2 -or $actual.Split("task3:003,2014-01-02,2014-01-03").length -ne 2) { echo "gantt is fail." }

# todo.ps1
$res = ./todo.ps1 misc
if (($res | where { ($_.undone -eq 2 -and $_.all -eq 3 -and $_.name -eq "story1.txt") -or ($_.undone -eq 1 -and $_.all -eq 3 -and $_.name -eq "story2.txt")}).count -ne 2) { echo "'./todo.ps1 misc' is fail" } 

$res = ./todo.ps1 misc s
if (($res | where { ($_.undone -eq 2 -and $_.all -eq 3 -and $_.name -eq "story1.txt") -or ($_.undone -eq 1 -and $_.all -eq 3 -and $_.name -eq "story2.txt")}).count -ne 2) { echo "'./todo.ps1 misc s' is fail" } 

$res = ./todo.ps1 misc  s a story1
if (($res | where { $_.undone -eq 2 -and $_.all -eq 3 -and $_.name -eq "story1.txt" }).count -ne 1) { echo "'./todo.ps1 misc  s a story1' is fail" } 

$res = ./todo.ps1 misc  s a s2
if (($res | where { $_.undone -eq 1 -and $_.all -eq 3 -and $_.name -eq "story2.txt" }).count -ne 1) { echo "'./todo.ps1 misc  s a s2' is fail" } 

$res = ./todo.ps1 misc d
if ($res.count -ne 6) { echo "'./todo.ps1 misc d' is fail" } 

$res = ./todo.ps1 misc d a
if ($res.count -ne 6) { echo "'./todo.ps1 misc d a' is fail" } 

$res = ./todo.ps1 misc d u
if ($res.count -ne 3) { echo "'./todo.ps1 misc d u' is fail" } 

$res = ./todo.ps1 misc d d
if ($res.count -ne 3) { echo "'./todo.ps1 misc d d' is fail" } 
