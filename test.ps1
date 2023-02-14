echo "-- gantt test --"
$inputObj = ./misc/dummy-gantt-input.ps1
./gantt.ps1 -inputObj $inputObj -title sample

echo "-- test --"
./todo.ps1 misc s | out-string
./todo.ps1 misc d | out-string

echo "-- tests --"
./todo.ps1 misc  | out-string
./todo.ps1 misc  s a story1 | out-string
./todo.ps1 misc  s a s2 | out-string

echo "-- testd --"
./todo.ps1 misc d | out-string
./todo.ps1 misc d a | out-string
./todo.ps1 misc d u | out-string
./todo.ps1 misc d d | out-string
./todo.ps1 misc d a story1 | out-string
./todo.ps1 misc d a s2 | out-string
