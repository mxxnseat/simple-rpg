extends Node2D
class_name HealthBarModel

signal died

var state: HealthBarState

func setup(h_state: HealthBarState):
	state = h_state
	
func take_damage(amount: int):
	var new_hp = max(state.current_hp - amount, 0)
	state.update_current_hp(new_hp)
	
	if new_hp == 0:
		emit_signal("died")
