extends StateMachine

func _ready():
	addState("idle")
	addState("move")
	call_deferred("setState", states.idle)
	
func _stateLogic(_delta):
	parent.handleInput()

func _getTransition(_delta):
	match currentState:
		states.idle:
			if Input.get_action_strength("ui_right"):
				return states.move
		states.move:
			if Input.get_action_strength("ui_left"):
				return states.idle
	
	return null

func _onEnterState(newState, _oldState):
	match newState:
		states.idle:
			print("enter states.idle")
		states.move:
			print("enter states.move")
	
func _onExitState(oldState, _newState):
	match oldState:
		states.idle:
			print("exit states.idle")
		states.move:
			print("exit states.move")
