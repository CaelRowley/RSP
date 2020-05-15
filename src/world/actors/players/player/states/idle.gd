extends 'res://world/scripts/state.gd'

func enter():
	owner.get_node("AnimationTree").get("parameters/playback").travel("Idle")
	owner.get_node("IdleSprite").show()

func exit():
	owner.get_node("IdleSprite").hide()

func _handleInput(event):
	if Vector2(
		event.get_action_strength('ui_right') - event.get_action_strength('ui_left'),
		event.get_action_strength('ui_down') - event.get_action_strength('ui_up')
	):
		emit_signal('stateFinished', 'move')
