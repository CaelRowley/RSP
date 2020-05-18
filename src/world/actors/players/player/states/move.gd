extends 'res://world/scripts/state.gd'

const MAX_SPEED = 120
const ACCELERATION = 300
const FRICTION = 400

func _handleInput(event):
	if event.is_action_pressed("evade"):
		emit_signal('stateFinished', 'evade')

func _update(delta):
	var inputVector = Vector2(
		Input.get_action_strength('ui_right') - Input.get_action_strength('ui_left'),
		Input.get_action_strength('ui_down') - Input.get_action_strength('ui_up')
	).normalized()

	if inputVector == Vector2.ZERO:
		# Replace with a skid animation
		owner.get_node("AnimationTree").set("parameters/Idle/blend_position", owner.direction)
		owner.get_node("AnimationTree").get("parameters/playback").travel("Idle")
		if owner.velocity == Vector2.ZERO:
			emit_signal('stateFinished', 'idle')
			return
		owner.velocity = owner.velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		owner.move_and_slide(owner.velocity)
		return

	owner.get_node("AnimationTree").set("parameters/Move/blend_position", inputVector)
	owner.get_node("AnimationTree").get("parameters/playback").travel("Move")

	owner.direction = inputVector
	owner.velocity = owner.velocity.move_toward(inputVector * MAX_SPEED, ACCELERATION * delta)
	owner.move_and_slide(owner.velocity)
