extends PawnState

var canMove: bool = true

func step(pawn: Pawn, _delta: float) -> void:
	#Variables pour le pathfinding
	var currentAgentPostion: Vector2 = global_position
	var nextPathPosition: Vector2 = to_local(pawn.navigationAgent.get_next_path_position()).normalized()
	
	var new_velocity = nextPathPosition * pawn.SPEED
	pawn.navigationAgent.set_velocity(new_velocity)

func animate(pawn: Pawn, _delta: float) -> void:
	if (pawn.get_real_velocity()):
		pawn.skin.set_animation_state(PawnSkin.ANIMATION_STATES.walk)
		pawn.skin.set_animation_direction(pawn.get_real_velocity())
	else:
		pawn.skin.set_animation_speed(1.0)
		pawn.skin.set_animation_state(PawnSkin.ANIMATION_STATES.idle)
