test:
	pwsh todo.ps1 misc s
	pwsh todo.ps1 misc d

tests:
	pwsh todo.ps1 misc 
	pwsh todo.ps1 misc  s a story1
	pwsh todo.ps1 misc  s a s2

testd:
	pwsh todo.ps1 misc d
	pwsh todo.ps1 misc d a
	pwsh todo.ps1 misc d u
	pwsh todo.ps1 misc d d
	pwsh todo.ps1 misc d a story1
	pwsh todo.ps1 misc d a s2
