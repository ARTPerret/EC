extends PawnState

var in_minigame: bool = false

func _ready() -> void:
	Dialogic.timeline_ended.connect(onTimelineEnded)
	EventBus.add_signal("block_player_state", set_in_minigame)

func animate(player: Pawn, _delta: float) -> void:
	player.skin.set_animation_state(PawnSkin.ANIMATION_STATES.idle)

func onTimelineEnded() -> void:
	if in_minigame == false:
		get_parent().change_state("Regular")

func set_in_minigame(arg: bool):
	in_minigame = arg
