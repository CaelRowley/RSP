extends 'res://world/scripts/state-machine.gd'

var velocity = Vector2.ZERO

func _ready():
	.setStatesMap({
		'idle': $Idle,
		'move': $Move,
		'attack': $Attack,
	})

# Handle input here for stateless or state interrupting inputs
func _unhandled_input(event):
	._unhandled_input(event)
