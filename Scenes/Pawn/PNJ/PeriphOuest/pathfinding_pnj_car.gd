extends PawnState

func step(pawn: Pawn, _delta: float) -> void:
	var nextPathPosition: Vector2 = to_local(pawn.navigationAgent.get_next_path_position()).normalized()
	var new_velocity = nextPathPosition * pawn.SPEED
	
	#pawn.navigationAgent.set_velocity(new_velocity)
	pawn.velocity = new_velocity
	pawn.move_and_slide()

func animate(pawn: Pawn, _delta: float) -> void:
	if (pawn.get_real_velocity()):
		pawn.skin.set_animation_state(PawnSkin.ANIMATION_STATES.walk)
		pawn.skin.set_animation_direction(pawn.get_real_velocity())
	else:
		pawn.skin.set_animation_state(PawnSkin.ANIMATION_STATES.idle)
