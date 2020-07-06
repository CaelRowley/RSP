extends 'res://world/scripts/state.gd'

func _enter():
	owner.get_node("AnimationTree").set("parameters/Attack/blend_position", owner.direction)
	owner.get_node("AnimationTree").get("parameters/playback").travel("Attack")

func _exit():
	owner.velocity = Vector2.ZERO

func _onAnimationFinished(_animName):
	emit_signal('changeState', 'move')