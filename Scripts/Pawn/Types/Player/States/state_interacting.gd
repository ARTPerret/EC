extends PawnState

var in_minigame: bool = false

func _ready() -> void:
	Dialogic.timeline_ended.connect(onTimelineEnded)
	EventBus.add_signal("block_player_state", set_in_minigame)

func enter(pawn: Pawn) -> void:
	pawn.navigationAgent.avoidance_enabled = false
	
func exit(pawn: Pawn) -> void:
	pawn.navigationAgent.avoidance_enabled = true

func step(pawn: Pawn, _delta: float) -> void:
	var currentAgentPostion: Vector2 = global_position
	var nextPathPosition: Vector2 = to_local(pawn.navigationAgent.get_next_path_position()).normalized()
	var new_velocity = nextPathPosition * pawn.SPEED
	
	if pawn.navigationAgent.avoidance_enabled:
		pawn.navigationAgent.set_velocity(new_velocity)
	else:
		pawn._on_navigation_agent_2d_velocity_computed(new_velocity)

func animate(pawn: Pawn, _delta: float) -> void:
	if (pawn.get_real_velocity()):
		pawn.skin.set_animation_state(PawnSkin.ANIMATION_STATES.walk)
		pawn.skin.set_animation_direction(pawn.get_real_velocity())
	else:
		pawn.skin.set_animation_state(PawnSkin.ANIMATION_STATES.idle)

func onTimelineEnded() -> void:
	if in_minigame == false:
		get_parent().change_state("Regular")

func set_in_minigame(arg: bool):
	in_minigame = arg
