extends Button

@export var position_item: Vector2
@export var id_anchor_interactible: Array[int]

var click_offset: Vector2
var item_above_target: bool = false
var screen_limit: Vector2
var new_position: Vector2
var area_reference: Area2D
var tool_used: bool = false
var current_anchor_id: int

@onready var minigame_window: Control = get_parent()

func _ready() -> void:
	screen_limit = minigame_window.size - size
	global_position = position_item

func _physics_process(delta: float) -> void:
	if button_pressed:
		global_position = get_global_mouse_position() - click_offset
	
	global_position.x = clamp(global_position.x, 0 , screen_limit.x)
	global_position.y = clamp(global_position.y, 0 , screen_limit.y)

func _on_interact() -> void:
	click_offset = get_global_mouse_position() - global_position

func _on_collision_area_area_entered(area: Area2D) -> void:
	if id_anchor_interactible.has(area.anchor_id ):
		item_above_target = true
		new_position = area.global_position - (size / 2)
		area_reference = area

func _on_collision_area_area_exited(area: Area2D) -> void:
	item_above_target = false

func _on_button_up() -> void:
	if item_above_target:
		if area_reference.piece_is_on and area_reference.is_fixed == false:
			print("ça marche")
			area_reference.is_fixed = true
	global_position = position_item
