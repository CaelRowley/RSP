extends StateMachine

func _ready():
	statesMap = {
		"idle": $Idle,
		"move": $Move,
	}

func _changeState(newState):
	._changeState(newState)
	
func _unhandled_input(event):
	if event.is_action_pressed("ui_left"):
		_changeState("idle")
		return
	if event.is_action_pressed("ui_right"):
		_changeState("move")
		return
	if event.is_action_pressed("ui_down"):
		statesStack.push_front($Move)
		return
	if event.is_action_pressed("ui_up"):
		_changeState("previous")
		return
