extends Panel

func _ready():
	set_as_toplevel(true)

func _on_Player_stateChanged(statesStack):
	var statesNames = ''
	var numbers = ''
	var count = 0
	for state in statesStack:
		statesNames += state.get_name() + '\n'
		numbers += str(count) + '\n'
		count += 1

	$States.text = statesNames
	$Numbers.text = numbers

