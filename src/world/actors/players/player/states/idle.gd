extends 'res://world/scripts/state.gd'

func enter():
	owner.get_node("AnimationTree").set("parameters/Idle/blend_position", owner.direction)
	owner.get_node("AnimationTree").get("parameters/playback").travel("Idle")

func _handleInput(event):
	if Vector2(
		event.get_action_strength('move_right') - event.get_action_strength('move_left'),
		event.get_action_strength('move_down') - event.get_action_strength('move_up')
	):
		emit_signal('stateFinished', 'move')
	if event.is_action_pressed("evade"):
		emit_signal('stateFinished', 'evade')
	if event.is_action_pressed("attack"):
		emit_signal('stateFinished', 'attack')