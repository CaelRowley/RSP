extends "res://world/scripts/state-machine.gd"

func _ready():
	.setStatesMap({
		"idle": $Idle,
		"move": $Move,
		"attack": $Attack,
	})
	
func _unhandled_input(event):
	if event.is_action_pressed("ui_left"):
		.changeState("idle")
		return
	if event.is_action_pressed("ui_right"):
		.changeState("move")
		return
	if event.is_action_pressed("ui_down"):
		statesStack.push_front("attack")
		.changeState("attack")
		return
	if event.is_action_pressed("ui_up"):
		.changeState("previous")
		return
