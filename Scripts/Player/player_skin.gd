extends Sprite2D
class_name PlayerSkin

const ANIMATION_STATES: Dictionary = {
	"idle": 0,
	"walk": 1,
}

@onready var animation_tree: AnimationTree = $AnimationTree

var current_state: int

func set_animation_state(state: int) -> void:
	if state != current_state:
		current_state = state
		animation_tree.set("parameters/Transition/transition_request", current_state)

func set_animation_direction(direction: Vector2i) -> void:
	animation_tree.set("parameters/idle/Idle/blend_position", direction)
	animation_tree.set("parameters/walk/Walk/blend_position", direction)

func set_animation_speed(value: float) -> void:
	animation_tree.set("parameters/TimeScale/scale", value)
