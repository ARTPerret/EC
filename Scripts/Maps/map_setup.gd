extends Node2D
class_name Map

@export var background_color: Color
@export var camera_zoom: int = 4
@export var limit_left: int = 0
@export var limit_right: int = 10000
@export var limit_top: int = 0
@export var limit_bottom: int = 10000
@export var stream: AudioStreamSynchronized

var player: Player
var camera: Camera2D
var start_id: int = 0
var old_id_music: int

@onready var player_resource: PackedScene = preload("uid://cma8bt0crjux0")
@onready var camera_resource: PackedScene = preload("uid://cfutd05my7baa")
@onready var pause_ressource: PackedScene = preload("uid://bfwcj54nwr3on")


func _ready() -> void:
	initialize_scene()
	initialize_player()
	initialize_camera()
	initialize_pause()
	initialize_music()

func initialize_player() -> void:
	player = player_resource.instantiate()
	player.position = $StartPoints.get_child(start_id).position # Ordre du child important
	if get_node_or_null("Cutscenes"):
		$Cutscenes.player = player
	add_child(player)

func initialize_camera() -> void:
	camera = camera_resource.instantiate()
	camera.zoom = Vector2(camera_zoom,camera_zoom)
	camera.target = player
	camera.set_limits(limit_left, limit_right, limit_top, limit_bottom)
	add_child(camera)

func initialize_scene() -> void:
	RenderingServer.set_default_clear_color(background_color)
	y_sort_enabled = true
	FadeManager.trigger_fade(0, 0.25)
	
func initialize_pause() -> void:
	var pause = pause_ressource.instantiate()
	add_child(pause)
	
func initialize_music() -> void:
	AudioManager.fade_music(0,0)
	AudioManager.play_music(stream)
