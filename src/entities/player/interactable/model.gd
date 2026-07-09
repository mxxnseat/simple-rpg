extends Node2D
class_name PlayerInteractableModel

var state: PlayerInteractableState
var inventory_model: InventoryModel

func setup(pi_state: PlayerInteractableState, p_inventory_model: InventoryModel) -> void:
	state = pi_state
	inventory_model = p_inventory_model
	
func set_target(i_target: InteractableArea) -> void:
	state.target = i_target
	
func interact() -> void:
	if not state.target:
		return
	state.target.interact(inventory_model)
