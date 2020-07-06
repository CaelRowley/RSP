extends Node

signal stateChanged(newState)

export(NodePath) var initialState
var statesMap = {} setget setStatesMap
var statesStack = []
var isActive = false setget setIsActive
var currentState = null

# Intialize state and connect changeState signals of all child states
func _ready():
	for child in get_children():
		child.connect('changeState', self, 'changeState')
	initialize(initialState)

# Pass user input event to the current state node
func _unhandled_input(event):
	currentState._handleInput(event)

# Pass physics process to the current state node
func _physics_process(delta):
	currentState._update(delta)

# Pass signal callback to the current state node
func _onAnimationFinished(animName):
	currentState._onAnimationFinished(animName)

func initialize(newState):
	setIsActive(true)
	statesStack.push_front(get_node(newState))
	currentState = statesStack[0]
	currentState._enter()
	emit_signal('stateChanged', statesStack)

func setStatesMap(newStatesMap):
	statesMap = newStatesMap

func setIsActive(value):
	isActive = value
	set_physics_process(value)
	set_process_unhandled_input(value)
	set_block_signals(not value)
	if not isActive:
		statesStack = []
		currentState = null

func changeState(newState):
	if not isActive:
		return

	if newState == 'previous':
		# Cannot access previous state if there is only 1 state
		if statesStack.size() <= 1:
			var error = str(
				'ERROR (node: ', get_parent().get_name(), '):',
				'Cannot call previous state. statesStack.size(): ', statesStack.size()
			)
			printerr(error)
			push_error(error)
			return
		statesStack.pop_front()
	else:
		statesStack[0] = statesMap[newState]

	currentState._exit()
	currentState = statesStack[0]

	# Should not call enter() when returning to a previous state
	if newState != 'previous':
		currentState._enter()

	emit_signal('stateChanged', statesStack)
