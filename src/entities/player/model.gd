extends Node
class_name PlayerModel

var state: PlayerState

func setup(p_state: PlayerState) -> void:
	state = p_state

func is_dead() -> bool:
	return state.current_state == state.STATES.DEAD

func is_attacking() -> bool:
	return state.current_state == state.STATES.ATTACKING

func stop():
	state.velocity = Vector2.ZERO

func idle() -> void:
	if is_dead() or is_attacking():
		return
	stop()
	state.set_state(state.STATES.IDLE)

func move(direction: Vector2) -> void:
	if is_dead() or is_attacking():
		return
	state.velocity = direction * state.speed
	state.facing_direction = direction
	state.set_state(state.STATES.MOVING)

func die() -> void:
	stop()
	state.set_state(state.STATES.DEAD)

func attack() -> void:
	if is_dead() or is_attacking():
		return
	idle()
	state.set_state(state.STATES.ATTACKING)

func finish_attack() -> void:
	if not is_attacking():
		return
	state.set_state(state.STATES.IDLE)

func velocity() -> Vector2:
	return state.velocity
