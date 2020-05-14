extends 'res://world/scripts/state.gd'

const FRICTION = 400

func enter():
	print('enter idle')

func exit():
	print('exit idle')

func _handleInput(event):
	if Vector2(
		event.get_action_strength('ui_right') - event.get_action_strength('ui_left'),
		event.get_action_strength('ui_down') - event.get_action_strength('ui_up')
	):
		emit_signal('stateFinished', 'move')
