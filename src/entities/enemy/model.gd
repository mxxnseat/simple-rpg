extends Node
class_name EnemyModel

var state: EnemyState

func setup(e_state: EnemyState):
	state = e_state
	
func is_dead() -> bool:
	return state.current_state == state.STATES.DEAD
	
func stop() -> void:
	state.velocity = Vector2.ZERO

func idle():
	if is_dead():
		return
	stop()
	state.set_state(state.STATES.IDLE)

func chase(player: Player):
	if is_dead():
		return
	state.set_player(player)
	
func release_chase():
	if is_dead():
		return
	state.set_player(null)
	stop()
	state.set_state(state.STATES.IDLE)
	
func attack():
	if is_dead():
		return
	state.set_state(state.STATES.ATTACKING)

func die():
	stop()
	state.set_state(state.STATES.DEAD)
	
func move(current_position: Vector2):
	if not state.target_player or is_dead():
		return
	var direction = (state.target_player.global_position - current_position).normalized()
	state.move(direction)
	
func velocity() -> Vector2:
	return state.velocity
