extends Node2D
class_name InventoryState

signal inventory_updated(state: InventoryState)

var is_opened = false
var slots: Dictionary[int, InventorySlotData] = {}
var capacity: int = 0

func setup(capacity: int):
	set_capacity(capacity)
	
func set_is_opened(value: bool):
	if is_opened == value:
		return
	is_opened = value
	emit_signal("inventory_updated", self)
	
func set_slots(new_slots: Dictionary[int, InventorySlotData]) -> void:
	slots = new_slots
	emit_signal("inventory_updated", self)
	
func set_capacity(value: int):
	capacity = value
	emit_signal("inventory_updated", self)
