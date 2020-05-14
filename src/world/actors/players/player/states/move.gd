extends 'res://world/scripts/state.gd'

const MAX_SPEED = 100
const ACCELERATION = 400
const FRICTION = 400

func enter():
	print('enter move')

func exit():
	print('exit move')

func _update(delta):
	var inputVector = Vector2(
		Input.get_action_strength('ui_right') - Input.get_action_strength('ui_left'),
		Input.get_action_strength('ui_down') - Input.get_action_strength('ui_up')
	)

	if inputVector == Vector2.ZERO:
		if owner.velocity == Vector2.ZERO:
			emit_signal('stateFinished', 'idle')
			return
		owner.velocity = owner.velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		owner.move_and_slide(owner.velocity)
		return

	inputVector = inputVector.normalized()
	owner.velocity = owner.velocity.move_toward(inputVector * MAX_SPEED, ACCELERATION * delta)

	owner.move_and_slide(owner.velocity)
