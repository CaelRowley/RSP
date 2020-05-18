extends 'res://world/scripts/state-machine.gd'

var velocity = Vector2.ZERO

func _ready():
	.setStatesMap({
		'idle': $Idle,
		'move': $Move,
		'evade': $Evade,
		'attack': $Attack,
	})
