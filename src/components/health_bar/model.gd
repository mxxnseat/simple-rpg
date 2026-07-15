extends Node2D
class_name HealthBarModel

var state: HealthBarState

func setup(h_state: HealthBarState):
	state = h_state
	
func take_damage(amount: int):
	state.increment_current_hp(-amount)
	
	if state.current_hp == 0:
		state.set_is_dead(true)

func regenerate(value: float) -> void:
	if state.is_dead:
		return
	state.increment_current_hp(value)
