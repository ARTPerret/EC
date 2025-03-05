extends CharacterBody2D
class_name Pawn

const SPEED: float = 50

@export var target: Array[Marker2D]

var curr_targ: int = 0

@onready var state_machine: StateMachine = $StateMachine
@onready var skin: PawnSkin = $Skin
@onready var navigationAgent: NavigationAgent2D = $NavigationAgent2D

func _ready() -> void:
	initialize_state_machine()
	actor_setup()

func initialize_state_machine() -> void:
	state_machine.initialize()

func _physics_process(delta):
	handle_state_update(delta)
	handle_state_animation(delta)

func actor_setup():
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame
	# Now that the navigation map is no longer empty, set the movement target.
	if target:
		set_movement_target(target[curr_targ].position)
	
func set_movement_target(movement_target: Vector2):
	navigationAgent.target_position = movement_target

func handle_state_update(delta: float) -> void:
	state_machine.update_state(delta)

func handle_state_animation(delta) -> void:
	state_machine.animate_state(delta)

func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity
	move_and_slide()

func _on_navigation_agent_2d_navigation_finished() -> void:
	curr_targ += 1
	set_movement_target(target[curr_targ].position)
