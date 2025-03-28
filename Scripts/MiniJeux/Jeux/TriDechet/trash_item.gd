extends Node2D
class_name TrashItem

@export_enum("Recyclable", "Non Recyclable", "Verre") var type: int

var minigame_window: Control
var speed: int = 400

@onready var screen_limit: float = get_parent().size.y + 100 # Taille de la fenêtre moins la taille du bouton

func _physics_process(delta: float) -> void:
	position.y += speed * delta
	
	if position.y > screen_limit:
		minigame_window.update_score(-0.05)
		queue_free()
