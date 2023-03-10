# runner.ps1
function runnerTest {
  $actual = ./runner.ps1 s
  if (
    ($actual | where { $_.name -eq "/ep1/story1.txt" -and $_.undone -eq 2 }).Length -ne 1 -or
    ($actual | where { $_.name -eq "/ep1/story2.txt" -and $_.undone -eq 1 }).Length -ne 1 -or
    ($actual | where { $_.name -eq "/ep2/story3.txt" -and $_.undone -eq 2 }).Length -ne 1 -or
    ($actual | where { $_.name -eq "/story0.txt" }).Length -ne 0
  ) { echo "runnerTest s is fail." }

  if (
    (./runner.ps1 d).Length -ne 9 -or
    (./runner.ps1 d task1).Length -ne 3 -or
    (./runner.ps1 d story1).Length -ne 3  -or
    (./runner.ps1 d ep1).Length -ne 6
  ) { echo "runnerTest d  is fail." }
}
runnerTest

# todo/detail.ps1
function todoDetailTest {
  if (
    (./todo/detail.ps1 -absoluteDir (join-path (pwd).Path tests/todolist)).Length -ne 9 -or
    (./todo/detail.ps1 -absoluteDir (join-path (pwd).Path tests/todolist) -keyword task1).Length -ne 3 -or
    (./todo/detail.ps1 -absoluteDir (join-path (pwd).Path tests/todolist) -keyword story1).Length -ne 3  -or
    (./todo/detail.ps1 -absoluteDir (join-path (pwd).Path tests/todolist) -keyword ep1).Length -ne 6
  ) { echo "todoDetailTest is fail." }
}
todoDetailTest

# todo/summay.ps1
function todoSummaryTest {
  $actual = ./todo/summary.ps1 -absoluteDir (join-path (pwd).Path tests/todolist)
  if (
    ($actual | where { $_.name -eq "/ep1/story1.txt" -and $_.undone -eq 2 }).Length -ne 1 -or
    ($actual | where { $_.name -eq "/ep1/story2.txt" -and $_.undone -eq 1 }).Length -ne 1 -or
    ($actual | where { $_.name -eq "/ep2/story3.txt" -and $_.undone -eq 2 }).Length -ne 1 -or
    ($actual | where { $_.name -eq "/story0.txt" }).Length -ne 0
  ) { echo "todoSummaryTest is fail." }
}
todoSummaryTest

# core/todolist.ps1
function coreTodolistTest {
  if (
    (./core/todolist.ps1 -absoluteDir tests/todolist).Length -ne 9 -or
    (./core/todolist.ps1 -absoluteDir tests/todolist -exclude ep1).Length -ne 3 -or
    (./core/todolist.ps1 -absoluteDir tests/todolist -exclude dummy,ep2).Length -ne 6 -or
    (./core/todolist.ps1 -absoluteDir dummy).length -ne 0
  ) { echo "coreTodolistTest is fail." }
}
coreTodolistTest

# core/filter.ps1
function coreFilterTest {
  $exampleObjA = ./tests/example-obj-a.ps1
  if (
    (./core/filter.ps1 $exampleObjA "is").Length -ne 3 -or
    (./core/filter.ps1 $exampleObjA "s i").Length -ne 1 -or
    (./core/filter.ps1 $exampleObjA "2").Length -ne 1 -or
    (./core/filter.ps1 $exampleObjA "y" -properties str1).Length -ne 0 -or
    (./core/filter.ps1 $exampleObjA "y" -properties str2).Length -ne 1
  ) { echo "coreFilterTest is fail." }
}
coreFilterTest

# gantt.ps1
function ganttTest {
  $dummyGanttInput = ./tests/dummy-gantt-input.ps1
  $actual = ./gantt/gantt.ps1 -inputObj $dummyGanttInput -title testgantt
  if (
    $actual.Split("section1").length -ne 2 -or
    $actual.Split("section2").length -ne 2 -or
    $actual.Split("task1:001,2014-01-01,2014-01-02").length -ne 2 -or
    $actual.Split("task2:002,2014-01-02,2014-01-03").length -ne 2 -or
    $actual.Split("task3:003,2014-01-02,2014-01-03").length -ne 2
  ) { echo "ganttTest is fail." }
}
ganttTest
