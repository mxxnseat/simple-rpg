extends Node
class_name PlayerModel

var state: PlayerState

func setup(p_state: PlayerState) -> void:
	state = p_state
	
func stop():
	state.velocity = Vector2.ZERO
	
func idle() -> void:
	if state.current_state == state.STATES.DEAD:
		return
	stop()
	state.set_state(state.STATES.IDLE)
	
func move(direction: Vector2) -> void:
	if state.current_state == state.STATES.DEAD:
		return
	state.velocity = direction * state.speed
	state.facing_direction = direction
	state.set_state(state.STATES.MOVING)

func die() -> void:
	stop()
	state.set_state(state.STATES.DEAD)
	
func attack() -> void:
	if state.current_state == state.STATES.DEAD:
		return
	state.set_state(state.STATES.ATTACKING)
	
func velocity() -> Vector2:
	return state.velocity
