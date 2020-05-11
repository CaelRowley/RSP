extends Node

class_name StateMachine

var currentState = null setget setState
var previousState = null
var states = {}

onready var parent = get_parent()

func _physics_process(delta):
	if currentState != null:
		_stateLogic(delta)
		setState(_getTransition(delta))
		
func _stateLogic(_delta):
	pass

func _getTransition(_delta):
	return null

func _onEnterState(_newState, _oldState):
	pass
	
func _onExitState(_oldState, _newState):
	pass
	
func setState(newState):
	if newState != null:
		previousState = currentState
		currentState = newState
		if previousState != null:
			_onExitState(previousState, newState)
		_onEnterState(newState, previousState)

func addState(newState):
	states[newState] = states.size()
