extends Node2D
class_name PickupModel

var state: PickupState

func setup(p_state: PickupState):
	state = p_state

func pickup() -> bool:
	if state.is_picked_up:
		return false
	state.is_picked_up = true
	return true
