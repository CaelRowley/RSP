extends Node

signal stateChanged(newState)

export(NodePath) var initialState
var statesMap = {}
var statesStack = []
var currentState = null
var isActive = false setget setIsActive

# Intialize state and connect stateFinished signals of all states
func _ready():
	print('test')
	for child in get_children():
		child.connect("stateFinished", self, "_changeState")
	initialize(initialState)

func _unhandled_input(event):
	currentState.handleInput(event)

func _physics_process(delta):
	currentState.update(delta)
	
func initialize(newState):
	setIsActive(true)
	statesStack.push_front(get_node(newState))
	currentState = statesStack[0]
	currentState.enter()
	emit_signal("stateChanged", statesStack)

func setIsActive(value):
	isActive = value
	set_physics_process(value)
	set_process_unhandled_input(value)
	set_block_signals(not value)
	if not isActive:
		statesStack = []
		currentState = null

func pushState(newState):
	if not isActive:
		return
	statesStack.push_front(statesMap[newState])
	_changeState(newState)
		
func _changeState(newState):
	if not isActive:
		return
	
	if newState == "previous":
		if statesStack.size() < 2:
			var error = str('ERROR: Cannot call previous state. statesStack.size(): ', statesStack.size(), ', node: ', get_parent().get_name())
			printerr(error)
			push_error(error)
			return
		statesStack.pop_front()
	else:
		statesStack[0] = statesMap[newState]
	
	currentState.exit()
	currentState = statesStack[0]

	if newState != "previous":
		currentState.enter()
		
	emit_signal("stateChanged", statesStack)
