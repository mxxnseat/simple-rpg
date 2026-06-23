extends Node2D
class_name PlayerInteractableModel

var state: PlayerInteractableState

func setup(pi_state: PlayerInteractableState) -> void:
	state = pi_state
	
func set_target(i_target: InteractableArea) -> void:
	state.target = i_target
	
func interact() -> void:
	if not state.target:
		return
	state.target.interact()
