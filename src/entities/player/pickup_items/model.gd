extends Node2D
class_name PlayerPickupItemsModel

signal picked_up(item: Item)

var state: PlayerPickupItemsState

func setup(ppi_state: PlayerPickupItemsState):
	state = ppi_state

func add_item_in_range(item: Pickup) -> void:
	state.items_in_range[item] = true
	
func remove_item_from_range(item: Pickup) -> void:
	state.items_in_range.erase(item)
	
func pickup() -> void:
	if state.items_in_range.size() == 0:
		return
	var items = state.items_in_range.keys()
	var intent_to_pickup: Pickup = items.pop_front()
	emit_signal("picked_up", intent_to_pickup.pickup())
