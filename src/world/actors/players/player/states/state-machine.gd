extends "res://world/scripts/state-machine.gd"

func _ready():
	statesMap = {
		"idle": $Idle,
		"move": $Move,
		"attack": $Attack,
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
		pushState("attack")
		return
	if event.is_action_pressed("ui_up"):
		_changeState("previous")
		return
