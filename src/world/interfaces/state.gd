class_name State
extends Node

signal stateFinished(nextState)

# Initialize the state. E.g. change the animation
func enter():
	return

# Clean up the state. Reinitialize values e.g. a timer
func exit():
	return

func handleInput(event):
	return

# Called each tick of _physics_process()
func update(delta):
	return
