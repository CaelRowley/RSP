extends 'res://world/scripts/state.gd'

const EVADE_SPEED = 200

func enter():
	owner.get_node("AnimationTree").set("parameters/Evade/blend_position", owner.direction)
	owner.get_node("AnimationTree").get("parameters/playback").travel("Evade")

func exit():
	owner.velocity = Vector2.ZERO

func _update(_delta):
	owner.move_and_slide(owner.direction * EVADE_SPEED)

func _onAnimationFinished(_animName):
	emit_signal('stateFinished', 'move')