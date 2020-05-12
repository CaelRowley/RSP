class_name StateMachine
extends Node

signal stateChanged(newState)

export(NodePath) var initialState
var statesMap = {}
var statesStack = []
var currentState = null
var isActive = false setget setIsActive

# Intialize state and connect stateFinished signals of all states
func _ready():
	for child in get_children():
		child.connect("stateFinished", self, "_changeState")
	initialize(initialState)

func _unhandled_input(event):
	currentState.handleInput(event)

func _physics_process(delta):
	currentState.update(delta)
	
func initialize(initialState):
	setIsActive(true)
	statesStack.push_front(get_node(initialState))
	currentState = statesStack[0]
	currentState.enter()

func setIsActive(value):
	isActive = value
	set_physics_process(value)
	set_process_unhandled_input(value)
	set_block_signals(not value)
	if not isActive:
		statesStack = []
		currentState = null

func _changeState(newState):
	if not isActive:
		return
	currentState.exit()
	
	if newState == "previous":
		statesStack.pop_front()
	else:
		statesStack[0] = statesMap[newState]
	
	currentState = statesStack[0]
	emit_signal("stateChanged", newState)
	
	if newState != "previous":
		currentState.enter()
