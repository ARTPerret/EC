extends Node2D
class_name StateMachine

@export var initial_state: String = "Regular"

@onready var player: Pawn = get_parent()

var states: Dictionary[String, Node2D]
var current_state: String
var last_state: String

func initialize() -> void:
	initialize_states()
	change_state(initial_state)

func initialize_states() -> void:
	for i in get_children():
		var new_state: Node2D = i
		states[i.name] = i

func change_state(to: String) -> void:
	if current_state:
		states[current_state].exit(player)
	
	last_state = current_state
	current_state = to
	states[current_state].enter(player)

func update_state(delta: float) -> void:
	if current_state:
		states[current_state].step(player, delta)

func animate_state(delta: float) -> void:
	if current_state:
		states[current_state].animate(player, delta)
