extends CharacterBody2D
class_name Player

const SPEED: float = 50
const SPRINT_SPEED: float = 100

@onready var skin: PawnSkin = $Skin
@onready var state_machine: StateMachine = $StateMachine

var props_around: Array[Prop]

var input_direction: Vector2
var input_interact: bool

var curr_speed: float

func _ready() -> void:
	initialize_state_machine()

func _physics_process(delta: float) -> void:
	handle_state_update(delta)
	handle_state_animation(delta)

func initialize_state_machine() -> void:
	state_machine.initialize()

func handle_input() -> void:
	input_direction = Game.inputs.get_direction()

func handle_sprint() -> void:
	if (Game.inputs.is_sprinting()):
		curr_speed = SPRINT_SPEED
	else:
		curr_speed = SPEED

func handle_interact() -> void:
	if (Game.inputs.is_interacting()):
		if (props_around):
			props_around[props_around.size()-1].on_interact(self)

func handle_state_update(delta: float) -> void:
	state_machine.update_state(delta)

func handle_state_animation(delta) -> void:
	state_machine.animate_state(delta)
