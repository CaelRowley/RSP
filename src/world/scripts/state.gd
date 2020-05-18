extends Node

# warning-ignore:unused_signal
signal stateFinished(nextState)

# Initialize the state. E.g. change the animation
func enter():
	return

# Clean up the state. Reinitialize values e.g. a timer
func exit():
	return

#  Called each tick of _unhandled_input()
func _handleInput(_event):
	return

func _onAnimationFinished(_animName):
	return

# Called each tick of _physics_process()
func _update(_delta):
	return
