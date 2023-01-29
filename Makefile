test:
	pwsh todo.ps1 s
	pwsh todo.ps1 d

tests:
	pwsh todo.ps1
	pwsh todo.ps1 s a story1
	pwsh todo.ps1 s a s2

testd:
	pwsh todo.ps1 d
	pwsh todo.ps1 d a
	pwsh todo.ps1 d u
	pwsh todo.ps1 d d
	pwsh todo.ps1 d a story1
	pwsh todo.ps1 d a s2
